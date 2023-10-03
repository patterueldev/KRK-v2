//
//  StartUpView.swift
//  KRK-v2-controller
//
//  Created by John Patrick Teruel on 9/27/23.
//

import SwiftUI
import KRK_Common

struct StartUpView<ViewModel: StartUpViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(viewModel.message)
                if case .disconnected = viewModel.status {
                    Button("Retry") {
                        viewModel.establishConnection()
                    }.frame(maxWidth: .infinity)
                    Button("Enter Host and Port") {
                        // TODO: will open a modal
                    }
                    Button("Enter URL") {
                        // TODO: will open a modal
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationDestination(isPresented: $viewModel.navigatesToReservations) {
                ReservedSongsView()
            }
        }
    }
}

#Preview {
    let dependencyManager = KRKCommon.previewDependencyManager()
    let viewModel = DefaultStartUpViewModel(dependencyManager: dependencyManager)
    return StartUpView(viewModel: viewModel)
}
