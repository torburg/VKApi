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

enum RequestResult<T, U: Error> {
    case success(T)
    case failure(U)
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let authLink = "https://oauth.vk.com/authorize"
    private let apiLink = "https://api.vk.com/method/"
    private let ownerId = "776211"
    private let version = "v=5.21"
    private let token = "af86ee413ecfd87fa559e84c2c5b8d00aadc79f497e218c22e0bd519936b0d4cd520c99991f0b0094eccf"
    private let session = URLSession.shared
    
    func authorize(_ clientID: String, completion: @escaping (AuthResponse)->()) {
        
        let url = authLink + "?client_id=" + clientID + "&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=friends&response_type=token&v=5.52"
        guard let authUrl = URL(string: url) else { completion(.urlFailure); return  }
        session.dataTask(with: authUrl) { (data, response, error) in
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
            // TODO: - Verify user token
            authResult = .success
        }.resume()
    }
    
    func sendRequest(completion: @escaping (RequestResult<Result, Error>) -> ()) {
        let method = "wall.get"
        guard let url = createApiLink(with: method) else { return }
            session.dataTask(with: url) { (data, response, error) in
                if let requestError = error { completion(.failure(requestError)) }
                guard let data = data,
                    let result = try? JSONDecoder().decode(Result.self, from: data) else { return }
                completion(.success(result))
            }.resume()
    }
    
    func getImageData(from urlString: String, completion: @escaping (Data?)->()) {

        guard let url = URL(string: urlString) else {
            print("Fail to create URL from url: \(urlString)")
            completion(nil)
            return
        }
        session.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                print(error)
                completion(nil)
            }
            if let data = data {
                completion(data)
            }
        }).resume()
    }
    
    func createApiLink(with method: String) -> URL? {
        let urlString = apiLink + method + "?owner_id=" + ownerId + "&" + version + "&" + "access_token=" + token
        guard let url = URL(string: urlString) else { return nil }
        return url
    }
}
