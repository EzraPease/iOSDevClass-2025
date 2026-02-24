//
//  User.swift
//  Interview Pt. 2 API
//
//  Created by Ezra Pease on 2/24/26.
//

struct APIResponse: Codable {
    var results: [User]
}

struct User: Codable {
    var gender: String
    var name: NameDetails
    var location: LocationDetails
    var email: String
    var login: LoginDetails
    var dob: DobDetails
    var registered: RegisteredDetails
    var phone: String
    var cell: String
    var id: IDDetails
    var picture: PictureDetails
    var nat: String
}

struct NameDetails: Codable {
    var title: String
    var first: String
    var last: String
}

struct LocationDetails: Codable {
    var street: StreetDetails
    var city: String
    var state: String
    var country: String
    var postcode: String
    var coordinates: CoordinateDetails
    var timezone: TimeZoneDetails
    
    enum CodingKeys: String, CodingKey {
            case street, city, state, country, postcode, coordinates, timezone
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            // Standard decoding for most fields
            self.street = try container.decode(StreetDetails.self, forKey: .street)
            self.city = try container.decode(String.self, forKey: .city)
            self.state = try container.decode(String.self, forKey: .state)
            self.country = try container.decode(String.self, forKey: .country)
            self.coordinates = try container.decode(CoordinateDetails.self, forKey: .coordinates)
            self.timezone = try container.decode(TimeZoneDetails.self, forKey: .timezone)

            // --- THE BULLETPROOF FIX FOR POSTCODE ---
            // 1. Try to decode it as a String
            if let stringValue = try? container.decode(String.self, forKey: .postcode) {
                self.postcode = stringValue
            }
            // 2. If it fails, try to decode it as an Int and convert to String
            else if let intValue = try? container.decode(Int.self, forKey: .postcode) {
                self.postcode = String(intValue)
            }
            // 3. Fallback to an empty string to avoid a crash
            else {
                self.postcode = ""
            }
        }
}

struct StreetDetails: Codable {
    var number: Int
    var name: String
}

struct CoordinateDetails: Codable {
    var latitude: String
    var longitude: String
}

struct TimeZoneDetails: Codable {
    var offset: String
    var description: String
}

struct LoginDetails: Codable {
    var uuid: String
    var username: String
    var password: String
    var salt: String
    var md5: String
    var sha1: String
    var sha256: String
}

struct DobDetails: Codable {
    var date: String
    var age: Int
}

struct RegisteredDetails: Codable {
    var date: String
    var age: Int
}

struct IDDetails: Codable {
    var name: String
    var value: String
}

struct PictureDetails: Codable {
    var large: String
    var medium: String
    var thumbnail: String
}
