import Foundation

@Observable
class RandomUserViewModel {
    // --- Identity ---
    var showTitle = true
    
    // --- Location ---
    var showLocation = true
    
    // --- Contact ---
    var showContact = true
    
    // --- Login ---
    var showUuid = false
    var showUsername = false
    var showPassword = false
    var showSalt = false
    var showMd5 = false
    var showSha1 = false
    var showSha256 = false
    
    // --- Dates (DOB & Registered) ---
    var showDobAndAge = true
    var showRegisteredDate = false
    var showRegisteredAge = false
    
    // --- ID ---
    var showIdName = false
    var showIdValue = false
    
    // --- Visuals ---
    var showLargePicture = true
}
