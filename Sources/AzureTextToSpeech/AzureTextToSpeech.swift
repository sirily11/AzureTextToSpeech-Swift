#if os(macOS)
import Combine
import Foundation

public class AzureTextToSpeech: ObservableObject {
    private var authenticationService: AzureTextToSpeechAuthenticationService
    private var voicesService: AzureTextToSpeechVoicesService
    private var speechService: AzureTextToSpeechService
    private var region: AzureRegion?
    
    @Published public var voices: [AzureVoice] = []
    @Published var selectedLocale: String?
    @Published var selectedVoiceType: String?
    @Published var selectedGender: String?
    @Published var selectedVoice: AzureVoice?
    @Published var selectedFormat: AzureAudioFormat = .defaultFormat
    
    public var locales: [String] {
        get {
            return AzureTextToSpeechVoicesService.getListOfUniqueLocales(voices: voices)
        }
    }
    
    public var genders: [String] {
        get {
            return AzureTextToSpeechVoicesService.getListOfUniqueGenders(voices: voices)
        }
    }
    
    public var types: [String] {
        get {
            return AzureTextToSpeechVoicesService.getListOfUniqueVoiceTypes(voices: voices)
        }
    }
    
    public var isDisabledForSelection: Bool {
        get {
            return voices.count == 0
        }
    }
    
    public var filteredVoices: [AzureVoice] {
        get {
            return AzureTextToSpeechVoicesService.filterVoices(voices: voices, locale: selectedLocale, voiceType: selectedVoiceType, gender: selectedGender)
        }
    }
    
    public init() {
        self.authenticationService = .init()
        self.speechService = .init()
        self.voicesService = .init()
    }
    
    
    /**
     Authorize services. Need to call this function first in order to use other services
     */
    public func authorize(resourceKey: String, region: AzureRegion) async throws {
        self.region = region
        authenticationService.initialize(apiKey: resourceKey, region: region)
        let key = try await authenticationService.getToken()
        voicesService.initialize(accessToken: key, region: region)
        speechService.initialize(accessToken: key, region: region)
    }
    
    @MainActor
    public func getListOfVoices() async throws -> [AzureVoice] {
        if !voicesService.hasInitialized {
            throw AzureErrors.unauthorized
        }
        
        let voices = try! await voicesService.getListofVoices()
        self.voices = voices
        return voices
    }
    
    @MainActor
    public func filter(gender: String, locale: String, voiceType: String) {
        if gender.count > 0 {
            selectedGender = gender
        }
        
        if locale.count > 0 {
            selectedLocale = locale
        }
        
        if voiceType.count > 0 {
            selectedVoiceType = voiceType
        }
    }
    
    @MainActor
    public func pickVoice(voice: AzureVoice) {
        self.selectedVoice = voice
        speechService.pickVoice(voice: voice)
    }
    
    @MainActor
    public func pickFormat(format: AzureAudioFormat) {
        self.selectedFormat = format
        speechService.pickFormat(format: format)
    }
    
    public func generateForDownload(text: String, destination: URL, onStart: @escaping () -> (),  onDownload: @escaping OnDownload) async throws {
        guard let _ = selectedVoice else {
            throw AzureErrors.noSelectedVoice
        }
        onStart()
        _ = try await speechService.saveToFile(text: text, destination: destination, onDownload: onDownload)
    }
}
#else
import Foundation

public class AzureTextToSpeech {
    private var authenticationService: AzureTextToSpeechAuthenticationService
    private var voicesService: AzureTextToSpeechVoicesService
    private var speechService: AzureTextToSpeechService
    private var region: AzureRegion?
    
    public var voices: [AzureVoice] = []
    var selectedLocale: String?
    var selectedVoiceType: String?
    var selectedGender: String?
    var selectedVoice: AzureVoice?
    var selectedFormat: AzureAudioFormat = .defaultFormat
    
    public var locales: [String] {
        get {
            return AzureTextToSpeechVoicesService.getListOfUniqueLocales(voices: voices)
        }
    }
    
    public var genders: [String] {
        get {
            return AzureTextToSpeechVoicesService.getListOfUniqueGenders(voices: voices)
        }
    }
    
    public var types: [String] {
        get {
            return AzureTextToSpeechVoicesService.getListOfUniqueVoiceTypes(voices: voices)
        }
    }
    
    public var isDisabledForSelection: Bool {
        get {
            return voices.count == 0
        }
    }
    
    public var filteredVoices: [AzureVoice] {
        get {
            return AzureTextToSpeechVoicesService.filterVoices(voices: voices, locale: selectedLocale, voiceType: selectedVoiceType, gender: selectedGender)
        }
    }
    
    public init() {
        self.authenticationService = .init()
        self.speechService = .init()
        self.voicesService = .init()
    }
    
    
    /**
     Authorize services. Need to call this function first in order to use other services
     */
    public func authorize(resourceKey: String, region: AzureRegion) async throws {
        self.region = region
        authenticationService.initialize(apiKey: resourceKey, region: region)
        let key = try await authenticationService.getToken()
        voicesService.initialize(accessToken: key, region: region)
        speechService.initialize(accessToken: key, region: region)
    }
    
    public func getListOfVoices() async throws -> [AzureVoice] {
        if !voicesService.hasInitialized {
            throw AzureErrors.unauthorized
        }
        
        let voices = try! await voicesService.getListofVoices()
        self.voices = voices
        return voices
    }
    
    public func filter(gender: String, locale: String, voiceType: String) {
        if gender.count > 0 {
            selectedGender = gender
        }
        
        if locale.count > 0 {
            selectedLocale = locale
        }
        
        if voiceType.count > 0 {
            selectedVoiceType = voiceType
        }
    }
    
    public func pickVoice(voice: AzureVoice) async {
        self.selectedVoice = voice
        speechService.pickVoice(voice: voice)
    }
    
    public func pickFormat(format: AzureAudioFormat) async {
        self.selectedFormat = format
        speechService.pickFormat(format: format)
    }
    
    public func generateForDownload(text: String, destination: URL, onStart: @escaping () -> (),  onDownload: @escaping OnDownload) async throws {
        guard let _ = selectedVoice else {
            throw AzureErrors.noSelectedVoice
        }
        onStart()
        _ = try await speechService.saveToFile(text: text, destination: destination, onDownload: onDownload)
    }
}
#endif
