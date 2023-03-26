import Foundation
/**
 Custom errors for azure text to speech service
 */
enum AzureErrors: Error {
    case noVoice
    case noFormat
    case noAccessToken
    case noRegion
    case noText
    case noData
    case noXML
    case noAudio
    case noAudioData(reason: String)
    case invalidResouceKey
    case unauthorized
    case noSelectedVoice
}

extension AzureErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noVoice:
            return NSLocalizedString("No voice selected", comment: "No voice selected")
        case .noFormat:
            return NSLocalizedString("No format selected", comment: "No format selected")
        case .noAccessToken:
            return NSLocalizedString("No access token", comment: "No access token")
        case .noRegion:
            return NSLocalizedString("No region", comment: "No region")
        case .noText:
            return NSLocalizedString("No text", comment: "No text")
        case .noData:
            return NSLocalizedString("No data", comment: "No data")
        case .noXML:
            return NSLocalizedString("No XML", comment: "No XML")
        case let .noAudio:
            return NSLocalizedString("No audio", comment: "No audio")
        case let .noAudioData(reason):
            return NSLocalizedString("No audio data", comment: "No audio data \(reason)")
        case .invalidResouceKey:
            return NSLocalizedString("Invalid resource key", comment: "Invalid resource key")
        case .unauthorized:
            return NSLocalizedString("Unauthorized", comment: "Unauthorized")
        case .noSelectedVoice:
            return NSLocalizedString("No selected voice", comment: "No selected voice")
        }
    }
}
