//
//  CardList.swift
//  DatePicker
//
//  Created by Ezra Pease on 1/9/26.
//

import SwiftUI

@Observable
class CardListViewModel {
    var cardList: [Cards] = [
        Cards(description: "Example Card", date: .now, color: Color.green, photo: Image(systemName: "photo"))
    ]
}
