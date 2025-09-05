import UIKit

struct Song {
    var title: String
    var author: String
    var duration: Int //Duration in seconds
}

class Playlist {
    var songs: [Song] = []
    var name: String
    var author: String
    private var currentlyPlaying: Song?
    
    init(
        name: String,
        author: String,
        songs: [Song] = [],
        
    ) {
        self.name = name
        self.author = author
        self.currentlyPlaying = songs.first
    }
    
    // Core mutation
    func add(_ song: Song) {
        songs.append(song)
    }
    
    func remove(at index: Int) {
        songs.remove(at: index)
    }
    
    func clear() {
        songs.removeAll()
    }
    
    //    // Querying / reading
    var count: Int {
        songs.count
    }
    
    func allSongs() -> [Song] {
        return songs
    }
    
    func totalDuration() -> Int {
        var addedDuration = 0
        for newduration in songs.map(\.duration) {
            addedDuration += newduration
        }
        return addedDuration
    }
    
    func currentSong() -> Song? {
        currentlyPlaying
    }
    
    //    // Playback navigation
    func play(at index: Int) -> Song? {
        if index >= 0 && index <= songs.count {
            currentlyPlaying = songs[index]
            return currentlyPlaying
        } else {
            return nil
        }
    }
    
    func playNext() -> Song? {
        if let theCurrentlyPlaySong = currentlyPlaying {
            let currentIndex = songs.firstIndex(where: { $0.title == theCurrentlyPlaySong.title }) ?? 0
            return play(at: currentIndex + 1)
        } else {
            return play(at: 0)
        }
    }
    func playPrevious() -> Song? {
        if let theCurrentlyPlaySong = currentlyPlaying {
            let currentIndex = songs.firstIndex(where: { $0.title == theCurrentlyPlaySong.title }) ?? 0
            return play(at: currentIndex - 1)
        } else {
            return play(at: 0)
        }
    }
    //
        // Shuffle
    func shuffle() {
        songs.shuffle()
    }
}

var songs: [Song] = [
    Song(title: "Bohemian Rhapsody", author: "Queen", duration: 354),
    Song(title: "Billie Jean", author: "Michael Jackson", duration: 294),
    Song(title: "Shape of You", author: "Ed Sheeran", duration: 233),
    Song(title: "Hotel California", author: "Eagles", duration: 391),
    Song(title: "Smells Like Teen Spirit", author: "Nirvana", duration: 301),
    Song(title: "Rolling in the Deep", author: "Adele", duration: 228),
    Song(title: "Hey Jude", author: "The Beatles", duration: 431),
    Song(title: "Uptown Funk", author: "Mark Ronson ft. Bruno Mars", duration: 270),
    Song(title: "Stairway to Heaven", author: "Led Zeppelin", duration: 482),
    Song(title: "Shake It Off", author: "Taylor Swift", duration: 242)
]

let testSong = Song(title: "Test Title", author: "Test Artist", duration: 300)


var samplePlaylist = Playlist(name: "Fancy Songs", author: "Ezra", songs:songs)

print("This playlist is \(samplePlaylist.totalDuration()) seconds long.")
print(samplePlaylist.currentSong())
