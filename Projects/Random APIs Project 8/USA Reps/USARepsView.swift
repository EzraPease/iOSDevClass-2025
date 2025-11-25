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
    @State private var currentREP: USReps?
    
    
    init(apiController: RepresentativeAPIController) {
        self.apitController = apiController
    }
    
    var body: some View {
        VStack {
            Text("Find My REP")
                .font(.largeTitle)
                .bold()
                .padding()
            TextField("Zip Code", text: $zipCode)
                .padding()
                .glassEffect()
                .frame(width: 300, height: 30)
                .keyboardType(.numberPad)
                .onSubmit {
                    Task {
                        {
                            do {
                                currentREP = try await apitController.fetchUSARep()
                            } catch {
                                print(error)
                            }
                            
                        }
                    }
                    print("Zip Code Submitted")
                }
        }
        .task {
            print(currentREP.name)
        }
    }
}


#Preview {
    ParentView()
}
