//
//  File.swift
//
//
//  Created by Qiwei Li on 12/26/22.
//

import Alamofire
import Foundation

class AzureTextToSpeechAuthenticationService {
    private var apiKey: String?
    private var region: AzureRegion?
    private var tokenURL: String?
    
    init() {
        
    }
    

    /**
     Initialize the Azure Text to Speech Authentication Service
     - Parameters:
         - apiKey: The API key
         - region: The region
     */
    func initialize(apiKey: String, region: AzureRegion) {
        self.apiKey = apiKey
        self.region = region
        tokenURL = "https://\(region.rawValue).api.cognitive.microsoft.com/sts/v1.0/issuetoken"
    }

    /**
     Get the token from Azure Text to Speech API
     - Returns: The token
     */
    func getToken() async throws -> String {
        guard let apiKey = apiKey else {
            throw AzureErrors.noAccessToken
        }
        
        guard let tokenURL = tokenURL else {
            throw AzureErrors.noAccessToken
        }
        
        let headers: HTTPHeaders = [
            "Ocp-Apim-Subscription-Key": apiKey,
        ]
        
        let response = AF.request(tokenURL, method: .post, headers: headers).serializingString()
        let result = await response.response
        if result.response?.statusCode == 401 {
            throw AzureErrors.invalidResouceKey
        }
    
        
        let value = try await response.value
        return value
    }
}
