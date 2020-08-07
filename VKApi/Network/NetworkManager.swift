//
//  NetworkManager.swift
//  VKApi
//
//  Created by Maksim Torburg on 30.07.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import Foundation

enum AuthResponse {
    case success
    case error(error: Error)
    case urlFailure
}

class NetworkManager {
    
    private let authLink = "https://oauth.vk.com/authorize"
    private let apiLink = "https://api.vk.com/method/"
    private let ownerId = "776211"
    private let version = "v=5.21"
    private let token = ""
    private let session = URLSession.shared
    
    func authorize(_ clientID: String, completion: @escaping (AuthResponse)->()) {
        
        let url = authLink + "?client_id=" + clientID + "&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=5.52"
        guard let authUrl = URL(string: url) else { completion(.urlFailure); return  }
        session.dataTask(with: authUrl) { [weak self] (data, response, error) in
            guard let self = self else { return }
            var authResult: AuthResponse
            defer {
                DispatchQueue.main.async {
                    completion(authResult)
                }
            }
            guard error == nil else {
                print(error!.localizedDescription)
                authResult = .error(error: error!)
                return
            }
            print(response)
            // TODO: - Verify user token
            authResult = .success
        }.resume()
    }
    
    func sendRequest() {
        
    }
    
    func createApiLink(with method: String) -> URL? {
        let urlString = apiLink + method + "?owner_id=" + ownerId + "&" + version + "&" + "access_token=" + token
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
}
