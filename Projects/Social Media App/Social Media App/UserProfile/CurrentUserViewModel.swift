//
//  CurrentUserViewModel.swift
//  Social Media App
//
//  Created by Ezra Pease on 11/10/25.
//

import SwiftUI

@Observable
class CurrentUserViewModel {
    var currentUser: [CurrentUser] = [
        CurrentUser(firstName: "Ezra",
                    lastName: "Pease",
                    userBio: "Insert user bio here",
                    techInterests: "I really like computures, computure good yes")
    ]
    
}
