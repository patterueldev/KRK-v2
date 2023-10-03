//
//  ConnectionStatus.swift
//
//
//  Created by John Patrick Teruel on 10/2/23.
//

import Foundation

public enum ConnectionStatus {
    case connected
    case connecting
    case disconnected(Error?)
}
