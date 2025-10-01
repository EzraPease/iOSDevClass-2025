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
    @State private var regristrationFeedback = "5"
    @State private var isSubmitted = false
    @State private var ratingSubmitted = false
    @State private var date = Date()
    @State private var codeIsHidden = true
    @State private var codeIsDisabled = false
    
    
    var body: some View {
        VStack(spacing: 5) {
            
            
            
            HStack {
                Image("mountainlandLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Text("Mountainland Inn")
                    .font(.custom("Verdana", size: 30))
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .bold()
                    .foregroundStyle(Color.background)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.highlight)
                    }
            }
            
            Spacer()
            
            Text("Welcome!")
                .font(.custom("Rockwell", size: 20))
                .foregroundStyle(.text)
            
            Spacer()
            
            HStack {
                TextField("", text: $firstName, prompt: Text("First Name").font(.custom("Rockwell", size: 20)), axis: .horizontal)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .disabled(ratingSubmitted)
                
                TextField("", text: $lastName, prompt: Text("Last Name").font(.custom("Rockwell", size: 20)), axis: .horizontal)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .disabled(ratingSubmitted)
            }
            
            HStack {
                if codeIsHidden {
                    SecureField("", text: $doorCode, prompt: Text("Input Code").font(.custom("Rockwell", size: 20)))
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .disabled(ratingSubmitted)
                    
                    
                    Button("Show Code") {
                        codeIsHidden = false
                        codeIsDisabled = true
                    }
                    .padding()
                } else if !codeIsHidden {
                    TextField("", text: $doorCode, prompt: Text("Input Code").font(.custom("Rockwell", size: 20)))
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                        .disabled(ratingSubmitted)
                        .disabled(codeIsDisabled)
                    
                    
                    Button("Hide Code") {
                        codeIsHidden = true
                        
                    }
                    .padding()
                }
            }
            
            
            let today = Date()
            let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: today)!
            DatePicker("Date Only",
                       selection: $date,
                       in: today...nextYear,
                       displayedComponents: .date)
            .font(.custom("Rockwell", size: 18))
            .padding()
            .glassEffect()
            .padding()
            
            Stepper("Staying for \(lengthOfStay) day(s)",
                    value: $lengthOfStay,
                    in: 1...30,
                    step: 1)
            .font(.custom("Rockwell", size: 18))
            .frame(maxWidth: .infinity)
            .padding()
            .glassEffect()
            .padding()
            .disabled(ratingSubmitted)
            
            Stepper("Number of Guests: \(numberOfGuests)",
                    value: $numberOfGuests,
                    in: 1...20,
                    step: 1)
            .font(.custom("Rockwell", size: 18))
            .frame(maxWidth: .infinity)
            .padding()
            .glassEffect()
            .padding()
            .disabled(ratingSubmitted)
            
            
            Toggle("No Smoking", systemImage: "nosign", isOn: $nonSmoking)
                .foregroundStyle(.red)
                .font(.custom("Rockwell", size: 18))
                .frame(maxWidth: .infinity)
                .padding()
                .glassEffect()
                .padding()
                .disabled(ratingSubmitted)
            
            Spacer()
            
            if isSubmitted {
                Text("Thank you for booking with us! How would you rate you experience?")
                    .foregroundStyle(.gray)
                    .bold()
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                Picker("Rate Your Experience :)", selection: $regristrationFeedback) {
                    ForEach(["1", "2", "3", "4", "5"], id: \.self) {
                        rating in
                        Text(rating)
                            .tag(rating)
                    }
                }
                .disabled(ratingSubmitted)
                
                if ratingSubmitted {
                    if regristrationFeedback == "1" || regristrationFeedback == "2" || regristrationFeedback == "3" {
                        Text("Sorry it wasn't as good as we hopped, we will work to do better!")
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundStyle(.blue)
                            .bold()
                    } else {
                        Text("Thank you for rating us \(regristrationFeedback) ⭐️")
                            .foregroundStyle(.blue)
                            .bold()
                    }
                }
            }
            
            
            Spacer()
            
            if !isSubmitted {
                Button("Submit") {
                    isSubmitted = true
                }
                .padding()
                .glassEffect()
                .padding()
            } else if isSubmitted && !ratingSubmitted {
                Button("Submit Rating") {
                    ratingSubmitted = true
                }
                .padding()
                .glassEffect()
                .padding()
            } else {
                Button("Submit Another") {
                    isSubmitted = false
                    ratingSubmitted = false
                }
                .padding()
                .glassEffect()
                .padding()
            }
            
            
            
            
        }
        .background(LinearGradient(
            colors: [.background, .highlight],
            startPoint: .topLeading,
            endPoint: .bottomTrailing))
    }
}

#Preview {
    ContentView()
}
