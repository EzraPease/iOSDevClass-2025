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
    var pressedOpacity: Double = 0.9
    
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
    }
}



struct ContentView: View {
    var body: some View {
        VStack(spacing: 15) {
            Button(action: {}) {
                Text("Button 1")
            }
            .buttonStyle(SolidCapsuleButtonStyel(color: .red))
            .padding(.horizontal)
            
            Button(action: {}) {
                Image(systemName: "dog.fill")
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
            .padding(.horizontal)
            
            Button(action: {}) {
                Text("Button 3")
            }
            .buttonStyle(SolidCapsuleButtonStyel(color: .red))
            .padding(.horizontal)

            
            Button(action: {}) {
                Text("Button 4")
            }
            .buttonStyle(SolidCapsuleButtonStyel(color: .red))
            .padding(.horizontal)

            
            Button(action: {}) {
                Text("Button 5")
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

            
            Button(action: {}) {
                Text("Button 10")
            }
            .buttonStyle(SolidCapsuleButtonStyel(color: .red))
            .padding(.horizontal)

        }
    }
}

#Preview {
    ContentView()
}
