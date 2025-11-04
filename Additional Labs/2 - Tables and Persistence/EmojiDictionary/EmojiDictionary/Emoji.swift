//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Jane Madsen on 10/30/25.
//





import Foundation

struct Emoji: Codable, Identifiable {
    var id: UUID = UUID()
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    static let archiveURL = documentsDirectory?.appendingPathComponent("emojis").appendingPathExtension("plist")
    
    static func saveToFile(emojis: [Emoji]) {
        let propertyListEncoder = PropertyListEncoder()
        
        if let encodedEmoji = try? propertyListEncoder.encode(newEmoji), let archiveURL {
            print(encodedEmoji)
            try? encodedEmoji.write(to: archiveURL)
        }
        
        
        
    }
    static func loadFromFile() -> [Emoji] {
        let propertyListDecoder = PropertyListDecoder()
        if let archiveURL, let retrievedEmojiData = try? Data(contentsOf: archiveURL), let decodedEmoji = try? propertyListDecoder.decode([Emoji].self, from: retrievedEmojiData) {
            return decodedEmoji
        }
        return []
    }
}

let newEmoji = Emoji(symbol: "dog.fill", name: "Filled Dog", description: "A generic, filled in imaged of a dog", usage: "For refrence to dogs")
