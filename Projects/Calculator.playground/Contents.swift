import UIKit




struct Calculator {
    var currentValue: Double? = nil
    var result: Double? = nil

    
    mutating func inputValue(value: Double) {
        currentValue = value
    }
    
    mutating func add() {
        var value1: Double?
        var value2: Double?

        guard var currentValue else { return }
        if let value1 {
            value2 = self.currentValue
        } else {
            value1 = self.currentValue
        }
    
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

