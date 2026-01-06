import SwiftUI





struct FollowAlong: View {
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                
                Rectangle()
                    .fill(.cyan)
                    .containerRelativeFrame(.horizontal) { width, height in
                    
                        width / 2
                    }
                
                Spacer()
            }
            .background(.red) // HStack Background
        }
        .background(.green) // GeometryReader Background
    }
}

#Preview {
    FollowAlong()
}
