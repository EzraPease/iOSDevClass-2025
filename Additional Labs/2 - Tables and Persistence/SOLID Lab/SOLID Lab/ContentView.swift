//
//  ContentView.swift
//  SOLID Lab
//
//  Created by Ezra Pease on 10/28/25.
//

import Foundation

class AppThing {
    
    
    class User: Identifiable {
        let id = UUID()
        var username: String
        let realName: String
        var age: Int
        
        init(username: String, realName: String, age: Int) {
            self.username = username
            self.realName = realName
            self.age = age
        }
    }
    
    
    
    // Single Responsibility and Protocol Oriented
    protocol UserDataStore {
        func saveUser(_ user: User)
    }
    
    protocol AccessUserDataStore {
        func fetchUser()
    }
    
    class UserData: UserDataStore {
        func saveUser(_ user: User) {
            print("Saving user data... for: \(user.username)")
        }
    }
    
    class FriendData: UserDataStore {
        func saveUser(_ user: User) {
            // Insert Code
        }
    }
    
    class CurrentUser: AccessUserDataStore {
        func fetchUser() {
            print("Fetching user data...")
        }
    }
    
    // Depency Inversion / Injection
    class ProfileService {
        let dataStore: any UserDataStore
        
        init(dataStore: any UserDataStore) {
            self.dataStore = dataStore
        }
    }
    let profileService = ProfileService(dataStore: UserData())
    let friendProfileService = ProfileService(dataStore: FriendData())
    
    // Open / Close and Interface Segregation
    protocol CreditCard {
        func accessCreditCardData() -> UUID
    }
    
    protocol DebitCard {
        func accessDebitCardData() -> UUID
    }
    
    protocol GiftCard {
        func accessGiftCardData() -> String
    }
    
    protocol PaymentProcessor {
        func processPayment()
    }
    
    class DebitCardPayment: DebitCard, PaymentProcessor {
        func accessDebitCardData() -> UUID {
            // Insert Code
            return UUID()
        }
        
        func processPayment() {
            // Insert Code
        }
    }
    
    // When this gift card payment was added we didn't need to edit existing code
    class GiftCardPayment: GiftCard, PaymentProcessor {
        func accessGiftCardData() -> String {
            // Insert Code
            return ""
        }
        
        func processPayment() {
            // Insert Code
        }
    }
    
    // Liskov Substitution
    class SeniorUser: User {
        var seniorPerks: [String]
        
        init(username: String, realName: String, age: Int, seniorPerks: [String]) {
            self.seniorPerks = seniorPerks
            super.init(username: username, realName: realName, age: age)
        }
    }
    let oldPerson = SeniorUser(username: "TodMan43", realName: "Tod", age: 76, seniorPerks: ["Free Food Sometimes"])
    func saveOldUser() {
        UserData().saveUser(oldPerson)
    }
    
    // Dependency Injection
    class PaymentProcessComplete {
        private let paymentProcess: PaymentProcessor
        
        init(paymentProcess: PaymentProcessor) {
            self.paymentProcess = paymentProcess
        }
        
        func transactionComplete() {
            // Insert Code
        }
    }
}


