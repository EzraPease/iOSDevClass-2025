//
//  ContentView.swift
//  DatePicker
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct MainMenuView: View {
    @State private var createCardPresented = false
    @State var viewModel = CardListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                    .bold()
                Button {
                    createCardPresented = true
                }
                label: {
                    Text("Create a Card")
                        .italic()
                        .padding()
                        .glassEffect()
                        .shadow(radius: 10)
                }
                NavigationLink {
                    CardListView(viewModel: viewModel)
                } label: {
                    Text("View Cards")
                        .italic()
                        .padding()
                        .glassEffect()
                        .shadow(radius: 10)
                }
            }
            .sheet(isPresented: $createCardPresented) {
                NewCardView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    MainMenuView()
}
