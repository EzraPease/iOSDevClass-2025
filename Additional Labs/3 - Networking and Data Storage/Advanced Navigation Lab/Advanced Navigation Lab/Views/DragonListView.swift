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
                Image(systemName: dragon.image)
            }
        }
    }
}



#Preview {
    DragonListView()
        .environment(DragonRouter())
}
