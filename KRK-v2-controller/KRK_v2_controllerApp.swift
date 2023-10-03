//
//  KRK_v2_controllerApp.swift
//  KRK-v2-controller
//
//  Created by John Patrick Teruel on 9/26/23.
//

import SwiftUI
import KRK_Common
import KRK_APICommon

@main
struct KRK_v2_controllerApp: App {
    let dependencyManager: DependencyManager
    
    init() {
        self.dependencyManager = KRKCommon.buildDependencyManager()
        KRKAPI.updateDependencies(manager: self.dependencyManager)
    }
    
    var body: some Scene {
        WindowGroup {
            StartUpView(
                viewModel: DefaultStartUpViewModel(
                    dependencyManager: dependencyManager
                )
            )
        }
    }
}
