//
//  ContentView.swift
//  10 Buttons Lab
//
//  Created by Ezra Pease on 9/29/25.
//

import SwiftUI

/*
 CURRENTLY WORKING ON:
 - Completed
 */

struct SolidCapsuleButtonStyel: ButtonStyle {
    var color: Color
    var verticlePadding: CGFloat = 8
    var foreground: Color = .white
    var pressedScale: CGFloat = 0.98
    var pressedOpacity: Double = 0.8
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foreground)
            .frame(maxWidth: .infinity)
            .padding(.vertical, verticlePadding)
            .background(
                color,
                in: Capsule()
            )
            .scaleEffect(configuration.isPressed ? pressedScale : 1)
            .opacity(configuration.isPressed ? pressedOpacity : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}




struct ContentView: View {
    
    @State private var dogIsHidden = true
    @State private var title = "I get changed by a button"
    @State private var titleColor: Color = .gray
    @State private var resetIsDisabled = true
    
    func changeToDog() {
        dogIsHidden.toggle()
    }
    
    func randomColor(
        saturation: ClosedRange<Double> = 0.6...0.95,
        brightness: ClosedRange<Double> = 0.7...1
    ) -> Color {
        let hue = Double.random(in: 0...1)
        let saturation = Double.random(in: saturation)
        let brightness = Double.random(in: brightness)
        
        return Color(hue: hue, saturation: saturation, brightness: brightness)
    }
    
    
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Group {
                if dogIsHidden {
                    Text("I get changed by a button")
                        .font(.title)
                        .bold()
                        .underline()
                        .foregroundStyle(titleColor)
                } else {
                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(titleColor)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            VStack(spacing: 15) {
                Button("Make Red") {
                    titleColor = .red
                    resetIsDisabled = false
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button("Make Green") {
                    titleColor = .green
                    resetIsDisabled = false
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button("Make Purple") {
                    titleColor = .purple
                    resetIsDisabled = false
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button("Make Pink") {
                    titleColor = .pink
                    resetIsDisabled = false
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button("Make Cyan") {
                    titleColor = .cyan
                    resetIsDisabled = false
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button("Make Mint") {
                    titleColor = .mint
                    resetIsDisabled = false
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button("Make White") {
                    titleColor = .white
                    resetIsDisabled = false
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button("Randomize Color") {
                    titleColor = randomColor()
                    resetIsDisabled = false
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                Button(action: changeToDog) {
                    if dogIsHidden {
                        HStack(spacing: 15) {
                            Image(systemName: "dog.fill")
                            Text("Change to Dog")
                            Image(systemName: "dog.fill")
                            
                        }
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            LinearGradient(
                                colors: [.red, .green, .blue],
                                startPoint: .topLeading,
                                endPoint: .trailing
                            ),
                            in: Capsule()
                        )
                        
                    } else {
                        Text("Change To Text")
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(
                                LinearGradient(
                                    colors: [.red, .green, .blue],
                                    startPoint: .topLeading,
                                    endPoint: .trailing
                                ),
                                in: Capsule()
                            )
                    }
                }
                .padding(.horizontal)
                
                Button("Reset") {
                    resetIsDisabled = true
                    titleColor = .gray
                }
                .padding(.horizontal)
                .disabled(resetIsDisabled)
                .opacity(resetIsDisabled ? 0.8 : 1)
                
                
                
            }
            .padding()
        }
        .background(
            LinearGradient(
                colors: [.white, .yellow, .orange],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
                )
        )
    }
}

#Preview {
    ContentView()
}
