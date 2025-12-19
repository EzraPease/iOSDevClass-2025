//
//  DragonDetailsView.swift
//  Advanced Navigation Lab
//
//  Created by Ezra Pease on 12/19/25.
//

import SwiftUI


struct DragonDetailsView: View {
    @Environment(DragonRouter.self) var router
    
    let dragon: Dragon
    
    var body: some View {
        ScrollView {
            VStack {
                Image(dragon.image)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                Group {
                    Text("Age: \(dragon.age)")
                    Text("Fire Type: \(dragon.fireType)")
                }
                    .bold()
                
                Spacer(minLength: 20)
                
                VStack(alignment: .leading) {
                    Text("Lore:")
                        .bold()
                    Text(dragon.lore)
                }
                
                Spacer(minLength: 180)
                
                Button("Abilities") {
                    router.navigateTo(route: .powerList(dragon: dragon))
                }
                .padding(20)
                .glassEffect()
            }
            .padding()
        }
    }
}


#Preview {
    DragonDetailsView(dragon: Dragon(image: "dragon.fire", lore: "A fierce fire-breather from the volcanic ridges of Pyra Peak.", age: 312, fireType: "Fire", abilities: "Fire Breath, Heat Resistance, Volcanic Eruption"))
        .environment(DragonRouter())
}
