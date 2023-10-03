//
//  NetworkDiscoveryManager.swift
//  KRK-v2-player
//
//  Created by John Patrick Teruel on 9/23/23.
//

import Foundation
import Network

protocol NetworkDiscoveryManager {
    func discoverHost() async throws -> URL
}

class DefaultNetworkDiscoveryManager: NSObject, NetworkDiscoveryManager {
    lazy var browser: NetServiceBrowser = {
        let b = NetServiceBrowser()
        b.delegate = self
        return b
    }()
    
    var serviceFound: NetService?
    private var continuation: CheckedContinuation<URL, Error>?
    
    func discover() {
        print("discover")
        browser.searchForServices(ofType: "_http._tcp", inDomain: "local")
    }
    
    // MARK: - NetworkDiscoveryManager
    func discoverHost() async throws -> URL {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            DispatchQueue.main.async {
                self.discover()
            }
        }
    }
}

extension DefaultNetworkDiscoveryManager: NetServiceBrowserDelegate {
    func netServiceBrowserWillSearch(_ browser: NetServiceBrowser) {
        print("netServiceBrowserWillSearch")
    }
    
    func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        print("netServiceBrowserDidStopSearch")
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        print("netServiceBrowserDidNotSearch")
        print(errorDict)
        let message = errorDict.reduce("") { (result, dict) -> String in
            return result + "\(dict.key): \(dict.value)\n"
        }
        continuation?.resume(throwing: NSError(domain: "NetworkDiscoveryManager", code: 0, userInfo: [NSLocalizedDescriptionKey: message]))
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFindDomain domainString: String, moreComing: Bool) {
        print("netServiceBrowserDidFindDomain")
        print(domainString)
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        print("netServiceBrowserDidFindService")
        print(service)
        let msg = """
        Name: \(service.name)
            Type: \(service.type)
            Domain: \(service.domain)
            Port: \(service.port)
            Host: \(String(describing: service.hostName))
            TXT: \(String(describing: service.txtRecordData()))
            More coming: \(moreComing)
        """
        print(msg)
        
        if service.name == "KRK v2" {
            self.serviceFound = service
            self.serviceFound?.delegate = self
            self.serviceFound?.resolve(withTimeout: 2.0)
        }
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemoveDomain domainString: String, moreComing: Bool) {
        print("netServiceBrowserDidRemoveDomain")
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        print("netServiceBrowserDidRemoveService")
    }
}

extension DefaultNetworkDiscoveryManager: NetServiceDelegate {
    func netServiceWillPublish(_ sender: NetService) {
        print("netServiceWillPublish")
    }
    
    func netServiceDidPublish(_ sender: NetService) {
        print("netServiceDidPublish")
    }
    
    func netServiceWillResolve(_ sender: NetService) {
        print("netServiceWillResolve")
    }
    func netServiceDidResolveAddress(_ sender: NetService) {
        print("netServiceDidResolveAddress")
        print(sender)
        let msg = """
        Name: \(sender.name)
            Type: \(sender.type)
            Domain: \(sender.domain)
            Port: \(sender.port)
            Host: \(String(describing: sender.hostName))
            TXT: \(String(describing: sender.txtRecordData()))
        """
        print(msg)
        
        guard let host = sender.hostName else {
            continuation?.resume(throwing: NSError(domain: "KRK-v2", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to resolve host."]))
            return
        }
     
        
        let port = sender.port
        guard let url = URL(string: "http://\(host):\(port)") else {
            continuation?.resume(throwing: NSError(domain: "KRK-v2", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to resolve host."]))
            return
        }
        continuation?.resume(returning: url)
    }
    
    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        print("didNotResolve")
        print(errorDict)
        continuation?.resume(throwing: NSError(domain: "KRK-v2", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to resolve host."]))
    }
    func netServiceDidStop(_ sender: NetService) {
        print("netServiceDidStop")
    }
    func netService(_ sender: NetService, didUpdateTXTRecord data: Data) {
        print("didUpdateTXTRecord")
    }
    
}
