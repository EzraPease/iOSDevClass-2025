import SwiftUI

struct AnimationView: View {
    @Namespace private var animation
    private let animationID = "animationID"
    @State private var viewToggle = false

    var body: some View {
        VStack(spacing: 24) {
                if viewToggle {
                    Circle()
                        .fill(.blue)
                        .frame(width: 160, height: 160)
                        .matchedGeometryEffect(id: animationID, in: animation, anchor: .center)
                } else {
                    Circle()
                        .frame(width: 60, height: 60)
                        .foregroundStyle(.orange)
                        .matchedGeometryEffect(id: animationID, in: animation, anchor: .center)
                }

            Button("Toggle") {
                withAnimation {
                    viewToggle.toggle()
                }
            }
            .padding()
            .glassEffect()
        }
        .padding()
    }
}

#Preview {
    AnimationView()
}
