//
//  ContentView.swift
//  Hotel Registration App
//
//  Created by Jane Madsen on 9/26/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            HotelRegistrationScreen()
        }
    }
}

struct HotelRegistrationScreen: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var doorCode = ""
    @State private var numberOfGuests = 1
    @State private var lengthOfStay = 1
    @State private var nonSmoking = false
    @State private var regristrationFeedback = ""
    
    
    var body: some View {
        VStack {
            HStack {
                Image("mountainlandLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Text("Mountainland Inn")
                    .font(.custom("Verdana", size: 30))
                    .bold()
                    .foregroundStyle(Color.background)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.highlight)
                    }
            }
            
            HStack {
                TextField("", text: $firstName, prompt: Text("First Name").font(.custom("Rockwell", size: 20)), axis: .horizontal)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                
                TextField("", text: $lastName, prompt: Text("Last Name").font(.custom("Rockwell", size: 20)), axis: .horizontal)
                    .padding()
                    .textFieldStyle(.roundedBorder)
            }
            
            SecureField("", text: $doorCode, prompt: Text("Input Desired Code").font(.custom("Rockwell", size: 20)))
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            
            Stepper("Number of Guests: \(numberOfGuests)",
                    value: $numberOfGuests,
                    in: 1...20,
                    step: 1)
            .font(.custom("Rockwell", size: 18))
            .frame(maxWidth: .infinity)
            .padding()
            .glassEffect()
            .padding()
            
            Stepper("Staying for \(lengthOfStay) days",
                    value: $lengthOfStay,
                    in: 1...30,
                    step: 1)
            .font(.custom("Rockwell", size: 18))
            .frame(maxWidth: .infinity)
            .padding()
            .glassEffect()
            .padding()
            
            
            Spacer()
            
            Text("Welcome!")
                .font(.custom("Rockwell", size: 20))
                .foregroundStyle(.text)
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
