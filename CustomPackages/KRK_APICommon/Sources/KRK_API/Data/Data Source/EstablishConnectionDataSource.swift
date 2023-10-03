//
//  EstablishConnectionDataSource.swift
//
//
//  Created by John Patrick Teruel on 9/27/23.
//

import Foundation
import KRK_Common

struct EstablishConnectionDataSource: EstablishConnectionRepository {
    let manager: NetworkDiscoveryManager
    let apiManager: APIManager
    
    init(networkDiscoveryManager: NetworkDiscoveryManager, apiManager: APIManager) {
        self.manager = networkDiscoveryManager
        self.apiManager = apiManager
    }
    
    func establishAutomaticConnection() async throws -> URL {
        return try await manager.discoverHost()
    }
    
    func establishManualConnection(host: String, port: Int) async throws -> URL {
        throw NSError(domain: "Not yet implemented", code: 0, userInfo: nil)
    }
    
    func establishConnection(with url: String) async throws -> URL {
        throw NSError(domain: "Not yet implemented", code: 0, userInfo: nil)
    }
    
    func setupBaseURL(_ url: URL) {
        apiManager.setupBaseURL(url)
    }
}
