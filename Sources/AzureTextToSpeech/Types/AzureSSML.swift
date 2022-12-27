//
//  File.swift
//
//
//  Created by Qiwei Li on 12/27/22.
//

import Foundation
import AEXML

public class AzureSSML {
    public var text: String
    public var voice: AzureVoice
    public var pitch: Double
    public var rate: Double

    public init(text: String, voice: AzureVoice, pitch: Double, rate: Double) {
        self.text = text
        self.voice = voice
        self.pitch = pitch
        self.rate = rate
    }

    public func getXML() throws -> String {
        if text.isEmpty {
            throw AzureErrors.noText
        }
        
        let document = AEXMLDocument()
        let root = document.addChild(name: "speak", attributes: ["version": "1.0", "xmlns": "http://www.w3.org/2001/10/synthesis", "xmlns:mstts": "https://www.w3.org/2001/mstts", "xml:lang": "en-US"])
        let voiceElement = root.addChild(name: "voice", attributes: ["name": voice.shortName])
        voiceElement.addChild(name: "prosody", value: text, attributes: ["rate": "0%", "pitch": "0%"])

        let xml = document.xml
        return xml
    }
}
