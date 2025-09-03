import UIKit


var Cow = "Moo"; print(Cow)

struct testShirt {
    var color: String
    var brand: String
    func whatImWearing() {
        print("I'm wearing a \(color) \(brand) shirt")
    }
}

let shirt = testShirt(color: "Blue", brand: "Nike")

//Prints the result of the "testShirt" Struct
shirt.whatImWearing()









