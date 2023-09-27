//
//  ConnectionType.swift
//  
//
//  Created by John Patrick Teruel on 9/27/23.
//

import Foundation

public enum ConnectionType {
    case automatic // will be detected by bonjour
    case manual(host: String, port: Int)
    case url(url: URL)
}
