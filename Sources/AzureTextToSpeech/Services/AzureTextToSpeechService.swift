//
//  File.swift
//
//
//  Created by Qiwei Li on 12/26/22.
//

import AEXML
import Alamofire
import Foundation

public typealias OnDownload = (Int64) -> Void
public typealias OnStreamData = (Data) -> Void

class AzureTextToSpeechService {
    private var accessToken: String?
    private var region: AzureRegion?
    private var format: AzureAudioFormat?
    private var voice: AzureVoice?

    init() {}

    /**
     Initialize azure text to speech service
     - Parameters:
        - accessToken: The access token
        - region: The region
     */
    func initialize(accessToken: String, region: AzureRegion) {
        self.accessToken = accessToken
        self.region = region
    }

    /**
     Pick voice fore azure text to speech service
     - Parameters:
         - voice: The voice
     */
    func pickVoice(voice: AzureVoice) {
        self.voice = voice
    }

    /**
     Pick format fore azure text to speech service
     - Parameters:
         - format: The format
     */
    func pickFormat(format: AzureAudioFormat) {
        self.format = format
    }

    /**
     XML content
     - Parameters:
         - text: The text to be converted to speech
     - Returns: The XML content
     */
    func getXML(text: String) throws -> String {
        guard let voice = voice else {
            throw AzureErrors.noVoice
        }

        let xml = try AzureSSML(text: text, voice: voice, pitch: 1, rate: 0).getXML()
        return xml
    }

    private func getHeader() throws -> (String, HTTPHeaders) {
        guard let format = format else {
            throw AzureErrors.noFormat
        }

        guard let region = region else {
            throw AzureErrors.noRegion
        }

        guard let accessToken = accessToken else {
            throw AzureErrors.noAccessToken
        }

        let url = "https://\(region.rawValue).tts.speech.microsoft.com/cognitiveservices/v1"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/ssml+xml",
            "X-Microsoft-OutputFormat": "\(format.rawValue)",
            "User-Agent": "AzureTextToSpeech",
        ]

        return (url, headers)
    }

    /**
     Save the audio file to the destination
     - Parameters:
         - text: The text to be converted to speech
         - destination: The destination to save the audio file
         - onDownload: The progress of the download
     - Returns: The destination of the audio file
     */
    func saveToFile(text: String, destination: URL, onDownload: @escaping OnDownload) async throws -> URL {
        let (url, headers) = try getHeader()
        let xml = try getXML(text: text)
        let data = xml.data(using: .utf8)!
        var request = try URLRequest(url: URL(string: url)!, method: .post, headers: headers)
        request.httpBody = data

        let downloadDestination: DownloadRequest.Destination = { _, _ in
            (destination, [.removePreviousFile, .createIntermediateDirectories])
        }

        let task = AF.download(request, to: downloadDestination).downloadProgress { progress in
            onDownload(progress.completedUnitCount)
        }.serializingDownloadedFileURL()

        let response = await task.response
        if response.response?.statusCode != 200 {
            throw AzureErrors.noAudioData
        }
        let downloadURL = try await task.value
        return downloadURL
    }

    /**
     Get the audio data
     - Parameters:
         - text: The text to be converted to speech
         - onStream: The audio data
     - Returns: The audio data
     */
    func getStream(text: String, onStream: @escaping OnStreamData) async throws -> Data {
        let (url, headers) = try getHeader()
        let xml = try getXML(text: text)
        let data = xml.data(using: .utf8)!

        let task = AF.request(url, method: .post, parameters: data, headers: headers).response { response in
            if let error = response.error {
                print(error)
            }
            guard let data = response.data else {
                return
            }
            onStream(data)
        }.serializingData()

        let responseData = try await task.value
        return responseData
    }
}
