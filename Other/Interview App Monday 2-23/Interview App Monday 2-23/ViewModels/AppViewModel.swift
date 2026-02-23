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
    
//    var usersList: [User] = [
//        User(username: "Bob"),
//        User(username: "Ezra"),
//        User(username: "Tiffany")
//    ]
    var selectionAmount = 0
    
    func changeSelectionAmount(userList: [User]) {
        selectionAmount = Int.random(in: 1...userList.count)
    }
    
    // TODO: Finish setting up randomize selection
    func selectRandomPeople(userList: [User]) {
        let totalSelected = 0
        
        for user in userList {
            user.selected = false
        }
        
        
        
    }
    
    func addUser(user: User, context: ModelContext) {
        context.insert(user)
    }
    
    func deleteUser(user: User, context: ModelContext) {
        context.delete(user)
    }
}
