//
//  File.swift
//  
//
//  Created by John Patrick Teruel on 10/2/23.
//

import Foundation

struct PreviewEstablishConnectionDataSource: EstablishConnectionRepository {
    private func getNanoseconds(seconds: UInt64 = 5) -> UInt64 {
        return seconds * 1_000_000_000
    }
    private func dummyURL() -> URL {
        return URL(string: "https://www.google.com")!
    }
    
    func establishAutomaticConnection() async throws -> URL {
        print("Establishing automatic connection...")
        try await Task.sleep(nanoseconds: getNanoseconds(seconds: 1))
//        let message = "Unable to establish connection."
//        throw NSError(domain: "KRK-v2", code: 1, userInfo: [NSLocalizedDescriptionKey: message])
        return dummyURL()
    }
    
    func establishManualConnection(host: String, port: Int) async throws -> URL  {
        print("Establishing manual connection...")
        print("Host: \(host)")
        print("Port: \(port)")
        try await Task.sleep(nanoseconds: getNanoseconds(seconds: 1))
        return dummyURL()
    }
    
    func establishConnection(with url: String) async throws -> URL  {
        print("Establishing connection...")
        print("URL: \(url)")
        try await Task.sleep(nanoseconds: getNanoseconds(seconds: 1))
        return dummyURL()
    }
    
    func setupBaseURL(_ url: URL) {
        print("Setting up base URL...")
        print("URL: \(url)")
    
    }
}
