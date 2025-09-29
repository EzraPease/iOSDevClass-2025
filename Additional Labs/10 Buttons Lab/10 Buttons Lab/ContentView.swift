//
//  ContentView.swift
//  10 Buttons Lab
//
//  Created by Ezra Pease on 9/29/25.
//

import SwiftUI

/*
 CURRENTLY WORKING ON:
 - Just finished custome button style
 - Next working on a disabled button (sometimes)
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
    
    func changeToDog() {
        dogIsHidden.toggle()
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
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button("Make Green") {
                    titleColor = .green
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button("Make Purple") {
                    titleColor = .purple
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button("Make Pink") {
                    titleColor = .pink
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button(action: {}) {
                    Text("Button 6")
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button(action: {}) {
                    Text("Button 7")
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button(action: {}) {
                    Text("Button 8")
                }
                .buttonStyle(SolidCapsuleButtonStyel(color: .red))
                .padding(.horizontal)
                
                
                Button(action: {}) {
                    Text("Button 9")
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
                    titleColor = .gray
                }
                .padding(.horizontal)
                
                
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
