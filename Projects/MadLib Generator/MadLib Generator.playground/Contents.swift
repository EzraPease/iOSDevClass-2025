import UIKit









func generateMadLib(name: String, name2: String, name3: String, adjective: String, adjective2: String, adjective3: String, verb: String, verb_ending_in_ing verb2: String, place: String, place2: String, animal: String, animal2: String, object: String, food: String, sillyObject: String, funnyTitle: String) -> String {
    
    let names: [String] = [name, name2, name3]
    let adjectives: [String] = [adjective, adjective2, adjective3]
    let verbs: [String] = [verb, verb2]
    let places: [String] = [place, place2]
    let animals: [String] = [animal, animal2]
    
        let randomizedNames = names.shuffled()
        let randomizedAdjectives = adjectives.shuffled()
        let randomizedVerbs = verbs.shuffled()
        let randomizedPlaces = places.shuffled()
        let randomizedAnimals = animals.shuffled()
    
    let randomStorySelection: Int = Int.random(in: 1...3)
//    let randomStorySelection: Int = 1
    
    
    
    if name.isEmpty || name2.isEmpty || name3.isEmpty || adjective.isEmpty || adjective2.isEmpty || adjective3.isEmpty || verb.isEmpty || verb2.isEmpty || place.isEmpty || place2.isEmpty || animal.isEmpty || animal2.isEmpty || object.isEmpty || food.isEmpty || sillyObject.isEmpty || funnyTitle.isEmpty {
        return "INVALID INPUT"
        
    } else {
            
            switch randomStorySelection {
            case 1:
                
                return "One day, \(randomizedNames[0]) woke up feeling incredibly \(randomizedAdjectives[0]) and decided to \(randomizedVerbs[0]) all the way to \(randomizedPlaces[0]). Along the way, they stumbled upon a \(randomizedAdjectives[1]) \(randomizedAnimals[0]) that was busy \(randomizedVerbs[1]) a \(object). Curious, \(randomizedNames[1]) shouted, “Wow, that’s the most \(randomizedAdjectives[2]) thing I’ve ever seen!” Suddenly, the \(randomizedAnimals[1]) handed them a \(food), which magically turned into a \(sillyObject) when they took a bite. From that day on, \(randomizedNames[2]) was known as the \(funnyTitle) of \(randomizedPlaces[1])."
                
            case 2:
                
                return "Late last night, \(randomizedNames[0]) felt unusually \(randomizedAdjectives[0]) and decided to \(randomizedVerbs[0]) into the middle of \(randomizedPlaces[0]). Out of nowhere, a \(randomizedAdjectives[1]) \(randomizedAnimals[0]) appeared, busy \(randomizedVerbs[1]) a shiny \(object). Amazed, \(randomizedNames[1]) exclaimed, “This is absolutely the most \(randomizedAdjectives[2]) thing in the universe!” Without warning, the \(randomizedAnimals[1]) tossed them a \(food), which instantly turned into a glowing \(sillyObject) when touched. Ever since, \(randomizedNames[2]) proudly carried the title of \(funnyTitle) of \(randomizedPlaces[1])."
                
            case 3:
                
                return "Early one morning, \(randomizedNames[0]) was feeling extremely \(randomizedAdjectives[0]) and decided to \(randomizedVerbs[0]) straight toward \(randomizedPlaces[0]). On the way, they noticed a \(randomizedAdjectives[1]) \(randomizedAnimals[0]) happily \(randomizedVerbs[1]) a strange \(object). Shocked, \(randomizedNames[1]) shouted, “That’s the most \(randomizedAdjectives[2]) sight I’ve ever witnessed!” Suddenly, the \(randomizedAnimals[1]) gifted them a \(food), which mysteriously turned into a massive \(sillyObject) as soon as it was touched. From that moment forward, \(randomizedNames[2]) was forever celebrated as the \(funnyTitle) of \(randomizedPlaces[1])"
                
            default:
                return "ERROR - No Story Found"
            }
        }
    }

print(generateMadLib(name: "1", name2: "2", name3: "3", adjective: "4", adjective2: "5", adjective3: "6", verb: "7", verb_ending_in_ing: "8", place: "11", place2: "12", animal: "13", animal2: "14", object: "15", food: "16", sillyObject: "17", funnyTitle: "18"))

