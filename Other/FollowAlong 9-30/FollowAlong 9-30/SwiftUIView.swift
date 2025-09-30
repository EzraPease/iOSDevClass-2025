//
//  SwiftUIView.swift
//  FollowAlong 9-30
//
//  Created by Ezra Pease on 9/30/25.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var isOn = false
    @State private var textFieldText = ""
    @State private var secureFieldText = ""
    @State private var sliderValue = 0.0
    @State private var pickerValue = "Option 1"
    
    var body: some View {
        VStack(spacing: 30) {
            Toggle("This is a toggle", isOn: $isOn)
            Toggle(isOn: $isOn) {
                Label("MTech", systemImage: "dog.fill")
            }
            .tint(.blueberryBlue)
            
            TextField("This is a text field", text: $textFieldText, prompt: Text("This is a prompt").font(.custom("Zapfino", size: 18)), axis: .vertical)
                .textFieldStyle(.roundedBorder)
            
            SecureField("This is a secure field", text: $secureFieldText)
            
            VStack {
                Text("The slider value is \(sliderValue)")
                Slider(value: $sliderValue)
                
                Slider(value: $sliderValue, in: 0...10, step: 10) {
                    editing in
                    print("Is editing slider \(editing)")
                }
            }
            Picker("My Picker", selection: $pickerValue) {
                ForEach(["Option 1", "Option 2", "Option 3"], id: \.self) {
                    item in
                    Text(item)
                        .tag(item)
                }
            }
            
        }
        .padding()
    }
}

#Preview {
    SwiftUIView()
}
