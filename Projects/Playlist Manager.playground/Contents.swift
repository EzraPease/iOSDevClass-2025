import UIKit

struct Song {
    var title: String
    var author: String
}

class Playlist {
    var songs: [Song] = [
        Song(title: "Bohemian Rhapsody", author: "Queen"),
        Song(title: "Billie Jean", author: "Michael Jackson"),
        Song(title: "Shape of You", author: "Ed Sheeran"),
        Song(title: "Hotel California", author: "Eagles"),
        Song(title: "Smells Like Teen Spirit", author: "Nirvana"),
        Song(title: "Rolling in the Deep", author: "Adele"),
        Song(title: "Hey Jude", author: "The Beatles"),
        Song(title: "Uptown Funk", author: "Mark Ronson ft. Bruno Mars"),
        Song(title: "Stairway to Heaven", author: "Led Zeppelin"),
        Song(title: "Shake It Off", author: "Taylor Swift"),
    ]

    var name: String
    var author: String
    var currentlyPlaying: Bool

    init(
        name: String,
        author: String,
        songs: [Song] = [],
        currentlyPlaying: Bool = false
    ) {
        self.name = name
        self.author = author
        self.currentlyPlaying = currentlyPlaying
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
        var count: Int { get }
    func allSongs() -> [Song] {
        
    }
    //    func totalDuration() -> Int
    //    func currentSong() -> Song?
    //
    //    // Playback navigation
    //    func play(at index: Int) -> Song?
    //    func playNext() -> Song?
    //    func playPrevious() -> Song?
    //
    //    // Shuffle
    //    func shuffle()
}
let testSong = Song(title: "Test Title", author: "Test Artist")
var samplePlaylist = Playlist(name: "Fancy Songs", author: "Ezra")
