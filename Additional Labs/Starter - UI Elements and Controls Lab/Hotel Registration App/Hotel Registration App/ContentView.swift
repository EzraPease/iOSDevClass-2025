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
            Spacer()
                .background(LinearGradient(
                    colors: [.background, .highlight],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
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
    @State private var checkInDate = Date()
    @State private var checkOutDate = Date()
    @State private var codeIsHidden = true
    @State private var codeIsDisabled = false
    @State private var showValidation = false
    @Environment(\.colorScheme) private var colorScheme
    
    private let doorCodeMaxLength = 6
    private var firstNameTrimmed: String { firstName.trimmingCharacters(in: .whitespacesAndNewlines)}
    private var lastNameTrimmed: String { lastName.trimmingCharacters(in: .whitespacesAndNewlines)}
    private var doorCodeTrimmed: String { doorCode.trimmingCharacters(in: .whitespacesAndNewlines)}
    
    var isDarkMode: Bool { colorScheme == .dark }
    var canSubmit: Bool {
        !firstNameTrimmed.isEmpty &&
        !lastNameTrimmed.isEmpty &&
        !doorCodeTrimmed.isEmpty &&
        !Calendar.current.isDateInToday(checkOutDate)
    }
    
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                
                
                
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
                        .foregroundStyle(isDarkMode ? .white : .black)
                        .disabled(isSubmitted)
                    
                    TextField("", text: $lastName, prompt: Text("Last Name").font(.custom("Rockwell", size: 20)), axis: .horizontal)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .foregroundStyle(isDarkMode ? .white : .black)
                        .disabled(isSubmitted)
                }
                
                HStack {
                    if codeIsHidden {
                        SecureField("", text: $doorCode, prompt: Text("Input Code").font(.custom("Rockwell", size: 20)))
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                            .foregroundStyle(isDarkMode ? .white : .black)
                            .padding()
                            .disabled(isSubmitted)
                            .onChange(of: doorCode) { oldValue, newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                doorCode = String(filtered.prefix(doorCodeMaxLength))
                            }
                        
                        
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
                            .disabled(isSubmitted)
                            .onChange(of: doorCode) { oldValue, newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                doorCode = String(filtered.prefix(doorCodeMaxLength))
                            }
                        
                        
                        
                        Button("Hide Code") {
                            codeIsHidden = true
                            
                        }
                        .padding()
                    }
                }
                
                
                let today = Date()
                let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: today)!
                DatePicker("Checking in",
                           selection: $checkInDate,
                           in: today...nextYear,
                           displayedComponents: .date)
                .font(.custom("Rockwell", size: 18))
                .padding()
                .glassEffect()
                .padding()
                .disabled(isSubmitted)
                
                
                DatePicker("Checking out",
                           selection: $checkOutDate,
                           in: today...nextYear,
                           displayedComponents: .date)
                .font(.custom("Rockwell", size: 18))
                .padding()
                .glassEffect()
                .padding()
                .disabled(isSubmitted)
                //                Stepper("Staying for \(lengthOfStay) day(s)", //Length of stay code
                //                        value: $lengthOfStay,
                //                        in: 1...30,
                //                        step: 1)
                //                .font(.custom("Rockwell", size: 18))
                //                .frame(maxWidth: .infinity)
                //                .padding()
                //                .glassEffect()
                //                .padding()
                //                .disabled(isSubmitted)
                
                Stepper("Number of Guests: \(numberOfGuests)",
                        value: $numberOfGuests,
                        in: 1...20,
                        step: 1)
                .font(.custom("Rockwell", size: 18))
                .frame(maxWidth: .infinity)
                .padding()
                .glassEffect()
                .padding()
                .disabled(isSubmitted)
                
                
                Toggle("No Smoking", systemImage: "nosign", isOn: $nonSmoking)
                    .foregroundStyle(.red)
                    .font(.custom("Rockwell", size: 18))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .glassEffect()
                    .padding()
                    .disabled(isSubmitted)
                
                Spacer()
                
                if isSubmitted {
                    Text("Thank you for booking with us! How would you rate you experience?")
                        .foregroundStyle(.gray)
                        .bold()
                        .padding()
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
                            Text("Sorry it wasn't as good as we hoped, we will work to do better!")
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
                
                if showValidation {
                    Text("Please input: First Name, Last Name, Code, and Checkout Date")
                        .foregroundStyle(.red)
                        .bold()
                }
                
                if !isSubmitted {
                    Button("Submit") {
                        guard canSubmit else {
                            showValidation = true
                            return
                        }
                        
                        isSubmitted = true
                        showValidation = false
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
                        firstName = ""
                        lastName = ""
                        doorCode = ""
                        checkInDate = Date()
                        checkOutDate = Date()
                        lengthOfStay = 1
                        numberOfGuests = 1
                        regristrationFeedback = "5"
                        nonSmoking = false
                        
                        isSubmitted = false
                        ratingSubmitted = false
                    }
                    .padding()
                    .glassEffect()
                    .padding()
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
