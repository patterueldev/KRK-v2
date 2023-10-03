//
//  StartUpViewModel.swift
//  KRK-v2-controller
//
//  Created by John Patrick Teruel on 9/27/23.
//

import SwiftUI
import KRK_Common

protocol StartUpViewModel: ObservableObject {
    var status: ConnectionStatus { get }
    var message: String { get }
    var navigatesToReservations: Bool { get set }
    
    func establishConnection()
}

class DefaultStartUpViewModel: StartUpViewModel {
    let dependencyManager: DependencyManager
    
    lazy var useCase: EstablishConnectionUseCase = dependencyManager.resolve()
    
    init(dependencyManager: DependencyManager) {
        self.dependencyManager = dependencyManager
        self.establishConnection()
    }
    
    @Published var status: ConnectionStatus = .disconnected(nil)
    @Published var message: String = ""
    @Published var navigatesToReservations: Bool = false
    
    func establishConnection() {
        Task {
            for await status in useCase.executeAndObserve(type: .automatic) {
                await MainActor.run {
                    switch status {
                    case .connecting:
                        print("Connecting...")
                        self.message = "Attempting to Connect..."
                    case .connected:
                        print("Connected!")
                        self.message = "Connected!"
                        self.navigatesToReservations = true
                    case let .disconnected(error):
                        print("Disconnected with error: \(String(describing: error))")
                        if let error = error {
                            self.message = "\(error.localizedDescription)"
                        
                        } else {
                            self.message = "Disconnected"
                        }
                    }
                    self.status = status
                }
            }
        }
    }
}
