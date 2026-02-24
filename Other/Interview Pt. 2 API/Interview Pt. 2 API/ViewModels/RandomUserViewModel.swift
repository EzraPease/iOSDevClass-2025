//
//  RandomUserViewModel.swift
//  Interview Pt. 2 API
//
//  Created by Ezra Pease on 2/24/26.
//

import Foundation

@Observable
class RandomUserViewModel {
    // --- Identity ---
    var showGender = false
    var showName = true // Required
    var showTitle = false
    
    // --- Physical/Address ---
    var showStreet = false
    var showCity = false
    var showState = false
    var showCountry = false
    var showPostcode = false
    var showCoordinates = false
    var showTimezone = false
    
    // --- Contact ---
    var showEmail = false
    var showPhone = false
    var showCell = false
    
    // --- Account Details ---
    var showBirthday = false
    var showAge = false
    var showRegisteredDate = false
    var showUsername = false
    var showPassword = false
    
    // --- Visuals ---
    var showLargePicture = false
    var showThumbnail = true // Requires 1 pictures for assigment
    var showNationality = false
}
