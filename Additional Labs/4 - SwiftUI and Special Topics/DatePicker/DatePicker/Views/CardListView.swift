//
//  CreatedCards.swift
//  DatePicker
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

struct CardListView: View {
    @State var viewModel: CardListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.cardList) {card in
                HStack {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Text("Invitation")
                            .font(.largeTitle)
                            .bold()
                        Text("The party is scheduled for:")
                        Text("\(card.date.formatted(date: .abbreviated, time: .shortened))")
                        card.photo
                            .resizable()
                            .scaledToFit()
                        Text(card.description)
                            .italic()
                        
                    }
                    .padding()
                    
                    Spacer()
                }
                .background(card.color)
                .cornerRadius(20)
            }
        }
    }
}

#Preview {
    CardListView(viewModel: CardListViewModel())
}
