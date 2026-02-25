//
//  RandomUserSettingsView.swift
//  Interview Pt. 2 API
//
//  Created by Ezra Pease on 2/25/26.
//

import SwiftUI

struct RandomUserSettingsView: View {
    @Environment(API.self) private var apiRequest
    @Environment(RandomUserViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var apiRequest = apiRequest
        @Bindable var viewModel = viewModel
        
        VStack {
            Stepper(value: $apiRequest.userAmount, in: 1...5000) {
                Text("User Amount: \(apiRequest.userAmount)")
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.mint.gradient)
            }
            
            Toggle("Title Info", isOn: $viewModel.showTitle)
        }
        .padding()
    }
}

#Preview {
    RootView()
}
