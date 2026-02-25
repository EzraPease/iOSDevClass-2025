//
//  RandomUserCell.swift
//  Interview Pt. 2 API
//
//  Created by Ezra Pease on 2/24/26.
//

import SwiftUI

struct RandomUserCell: View {
    @Environment(RandomUserViewModel.self) private var viewModel
    
    @State var users: APIResponse
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(users.results, id: \.login.uuid) { user in
                    RandomUserRow(user: user)
                }
            }
            .padding()
        }
    }
}

private struct RandomUserRow: View {
    @Environment(RandomUserViewModel.self) private var viewModel
    
    let user: User
    
    // Precomputed strings and values to simplify the view body
    private var fullName: String {
        "\(user.name.first) \(user.name.last)"
    }
    
    private var addressLine: String {
        "\(user.location.street.number) \(user.location.street.name)"
    }
    
    private var cityStateCountry: String {
        "\(user.location.city), \(user.location.state) \(user.location.country)"
    }
    
    private var postcode: String {
        user.location.postcode
    }
    
    private var latitude: String {
        user.location.coordinates.latitude
    }
    
    private var longitude: String {
        user.location.coordinates.longitude
    }
    
    private var dateOfBirth: String {
        // 1. Define how to read the API string (Parsing)
        let strategy = Date.ISO8601FormatStyle()
        
        // 2. Try to turn the string into a Date object
        if let date = try? Date(user.dob.date, strategy: strategy) {
            // 3. Turn the Date back into a pretty String
            return date.formatted(date: .long, time: .omitted)
        }
        
        // Fallback if the API string is empty or weird
        return user.dob.date
    }
    
    private var ageText: String {
        String(user.dob.age)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            header
            identitySection
            
            if viewModel.showLocation {
                locationSection
            }
            
            if viewModel.showContact {
                contactSection
            }
            
            if viewModel.showDobAndAge {
                dobAndAgeSection
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.gradient)
        )
    }
    
    private var header: some View {
        HStack(alignment: .center, spacing: 12) {
            AsyncImage(url: URL(string: user.picture.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.2)
            }
            .frame(width: 48, height: 48)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .shadow(radius: 4)
            
            Text(fullName)
                .font(.title)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
    }
    
    private var identitySection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Identity:")
                .bold()
            Group {
                HStack(spacing: 6) {
                    Text("Title:")
                        .bold()
                    Text(user.name.title)
                }
                HStack(spacing: 6) {
                    Text("Gender:")
                        .bold()
                    Text(user.gender)
                }
                HStack(spacing: 6) {
                    Text("Nationality:")
                        .bold()
                    Text(user.nat)
                }
            }
            .font(.footnote)
            Divider()
        }
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Location:")
                .bold()
            Group {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(alignment: .top, spacing: 6) {
                        Text("Address:")
                            .bold()
                        Text(addressLine)
                    }
                    Text("\(cityStateCountry) \(postcode)")
                }
                HStack(spacing: 6) {
                    Text("Latitude Longitude:")
                        .bold()
                    Text(latitude)
                    Text(longitude)
                }
            }
            .font(.footnote)
            Divider()
        }
    }
    
    private var contactSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Contact Info:")
                .bold()
            Group {
                HStack(spacing: 6) {
                    Text("Email:")
                        .bold()
                    Text(user.email)
                }
                HStack(spacing: 6) {
                    Text("Phone #:")
                        .bold()
                    Text(user.phone, format: .phoneNumber)
                }
            }
            .font(.footnote)
            Divider()
        }
    }
    
    private var dobAndAgeSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Date of Birth & Age")
                .bold()
            Group {
                HStack {
                    Text("DOB:")
                        .bold()
                    Text(dateOfBirth)
                }
                HStack {
                    Text("Age:")
                        .bold()
                    Text(ageText)
                }
            }
            .font(.footnote)
            Divider()
        }
    }
}

#Preview {
    RootView()
}
