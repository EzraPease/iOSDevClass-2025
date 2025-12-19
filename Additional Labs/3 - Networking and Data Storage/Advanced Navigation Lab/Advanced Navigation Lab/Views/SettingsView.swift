//
//  SettingsView.swift
//  Advanced Navigation Lab
//
//  Created by Ezra Pease on 12/19/25.
//

import SwiftUI


struct SettingsView: View {
    @Environment(DragonRouter.self) var router
    
    var body: some View {
        @Bindable var bindableRouter = router
        
        VStack {
            ColorPicker("Change Background Color", selection: $bindableRouter.selectedColor)
        }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
    }
}


#Preview {
    SettingsView()
        .environment(DragonRouter())
}
