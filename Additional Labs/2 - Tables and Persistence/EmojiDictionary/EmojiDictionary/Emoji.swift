//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Jane Madsen on 10/30/25.
//





import Foundation

struct Emoji: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    static let archiveURL = documentsDirectory?.appendingPathComponent("emojis").appendingPathExtension("plist")
    
    static func saveToFile(emojis: [Emoji]) {
        let propertyListEncoder = PropertyListEncoder()
        
        if let encodedEmoji = try? propertyListEncoder.encode(emojis), let archiveURL {
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
    
    static func sampleEmojis() -> [Emoji] {
        return [
            Emoji(symbol: "🐕", name: "Dog", description: "A generic, imaged of a dog", usage: "For refrence to dogs"),
            
        ]
    }
}
