// The Swift Programming Language
// https://docs.swift.org/swift-book

import KRK_Common

public struct KRKAPI {
    public static func updateDependencies(manager: DependencyManager) {
        manager.register(type: EstablishConnectionRepository.self) {
            EstablishConnectionDataSource(
                networkDiscoveryManager: $0.resolve(),
                apiManager: $0.resolve()
            )
        }
        manager.register(type: NetworkDiscoveryManager.self) { _ in
            DefaultNetworkDiscoveryManager()
        }
        manager.register(type: APIManager.self) { _ in
            DefaultAPIManager()
        }
    }
    
    private init() { fatalError("KRKAPI should not be initialized") }
}
