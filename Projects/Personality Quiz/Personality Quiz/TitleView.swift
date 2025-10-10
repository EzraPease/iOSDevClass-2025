//
//  ContentView.swift
//  Personality Quiz
//
//  Created by Ezra Pease on 10/10/25.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Which iPhone Are You?")
                    .font(.largeTitle)
                    .bold()
                    .shadow(color: .gray ,radius: 6, x: 2, y: 1,)
                    .padding()
                
                NavigationLink {
                    QuestionFlowView()
                } label: {
                    Text("Begin Quiz")
                        .padding()
                        .glassEffect()
                        .background(.gray)
                        .foregroundStyle(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 60))
                }
            }
        }
    }
}

#Preview {
    TitleView()
}
