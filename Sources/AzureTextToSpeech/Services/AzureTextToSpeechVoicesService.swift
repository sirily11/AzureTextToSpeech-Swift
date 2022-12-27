//
//  File.swift
//
//
//  Created by Qiwei Li on 12/26/22.
//

import Alamofire
import Foundation

class AzureTextToSpeechVoicesService {
    private var accessToken: String?
    private var region: AzureRegion?
    var hasInitialized: Bool {
        get {
            return accessToken != nil && region != nil
        }
    }
    
    init(){
        accessToken = nil
        region = nil
    }

    /**
     Initialize azure text to speech voices service
     - Parameters:
        - accessToken: The access token
     */
    func initialize(accessToken: String, region: AzureRegion) {
        self.accessToken = accessToken
        self.region = region
    }

    /**
     Get the list of voices from Azure Text to Speech API
     - Returns: The list of voices
     */
    public func getListofVoices() async throws -> [AzureVoice] {
        guard let region = region else {
            throw AzureErrors.noRegion
        }
        
        guard let accessToken = accessToken else {
            throw AzureErrors.noAccessToken
        }
        
        let url = "https://\(region.rawValue).tts.speech.microsoft.com/cognitiveservices/voices/list"

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]

        let response = AF.request(url, method: .get, headers: headers).serializingDecodable([AzureVoice].self)
        let result = try await response.value
        return result
    }

    /**
     Get the list of unique locales from the list of voices
     - Parameters:
         - voices: The list of voices
     - Returns: The list of unique locales
     */
    public static func getListOfUniqueLocales(voices: [AzureVoice]) -> [String] {
        var locales: [String] = []
        for voice in voices {
            if !locales.contains(voice.locale) {
                locales.append(voice.locale)
            }
        }
        return locales
    }

    /**
     Get the list of unique voice types from the list of voices
     - Parameters:
         - voices: The list of voices
     - Returns: The list of unique voice types
     */
    public static func getListOfUniqueVoiceTypes(voices: [AzureVoice]) -> [String] {
        var voiceTypes: [String] = []
        for voice in voices {
            if !voiceTypes.contains(voice.voiceType) {
                voiceTypes.append(voice.voiceType)
            }
        }
        return voiceTypes
    }

    /**
      Get the list of unique
         - Parameters:
             - voices: The list of voices
         - Returns: The list of unique genders
     */
    public static func getListOfUniqueGenders(voices: [AzureVoice]) -> [String] {
        var voiceGenders: [String] = []
        for voice in voices {
            if !voiceGenders.contains(voice.gender) {
                voiceGenders.append(voice.gender)
            }
        }
        return voiceGenders
    }

    public static func filterVoices(voices: [AzureVoice], locale: String? = nil, voiceType: String? = nil, gender: String? = nil) -> [AzureVoice] {
        var filteredVoices: [AzureVoice] = []
        for voice in voices {
            if locale != nil, voice.locale != locale {
                continue
            }
            if voiceType != nil, voice.voiceType != voiceType {
                continue
            }

            if gender != nil, voice.gender != gender {
                continue
            }

            filteredVoices.append(voice)
        }

        return filteredVoices
    }
}
