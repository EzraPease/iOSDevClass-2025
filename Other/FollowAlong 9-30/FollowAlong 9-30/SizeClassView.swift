//
//  SizeClassView.swift
//  FollowAlong 9-30
//
//  Created by Ezra Pease on 1/6/26.
//

import SwiftUI

struct SizeClassView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var frameWidthDivisor: CGFloat {
        verticalSizeClass == .compact ? 2 : 3
    }
    
    var body: some View {
        VStack {
            if horizontalSizeClass == .compact {
                Text("Horizontal: Compact")
            } else {
                Text("Horizontal: Regular")
            }
            
            if verticalSizeClass == .compact {
                Text("Vertical: Compact")
            } else {
                Text("Vertical: Regular")
            }
            
            GeometryReader { geometry in
            Rectangle()
                    .fill(.cyan)
                    .frame(width: geometry.size.width / frameWidthDivisor)
            }
        }
    }
}

#Preview {
    SizeClassView()
}
