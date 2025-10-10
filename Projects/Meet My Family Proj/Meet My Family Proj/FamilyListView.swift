//
//  FamilyListView.swift
//  Meet My Family Proj
//
//  Created by Ezra Pease on 10/9/25.
//

import SwiftUI

struct MyFamily: Identifiable {
    var id: UUID = UUID()
    var firstName: String
    let lastName = "Pease"
    var age: String
    var funFact: String
    var wasViewed = false
}


struct FamilyListView: View {
    
    @State private var selectedFamily: MyFamily?
    
    @State private var myFamilyList: [MyFamily] = [
        MyFamily(firstName: "Michael", age: "46", funFact: "Loves woodworking and makes custom furniture."),
        MyFamily(firstName: "Chevonne", age: "45", funFact: "Was a professional clogger and has traveled abroad multiple times."),
        MyFamily(firstName: "Ezra", age: "22", funFact: "Can solve a Rubik's cube in under a minute."),
        MyFamily(firstName: "Elizabeth", age: "20", funFact: "Keeps a garden with over 30 plant varieties."),
        MyFamily(firstName: "Benson", age: "18", funFact: "Builds PCs and loves retro games."),
        MyFamily(firstName: "Asia", age: "16", funFact: "Speaks three languages."),
        MyFamily(firstName: "Spencer", age: "14", funFact: "Runs half-marathons for fun."),
        MyFamily(firstName: "Abby", age: "12", funFact: "Gives fantastic hugs."),
        MyFamily(firstName: "Zion", age: "9", funFact: "Plays the cello in a youth orchestra."),
        MyFamily(firstName: "Temple", age: "7", funFact: "Can identify constellations in the night sky."),
        MyFamily(firstName: "Joy", age: "5", funFact: "Collects stickers from every place she visits."),
        MyFamily(firstName: "Enoch", age: "3", funFact: "Knows all the dinosaur names.")
        ]
    
    var body: some View {
        NavigationStack {
            VStack {
                List($myFamilyList) { $family in
                    Button {
                        selectedFamily = family
                        family.wasViewed = true
                    } label: {
                        HStack {
                            Text(family.firstName)
                            if family.wasViewed {
                                Text("✅")
                            }
                            
                            Spacer()
                            
                            Image(family.firstName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                        }
                    }
                    }
                }
            .sheet(item: $selectedFamily) { family in
                DetailedFamilyView(family: family)
            }
            .navigationTitle("My Family")
        }
    }
}

#Preview {
    FamilyListView()
}
