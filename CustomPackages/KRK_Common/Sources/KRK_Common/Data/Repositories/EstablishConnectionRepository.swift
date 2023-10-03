//
//  EstablishConnectionRepository.swift
//
//
//  Created by John Patrick Teruel on 9/27/23.
//

import Foundation

public protocol EstablishConnectionRepository {
    func establishAutomaticConnection() async throws -> URL
    func establishManualConnection(host: String, port: Int) async throws -> URL
    func establishConnection(with url: String) async throws -> URL
    func setupBaseURL(_ url: URL)
}
