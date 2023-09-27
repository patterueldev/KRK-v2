//
//  StartUpViewModel.swift
//  KRK-v2-controller
//
//  Created by John Patrick Teruel on 9/27/23.
//

import SwiftUI
import KRK_Common

class StartUpViewModel: ObservableObject {
    let dependencyManager: DependencyManager
    
    init(dependencyManager: DependencyManager) {
        self.dependencyManager = dependencyManager
    }
    
    func establishConnection() {
        Task {
            do {
                let useCase: EstablishConnectionUseCase = dependencyManager.resolve()
                try await useCase.execute(type: .automatic)
            } catch {
                print(error)
            }
        }
    }
}
