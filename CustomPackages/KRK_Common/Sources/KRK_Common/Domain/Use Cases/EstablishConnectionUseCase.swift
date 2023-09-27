//
//  EstablishConnectionUseCase.swift
//
//
//  Created by John Patrick Teruel on 9/27/23.
//

import Foundation

public protocol EstablishConnectionUseCase {
    func execute(type: ConnectionType) async throws
}
