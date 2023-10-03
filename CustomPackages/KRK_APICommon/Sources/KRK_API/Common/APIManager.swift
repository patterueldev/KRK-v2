//
//  APIManager.swift
//
//
//  Created by John Patrick Teruel on 10/2/23.
//

import Foundation

protocol APIManager {
    func setupBaseURL(_ url: URL)
}

class DefaultAPIManager: APIManager {
    private var baseURL: URL?
    
    func setupBaseURL(_ url: URL) {
        self.baseURL = url
    }
}

