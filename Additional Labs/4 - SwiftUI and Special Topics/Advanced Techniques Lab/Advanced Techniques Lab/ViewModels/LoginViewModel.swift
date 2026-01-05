//
//  LoginViewModel.swift
//  Advanced Techniques Lab
//
//  Created by Ezra Pease on 1/5/26.
//

import SwiftUI

class LoginViewModel {
    enum LoginState {
        case idle
        case success
        case loading
        case error(String)
    }
}
