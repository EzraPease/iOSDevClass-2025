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
        
        ScrollView {
            VStack {
                Stepper(value: $apiRequest.userAmount, in: 1...5000) {
                    Text("User Amount: \(apiRequest.userAmount)")
                }
                .padding()
                
                Toggle("Location Info", isOn: $viewModel.showLocation)
                    .padding()
                
                Toggle("Contact Info", isOn: $viewModel.showContact)
                    .padding()
                
                Toggle("Date of Birth & Age", isOn: $viewModel.showDobAndAge)
                    .padding()
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.mint.gradient)
            }
            .padding()
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    RootView()
}
