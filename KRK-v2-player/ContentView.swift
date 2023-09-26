//
//  ContentView.swift
//  KRK-v2-player
//
//  Created by John Patrick Teruel on 9/23/23.
//

import SwiftUI

struct ContentView: View {
    let manager: NetworkDiscoveryManager
    
    init(manager: NetworkDiscoveryManager = NetworkDiscoveryManager()) {
        print("ContentView init")
        self.manager = manager
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
