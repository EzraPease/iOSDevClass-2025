import UIKit

//Your overall goal is to recreate the functionality of an actual calculator as possible while using functions in the place of buttons. To that end, your mathematical functions must not accept any parameters. Instead, you must have one function for inputting a value, then "press" the other functions for adding, subtracting, multiplying, dividing, invert sign (+/-) and percentage, as well as C/AC to clear the current value. Use print statements to output the running total of the calculator.




enum Operator {
    case add
    case subtract
    case multiply
    case divide
    case invertSign
}

var currentValue: Double? = nil
var isPressed: Bool = false
var currentOperator: Operator = .add
var operatorCount = 0

var value1: [String] = []
var value2: [String] = []
var combinedValues: [String] = []



//    Must be 1 - 9
@MainActor func numberInputButton(value: Int) {
    switch value {
    case 0...9:
        if isPressed != true {
            value1.append("\(value)")
        } else {
            value2.append("\(value)")
        }
    default:
        print("INVALID INPUT")
    }
}

@MainActor func add() {
    currentOperator = .add
    isPressed = true
    operatorCount += 1
}

@MainActor func subtract() {
    currentOperator = .subtract
    isPressed = true
    operatorCount += 1

}

@MainActor func multiply() {
    currentOperator = .multiply
    isPressed = true
    operatorCount += 1

}

@MainActor func divide() {
    currentOperator = .divide
    isPressed = true
    operatorCount += 1

}

@MainActor func invertSign() {
    currentOperator = .invertSign
    
}

//@MainActor func percentage() {
//    currentOperator = .percentage
//    isPressed = true
//
//}

// C/AC
@MainActor func clearValues() {
    currentValue = nil
    isPressed = false
    value1.removeAll()
    value2.removeAll()
    combinedValues.removeAll()
    operatorCount = 0
}



@MainActor func equals() {
    if var doubleValue1 = Double(value1.joined()),
       var doubleValue2 = Double(value2.joined()) {
        switch currentOperator {
        case .add:
            result = doubleValue1 + doubleValue2
            print(result)
        case .subtract:
            result = doubleValue1 - doubleValue2
            print(result)
        case .multiply:
            result = doubleValue1 * doubleValue2
            print(result)
        case .divide:
            result = doubleValue1 / doubleValue2
            print(result)
        case .invertSign:
            if isPressed {
                doubleValue2 *= -1
            } else {
                doubleValue1 *= -1
            }
        }
    }
    isPressed = false
}

var result: Double




numberInputButton(value: 1)
print(value1)
print(value2)

multiply()
numberInputButton(value: 2)
print(value1)
print(value2)
print(value1)
print(value2)
equals()


