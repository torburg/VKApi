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
    case error
}

class NetworkManager {
    
    func authorize(completion: (AuthResponse)->()) {
        completion(AuthResponse.success)
    }
}
