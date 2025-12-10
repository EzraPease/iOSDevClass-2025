//
//  ContentView.swift
//  Animations Lab
//
//  Created by Ezra Pease on 12/9/25.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var animation
    
    @State private var showCountdown = false
    @State private var countdownVisible = false
    @State private var showGo = false
    @State private var currentNumber = 3
    @State private var scale: CGFloat = 1
    @State private var opacity: Double = 1
    
    private let loadingViewsID = "loadingViewsID"
    
    private var loading1 = "person.fill"
    private var loading2 = "person.2.fill"
    private var loading3 = "person.3.fill"
    
    
    var body: some View {
        VStack {
            if showCountdown || showGo {
                personsView
            }
            if showCountdown {
                VStack {
                    ZStack {
                        Text("\(currentNumber)")
                            .font(.system(size: 500, weight: .bold, design: .rounded))
                            .scaleEffect(scale)
                            .opacity(opacity)
                            .transition(.opacity.combined(with: .scale))
                            .id(currentNumber)
                            .onAppear {
                                startCountdown()
                            }
                    }
                    .animation(.easeInOut(duration: 0.3), value: currentNumber)
                }
            } else if showGo {
                VStack {
                    Spacer()
                    
                    ZStack {
                        Text("GO!")
                            .font(.system(size: 200, weight: .bold, design: .rounded))
                            .scaleEffect(scale)
                            .opacity(opacity)
                            .transition(.opacity.combined(with: .scale))
                            .onAppear {
                                withAnimation(.easeIn(duration: 0.28)) {
                                    scale = 1
                                    opacity = 1
                                }
                            }
                            .animation(.easeInOut(duration: 0.3), value: showGo)
                    }
                    Spacer()
                    
                    Button("Reset") {
                        resetView()
                    }
                }
            } else {
                Spacer()
                
                Button("Start Game") {
                    withAnimation {
                        showCountdown.toggle()
                    }
                }
                .padding()
                .glassEffect()
            }
        }
    }
    
    @ViewBuilder
    var personsView: some View {
        HStack {
            if currentNumber == 3 {
                loading1View
            } else if currentNumber == 2 {
                loading2View
            } else if currentNumber == 1 {
                loading3View
            }
        }
    }
    
    @ViewBuilder
    var loading1View: some View {
        Image(systemName: loading1)
            .padding()
            .matchedGeometryEffect(id: loadingViewsID, in: animation)
            .offset(x: -100)
    }
    
    @ViewBuilder
    var loading2View: some View {
        Image(systemName: loading2)
            .padding()
            .matchedGeometryEffect(id: loadingViewsID, in: animation)
    }
    
    @ViewBuilder
    var loading3View: some View {
        Image(systemName: loading3)
            .padding()
            .matchedGeometryEffect(id: loadingViewsID, in: animation)
            .offset(x: 100)
    }
    
    private func changeCountDownNumber() {
        withAnimation {
            currentNumber -= 1
            scale = 1
            opacity = 1
        }
        animateNumber()
        print("Current Number: \(currentNumber)")
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
        withAnimation {
            countdownVisible.toggle()
            print("Countdown Toggled")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            switch currentNumber {
            case 2...3:
                changeCountDownNumber()
            case 1:
                showCountdown = false
                withAnimation {
                    showGo = true
                }
                
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
