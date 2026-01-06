//
//  OnGeometryChanceView.swift
//  FollowAlong 9-30
//
//  Created by Ezra Pease on 1/6/26.
//

import SwiftUI

struct OnGeometryChanceView: View {
    @State private var text = ""
    @State private var textSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Text(text)
                .onGeometryChange(for: CGSize.self) { geometry in
                    geometry.size
                } action: { newValue in
                    textSize = newValue
                }
            
            Rectangle()
                .fill(.black)
                .frame(width: textSize.width, height: 5)
            
            TextField("Type here", text: $text)
                .padding()
        }
    }
}

#Preview {
    OnGeometryChanceView()
}
