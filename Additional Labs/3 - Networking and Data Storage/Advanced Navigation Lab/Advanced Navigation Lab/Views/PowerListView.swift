//
//  PowerListView.swift
//  Advanced Navigation Lab
//
//  Created by Ezra Pease on 12/19/25.
//

import SwiftUI


struct PowerListView: View {
    @Environment(DragonRouter.self) var router
    
    let dragon: Dragon
    
    var body: some View {
        VStack {
            Image(dragon.image)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            
            
            VStack {
                Text("Abilities:")
                    .bold()
                Text(dragon.abilities)
            }
            .padding()
            .glassEffect()
            .shadow(radius: 20)
        }
    }
}


#Preview {
    PowerListView(dragon: Dragon(image: "dragon.fire", lore: "A fierce fire-breather from the volcanic ridges of Pyra Peak.", age: 312, fireType: "Fire", abilities: "Fire Breath, Heat Resistance, Volcanic Eruption"))
        .environment(DragonRouter())
}
