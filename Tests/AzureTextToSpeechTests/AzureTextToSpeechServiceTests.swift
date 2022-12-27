//
//  AzureTextToSpeechServiceTests.swift
//  
//
//  Created by Qiwei Li on 12/26/22.
//

import XCTest
@testable import AzureTextToSpeech

final class AzureTextToSpeechServiceTests: XCTestCase {

    func testGenerateXML() throws {
      let service = AzureTextToSpeechService()
        service.pickVoice(voice: .init(name: "a", displayName: "a", localName: "a", shortName: "a", gender: "a", locale: "a", localeName: "a", styleList: [], rolePlayList: nil, sampleRateHertz: "", voiceType: "", status: "", extendedPropertyMap: [:], wordsPerMinute: "1"))
      
      let xml = try service.getXML(text: "hello")
      XCTAssertTrue(xml.count > 20)
    }

}
