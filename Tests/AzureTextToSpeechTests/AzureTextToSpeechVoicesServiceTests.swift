//
//  AzureTextToSpeechVoicesServiceTests.swift
//  
//
//  Created by Qiwei Li on 12/26/22.
//

import XCTest
@testable import AzureTextToSpeech
final class AzureTextToSpeechVoicesServiceTests: XCTestCase {

    func generateTestData() -> [AzureVoice]{
        let locales = ["en-US", "en-GB", "fr-FR", "de-DE"]
        let voiceTypes = ["Neural", "Standard"]
        let genders = ["Female", "Male"]

        var voices = [AzureVoice]()

        for locale in locales {
            for voiceType in voiceTypes {
                for gender in genders {
                    let voice = AzureVoice(name: "", displayName: "", localName: "", shortName: "", gender: gender, locale: locale, localeName: "", styleList: nil, rolePlayList: nil, sampleRateHertz: nil, voiceType: voiceType, status: nil, extendedPropertyMap: nil, wordsPerMinute: nil)
                    voices.append(voice)
                }
            }
        }
        return voices
    }
    
    func testFilterOnVoices() throws {
        // create list of voices
        let voices: [AzureVoice] = generateTestData()
        var results = AzureTextToSpeechVoicesService.filterVoices(voices: voices)
        XCTAssertEqual(results.count, voices.count)
        
        results = AzureTextToSpeechVoicesService.filterVoices(voices: voices, locale: "en-US")
        XCTAssertEqual(results.count, 4)
        
        results = AzureTextToSpeechVoicesService.filterVoices(voices: voices, gender: "Male")
        XCTAssertEqual(results.count, 8)
        
        results = AzureTextToSpeechVoicesService.filterVoices(voices: voices, voiceType: "Neural")
        XCTAssertEqual(results.count, 8)
        
        results = AzureTextToSpeechVoicesService.filterVoices(voices: voices, locale: "en-US", voiceType: "Neural", gender: "Male")
        XCTAssertEqual(results.count, 1)
    }
}
