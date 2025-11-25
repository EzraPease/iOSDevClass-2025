//
//  USARepsView.swift
//  Random APIs Project 8
//
//  Created by Ezra Pease on 11/21/25.
//

import SwiftUI


struct USARepsView: View {
    @State private var zipCode = ""
    @State private var apitController: RepresentativeAPIController
    @State private var repsList: [USReps]?
    
    
    init(apiController: RepresentativeAPIController) {
        self.apitController = apiController
    }
    
    var body: some View {
        VStack {
            Text("Find My REP")
                .font(.largeTitle)
                .bold()
                .padding()
            TextField("Search By Zip Code", text: $zipCode)
                .padding()
                .glassEffect()
                .frame(width: 300, height: 30)
                .keyboardType(.numberPad)
                .onSubmit {
                    Task {
                        {
                            do {
                                repsList = try await apitController.fetchUSARep()
                            } catch {
                                print(error)
                            }
                            
                        }
                    }
                    print("Zip Code Submitted")
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
    ParentView()
}
