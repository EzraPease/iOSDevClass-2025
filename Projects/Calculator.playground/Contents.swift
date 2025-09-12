import UIKit




struct Calculator {
    var currentValue: Double?

    
    mutating func inputValue(value: Double) {
        self.currentValue = value
    }
    
    mutating func add() {
        guard var currentValue else { return }
    }
    
    mutating func subtract() {
        guard var currentValue else { return }
    }
    
    mutating func multiply() {
        guard var currentValue else { return }
    }
    
    mutating func divide() {
        guard var currentValue else { return }
    }
    
    mutating func invertSign() {
        
    }
    
    mutating func percentage() {
        
    }
    
    mutating func clearValue() {
        currentValue = nil
    }
}



var myCalculator = Calculator()
myCalculator.inputValue(value: 10)
print(myCalculator.currentValue)
myCalculator.add()
myCalculator.inputValue(value: 10)

