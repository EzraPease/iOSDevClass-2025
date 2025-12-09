//
//  ContentView.swift
//  Animations Lab
//
//  Created by Ezra Pease on 12/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showCountdown = false
    @State private var showGo = false
    @State private var currentNumber = 3
    @State private var scale: CGFloat = 1
    @State private var opacity: Double = 1
    
    var body: some View {
        VStack {
            if showCountdown {
                Text("\(currentNumber)")
                    .font(.system(size: 500, weight: .bold, design: .rounded))
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .onAppear {
                        startCountdown()
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
    
    private func resetView() {
        scale = 1
        opacity = 1
        currentNumber = 3
        showGo = false
        showCountdown = false
    }
    
    private func startCountdown() {
        scale = 1
        opacity = 1
        currentNumber = 3
        
        animateNumber()
    }
    
    private func animateNumber() {
        withAnimation(.easeInOut(duration: 0.5)) {
            scale = 0
            opacity = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            switch currentNumber {
            case 2...3:
                currentNumber -= 1
                
                scale = 1
                opacity = 1
                animateNumber()
                
                print("Current Number: \(currentNumber)")
            case 1:
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
