//
//  DragonRouter.swift
//  Advanced Navigation Lab
//
//  Created by Ezra Pease on 12/19/25.
//

import SwiftUI


@Observable
class DragonRouter {
    var navigationPath = NavigationPath()
    
    enum Route: Hashable {
        case dragonList
        case dragonDetails
        case powerList
        case settings
    }
    
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .dragonList:
            DragonListView()
            
        case .dragonDetails:
            DragonDetailsView()
            
        case .powerList:
            PowerListView()
            
        case .settings:
            SettingsView()
        }
    }
    
    func navigateTo(route: Route) {
        navigationPath.append(route)
    }
}
