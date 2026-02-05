import SwiftUI

extension View {
    /// Simple reusable glass effect used throughout the app.
    func glassEffect() -> some View {
        self
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

