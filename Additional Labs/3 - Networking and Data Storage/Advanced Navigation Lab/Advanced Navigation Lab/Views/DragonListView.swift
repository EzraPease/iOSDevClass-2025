//
//  DragonListView.swift
//  Advanced Navigation Lab
//
//  Created by Ezra Pease on 12/19/25.
//

import SwiftUI


struct DragonListView: View {
    @Environment(DragonRouter.self) var router
    let viewModel = DragonListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dragonList) { dragon in
                Button {
                    router.navigateTo(route: .dragonDetails(dragon: dragon))
                } label: {
                    HStack {
                        Image(dragon.image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaledToFit()
                        Text(dragon.fireType)
                    }
                    .padding()
                }
            }
        }
    }
}



#Preview {
    DragonListView()
        .environment(DragonRouter())
}
