//
//  EstablishConnectionUseCase.swift
//
//
//  Created by John Patrick Teruel on 9/27/23.
//

import Foundation

public protocol EstablishConnectionUseCase {
    func executeAndObserve(type: ConnectionType) -> AsyncStream<ConnectionStatus>
}

struct DefaultEstablishConnectionUseCase: EstablishConnectionUseCase {
    let repository: EstablishConnectionRepository
    
    func executeAndObserve(type: ConnectionType) -> AsyncStream<ConnectionStatus> {
        return AsyncStream { continuation in
            Task {
                do {
                    continuation.yield(.connecting)
                    let url: URL
                    switch type {
                    case .automatic:
                        url = try await repository.establishAutomaticConnection()
                    case let .manual(host, port):
                        url = try await repository.establishManualConnection(host: host, port: port)
                    case let .url(raw):
                        url = try await repository.establishConnection(with: raw)
                    }
                    print("URL: \(url)")
                    repository.setupBaseURL(url)
                    continuation.yield(.connected)
                } catch {
                    continuation.yield(.disconnected(error))
                }
            }
        }
    }
}
