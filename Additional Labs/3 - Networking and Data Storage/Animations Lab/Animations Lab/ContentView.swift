//
//  ContentView.swift
//  Animations Lab
//
//  Created by Ezra Pease on 12/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showCountdown = false
    @State private var countdownVisible = false
    @State private var showGo = false
    @State private var currentNumber = 3
    @State private var scale: CGFloat = 1
    @State private var opacity: Double = 1
    
    
    // Transitions Animation (Part 2)
    @State private var numberOneVisible = false
    @State private var numberTwoVisible = false
    @State private var numberThreeVisible = false
    
    var body: some View {
        VStack {
            if showCountdown {
                VStack {
                    Text("\(currentNumber)")
                        .font(.system(size: 500, weight: .bold, design: .rounded))
                        .scaleEffect(scale)
                        .opacity(opacity)
                        .transition(.opacity.combined(with: .scale))
                        .onAppear {
                            startCountdown()
                        }
                }
            } else if showGo {
                VStack {
                    Spacer()
                    
                    Text("GO!")
                        .font(.system(size: 200, weight: .bold, design: .rounded))
                        .scaleEffect(scale)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 0.28)) {
                                scale = 1
                                opacity = 1
                            }
                        }
                    Spacer()
                    
                    Button("Reset") {
                        resetView()
                    }
                }
            } else {
                Spacer()
                
                Button("Start Game") {
                    showCountdown.toggle()
                }
                .padding()
                .glassEffect()
            }
        }
    }
    
    private func changeCountDownNumber() {
        currentNumber -= 1
        
        scale = 1
        opacity = 1
        animateNumber()
        
        print("Current Number: \(currentNumber)")
    }
    
    private func resetView() {
        scale = 1
        opacity = 1
        currentNumber = 3
        showGo = false
        showCountdown = false
        numberOneVisible = false
        numberTwoVisible = false
        numberThreeVisible = false
    }
    
    private func startCountdown() {
        scale = 1
        opacity = 1
        currentNumber = 3
        
        animateNumber()
    }
    
    private func animateNumber() {
        withAnimation {
            countdownVisible.toggle()
            print("Countdown Toggled")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            switch currentNumber {
            case 3:
                changeCountDownNumber()
                numberThreeVisible = true
            case 2:
                changeCountDownNumber()
                numberTwoVisible = true
            case 1:
                numberOneVisible = true
                showCountdown = false
                showGo = true
                
                print("GO Displayed")
            default:
                resetView()
                
                print("ERROR - Unable to complete countdown, view reset")
            }
        }
    }
}

#Preview {
    ContentView()
}
