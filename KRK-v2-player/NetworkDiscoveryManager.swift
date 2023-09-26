//
//  NetworkDiscoveryManager.swift
//  KRK-v2-player
//
//  Created by John Patrick Teruel on 9/23/23.
//

import Foundation
import Network

class NetworkDiscoveryManager: NSObject {
    lazy var browser: NetServiceBrowser = {
        let b = NetServiceBrowser()
        b.delegate = self
        return b
    }()
    
    var serviceFound: NetService?
    
    override init() {
        super.init()
        
        print("init")
        self.discover()
    }
    
    func discover() {
        print("discover")
        browser.searchForServices(ofType: "_http._tcp", inDomain: "local")
    }
}

extension NetworkDiscoveryManager: NetServiceBrowserDelegate {
    func netServiceBrowserWillSearch(_ browser: NetServiceBrowser) {
        print("netServiceBrowserWillSearch")
    }
    
    func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        print("netServiceBrowserDidStopSearch")
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        print("didNotSearch")
        print(errorDict)
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFindDomain domainString: String, moreComing: Bool) {
        print("didFindDomain")
        print(domainString)
    
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        print("didFind")
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
        print("didRemoveDomain")
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        print("didRemove")
    }
}

extension NetworkDiscoveryManager: NetServiceDelegate {
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
        
        if let host = sender.hostName {
            let port = sender.port
            let url = URL(string: "http://\(host):\(port)")
            print(url)
            URLSession.shared.dataTask(with: url!) { data, response, error in
                if let error = error {
                    print(error)
                }
                if let data = data {
                    print(data)
                    let str = String(decoding: data, as: UTF8.self)
                    print(str)
                }
            }.resume()
          }
     
    }
    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        print("didNotResolve")
        print(errorDict)
    }
    func netServiceDidStop(_ sender: NetService) {
        print("netServiceDidStop")
    }
    func netService(_ sender: NetService, didUpdateTXTRecord data: Data) {
        print("didUpdateTXTRecord")
    }
    
}
