//
//  DependencyManager.swift
//
//
//  Created by John Patrick Teruel on 9/27/23.
//

import Foundation

public class DependencyManager {
    var container: [String: Any] = [:]
    
    public func register<T>(instance: T) {
        container[String(describing: T.self)] = instance
    }
    
    public func resolve<T>() -> T {
        guard let instance = container[String(describing: T.self)] as? T else {
            fatalError("Dependency not registered")
        }
        return instance
    }
}
