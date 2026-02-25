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
            ForEach(users.results, id: \.login.uuid) { user in
                VStack {
                    VStack {
                        HStack {
                            AsyncImage(url: URL(string: user.picture.thumbnail))
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                                .shadow(radius: 10)
                            HStack {
                                Text(user.name.first)
                                Text(user.name.last)
                            }
                            .font(.title)
                            .bold()
                        }
                        VStack(alignment: .leading) {
                            Text("Identity:")
                                .bold()
                            Group {
                                HStack {
                                    Text("Gender:")
                                        .bold()
                                    Text(user.gender)
                                }
                                HStack {
                                    Text("Title:")
                                        .bold()
                                    Text(user.name.title)
                                }
                            }
                            .font(.footnote)
                            Divider()
                        }
                    }
                    if viewModel.showLocation {
                        VStack(alignment: .leading) {
                            Text("Location:")
                                .bold()
                            Group {
                                HStack(alignment: .top, spacing: 3) {
                                    Text("Address:")
                                        .bold()
                                    Text(user.location.street.number, format: .number.grouping(.never))
                                    Text("\(user.location.street.name) \(user.location.city), \(user.location.state) \(user.location.country) \(user.location.postcode)")
                                }
                                HStack {
                                    Text("Latitude Longitude:")
                                        .bold()
                                    Text(user.location.coordinates.latitude)
                                    Text(user.location.coordinates.longitude)
                                }
                            }
                        .font(.footnote)
                        Divider()
                        }
                    }
                    if viewModel.showContact {
                        VStack(alignment: .leading) {
                            Text("Contact Info:")
                                .bold()
                            Group {
                                HStack {
                                    Text("Email:")
                                        .bold()
                                    Text(user.email)
                                }
                                HStack {
                                    Text("Phone #:")
                                    Text(user.ph)
                                }
                            }
                            .font(.footnote)
                            Divider()
                        }
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.gradient)
            }
            .padding()
        }
    }
}

#Preview {
    RootView()
}
