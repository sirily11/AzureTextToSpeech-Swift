import Foundation
/**
 azure voice
 */
public struct AzureVoice: Codable, Hashable {
    public let name: String
    public let displayName: String
    public let localName: String
    public let shortName: String
    public let gender: String
    public let locale: String
    public let localeName: String
    public let styleList: [String]?
    public let rolePlayList: [String]?
    public let sampleRateHertz: String?
    public let voiceType: String
    public let status: String?
    public let extendedPropertyMap: [String: String]?
    public let wordsPerMinute: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case displayName = "DisplayName"
        case localName = "LocalName"
        case shortName = "ShortName"
        case gender = "Gender"
        case locale = "Locale"
        case localeName = "LocaleName"
        case styleList = "StyleList"
        case sampleRateHertz = "SampleRateHertz"
        case voiceType = "VoiceType"
        case status = "Status"
        case extendedPropertyMap = "ExtendedPropertyMap"
        case wordsPerMinute = "WordsPerMinute"
        case rolePlayList = "RolePlayList"
    }
    
    public static var defaultValue: AzureVoice = AzureVoice(name: "Loading...", displayName: "Loading...", localName: "Loading...", shortName: "Loading...", gender: "Loading...", locale: "Loading...", localeName: "Loading...", styleList: nil, rolePlayList: nil, sampleRateHertz: nil, voiceType: "Loading...", status: nil, extendedPropertyMap: nil, wordsPerMinute: nil)
}
