//
//  ContentView.swift
//  EmojiDictionary
//
//  Created by Jane Madsen on 10/30/25.
//

import SwiftUI

struct EmojiListView: View {
    @State private var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
        // ... (other Emoji initializers)
    ]
    @State private var isShowingAddEdit = false
    @State private var editingEmoji: Emoji? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(emojis) { emoji in
                    Button {
                        editingEmoji = emoji
                        isShowingAddEdit = true
                    } label: {
                        EmojiRow(emoji: emoji)
                    }
                }
                .onDelete { indices in emojis.remove(atOffsets: indices) }
                .onMove { indices, newOffset in emojis.move(fromOffsets: indices, toOffset: newOffset) }
            }
            .navigationTitle("Emoji Dictionary")
            .toolbar {
                EditButton()
                Button("Add") {
                    editingEmoji = nil
                    isShowingAddEdit = true
                }
            }
            .sheet(isPresented: $isShowingAddEdit) {
                AddEditEmojiView(emoji: editingEmoji) { result in
                    if let index = emojis.firstIndex(where: { $0.id == result.id }) {
                        emojis[index] = result
                    } else {
                        emojis.append(result)
                    }
                    isShowingAddEdit = false
                }
            }
        }
    }
}

struct EmojiRow: View {
    let emoji: Emoji
    var body: some View {
        HStack {
            Text(emoji.symbol).font(.largeTitle)
            VStack(alignment: .leading) {
                Text(emoji.name).font(.headline)
                Text(emoji.description).font(.subheadline)
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }
}


#Preview {
    EmojiListView()
}
