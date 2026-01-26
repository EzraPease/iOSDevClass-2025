//
//  USARepsView.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/21/25.
//

import SwiftUI


struct USARepsView: View {
    @State private var zipCode = ""
    @State private var apiController: RepresentativeAPIController
    @State private var repsList: [USReps]? // Storage for reps list from API
    @State private var loadingIndicatorShown = false
    
    
    init(apiController: RepresentativeAPIController) {
        self.apiController = apiController
    }
    
    var body: some View {
        VStack {
            Text("Find My REP")
                .font(.largeTitle)
                .bold()
                .padding()
            TextField("Search By Zip Code", text: $zipCode)
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                .frame(width: 300, height: 30)
                .keyboardType(.numberPad)
            HStack {
                Button("Search") {
                    // Dismisses keyboard on click
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                    to: nil, from: nil, for: nil)
                    loadingIndicatorShown = true
                    Task {
                        do {
                            repsList = try await apiController.fetchUSARep(zip: zipCode)
                        } catch {
                            print(error)
                        }
//                        try? await Task.sleep(nanoseconds: 350_000_000) // Waits for 0.35 seconds
                        loadingIndicatorShown = false
                        print(repsList as Any) // DEBUGGING
                        print(repsList?.count as Any) // DEBUGGING
                        print("Zip Code Submitted") // DEBUGGING
                    }
                }
                if loadingIndicatorShown {
                    ProgressView()
                }
            }
            .padding()
            // View for when the user submits a search
            if let reps = repsList, !reps.isEmpty {
                ScrollView {
                    ForEach(Array(reps.enumerated()), id: \.offset) { _, rep in
                        VStack(alignment: .leading) {
                            Text(rep.name)
                                .font(.headline)
                                .bold()
                                .underline()
                                .padding(.vertical, 10)
                            HStack(alignment: .top) {
                                Text("Office Address: ")
                                    .bold()
                                Text(rep.office)
                            }
                            HStack {
                                Text("Phone Number: ")
                                    .bold()
                                Text(rep.phone)
                            }
                            HStack {
                                Text("State: ")
                                    .bold()
                                Text(rep.state)
                            }
                            HStack {
                                Text("Disctrict: ")
                                    .bold()
                                Text(rep.district)
                            }
                            HStack {
                                Text("Link: ")
                                    .bold()
                                if let url = URL(string: rep.link) {
                                    Link(rep.link, destination: url)
                                        .foregroundStyle(.blue)
                                } else {
                                    Text(rep.link)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .padding(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.orange, in: RoundedRectangle(cornerRadius: 30))
                        .padding(10)
                    }
                }
            }
            
        }
        // .task is for debugging
        //        .task {
        //            do {
        //                repsList = try await apitController.fetchUSARep().first
        //            } catch {
        //                print(error)
        //            }
        //            print("Reps List = \(currrepsListentREP)")
        //            if let repsList {
        //                print(repsList.name)
        //            } else {
        //                print("Failed")
        //            }
        //        }
    }
}


#Preview {
    USARepsView(apiController: RepresentativeAPIController())
}
