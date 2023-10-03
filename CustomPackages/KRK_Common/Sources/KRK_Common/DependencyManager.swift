//
//  DependencyManager.swift
//
//
//  Created by John Patrick Teruel on 9/27/23.
//

import Foundation

typealias Instantiator<T> = (DependencyManager) -> T

public class DependencyManager {
    var container: [String: Instantiator<Any>]
    
    internal init() {
        self.container = [:]
    }
    
    public func register<T>(type: T.Type, instance: @escaping (DependencyManager) -> T) {
        container[String(describing: type)] = instance
    }
    
    public func resolve<T>() -> T {
        guard let instantiator = container[String(describing: T.self)] else {
            fatalError("No registered dependency for \(T.self)")
        }
        
        guard let instance = instantiator(self) as? T else {
            fatalError("Registered dependency for \(T.self) is not of type \(T.self)")
        }
        
        return instance
    }
}
