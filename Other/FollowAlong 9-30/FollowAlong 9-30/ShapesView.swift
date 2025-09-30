//
//  ContentView.swift
//  FollowAlong 9-30
//
//  Created by Ezra Pease on 9/30/25.
//

import SwiftUI

struct ShapesView: View {
    var body: some View {
        //        VStack {
        //            Color.blue
        //            Color(red: 122/255, green: 237/255, blue: 119/255)
        //            Color(hue: 6/360, saturation: 0.74, brightness: 0.86)
        //            Color.blueberryBlue
        //
        //            Circle()
        ////            RadialGradient(colors: [.blueberryBlue, .red, .yellow], center:  startRadius: 2, endRadius: 10)
        //                .fill(.blueberryBlue)
        //                .stroke(Color.black, lineWidth: 10)
        //                .strokeBorder(Color.blue, lineWidth: 10)
        //            Rectangle()
        //                .foregroundStyle(Gradient(colors: [.red, .blue, .green]))
        //            RoundedRectangle(cornerRadius: 20)
        //        }
        ////        .ignoresSafeArea()
        //        .padding()
        //    }
        ZStack {
            
            Circle()
                .foregroundStyle(Gradient(colors: [.red, .green, .blueberryBlue]))
                .frame(width: 300)
            
            ScrollView {
                VStack {
                    Spacer(minLength: 150)
                    
                    Image(systemName: "service.dog")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(width: 300)
                        .glassEffect(.clear.tint(.cyan), in: RoundedRectangle(cornerRadius: 20))
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}
    
    #Preview {
        ShapesView()
    }
