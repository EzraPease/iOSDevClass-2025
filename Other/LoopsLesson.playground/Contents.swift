import UIKit

// MARK - For Loops

for index in 1...5 {
    print("This number is \(index)")
}

for _ in 1...3 {
    print("Hello, world!")
}


let names = ["Alice", "Bob", "Charlie", "Diana", "Eve"]
for name in names {
    print("Hello, \(name)")
}
//Enumerated
/// Then you get it in a slightly different format
/// and it carries over when you return
/*
 
 this whole thing is a comment
 
 
 */


/// Enumerate over the letters of the alphabet
for (index, letter) in "ABCDEFG".enumerated() {
    // always gets the index (number) first
    print("Letter \(index + 1) is \(letter)")
}


let vehicles = ["unicycle" : 1, "bicycle" : 2, "tricycle" : 3, "quad bike" : 4]
for (vehicle, wheels) in vehicles {
    print("\(vehicle) has \(wheels) wheels")
}



// Mark - While Loops

var numberOfLives = 3

/// A while loop will continue to run as long as the condition is true
///  In this case our condition is that numberOfLives is greater than 0
while numberOfLives > 0 {
    playMove()
    updateLivesCount()
}



// Mark - Control Transfer Statements


for counter in -10...10 {
    print(counter)
    if counter == 0 {
        break
    }
}


// continue

for name in names {
    if name.contains("e") {
        continue
    }
    print("Congrats, \(name). You've got $100!")
}




// Helper Methods

func playMove() {
    print("Playing a move!")
}

@MainActor
func updateLivesCount() {
    numberOfLives -= 1
}
