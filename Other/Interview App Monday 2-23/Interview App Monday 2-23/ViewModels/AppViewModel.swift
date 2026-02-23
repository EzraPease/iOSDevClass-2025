//
//  AppViewModel.swift
//  Interview App Monday 2-23
//
//  Created by Ezra Pease on 2/23/26.
//

import Foundation
import SwiftData


@Observable
class AppViewModel {
    
    func deselectAllPeople(userList: [User]) {
        for user in userList {
            user.selected = false
        }
    }
    
    func selectRandomPeople(userList: [User], selectionAmount: Int) {
        var totalSelected = 0
        
        deselectAllPeople(userList: userList)
        
        while totalSelected < selectionAmount {
            if let user = userList.randomElement() {
                user.selected = true
                totalSelected += 1
            }
        }
        print("Selections Randomized")
    }
    
    func addUser(user: User, context: ModelContext) {
        context.insert(user)
    }
    
    func deleteUser(user: User, context: ModelContext) {
        context.delete(user)
    }
}
