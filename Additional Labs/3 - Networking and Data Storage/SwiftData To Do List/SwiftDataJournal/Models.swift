//
//  JournalEntries.swift
//  SwiftData To Do List
//
//  Created by Ezra Pease on 12/2/25.
//

import SwiftUI
import SwiftData


@Model
class Journals {
    var title: String
    var body: String
    var timeStamp: Date
    @Relationship(deleteRule: .cascade, inverse: \JournalEntries.journal) var entries = [JournalEntries]()
    
    init(title: String, body: String, timeStamp: Date = .now) {
        self.title = title
        self.body = body
        self.timeStamp = timeStamp
    }
}


@Model
class JournalEntries {
    var title: String
    var body: String
    var timeStamp: Date
    var journal: Journals?
    
    init(title: String, body: String, timeStamp: Date = .now) {
        self.title = title
        self.body = body
        self.timeStamp = timeStamp
    }
}

