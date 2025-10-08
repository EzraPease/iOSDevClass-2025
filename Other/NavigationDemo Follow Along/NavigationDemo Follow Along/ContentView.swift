//
//  ContentView.swift
//  NavigationDemo Follow Along
//
//  Created by Ezra Pease on 10/8/25.
//

import SwiftUI

struct Student: Identifiable {
    var id: UUID = UUID()
    var name: String
    var favoriteColor: Color
}

let students = [
    Student(name: "Ezra", favoriteColor: .blue),
    Student(name: "John", favoriteColor: .red),
    Student(name: "Alice", favoriteColor: .purple)
]

struct ContentView: View {
    
    @State private var isPresentingSheet = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                List(students) { student in
                    NavigationLink {
                        student.favoriteColor
                            .ignoresSafeArea()
                    } label: {
                        Text(student.name)
                    }
                }
                Button("Whatever") {
                    isPresentingSheet = true
                }
            }
            .navigationTitle("Students")
            .sheet(isPresented: $isPresentingSheet) {
                Text("Sheet Happens")
            }
        }
    }
}

#Preview {
    ContentView()
}
