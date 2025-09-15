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
//Coresponds with the section of "combinedValues" operators should be placed

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
    operatorCount += 2
    
    if let result = Double(value1.joined()) {
        combinedValues.append("\(result)")
        value1.removeAll()
    } else {
        combinedValues.append("0")
    }
    combinedValues[operatorCount] = " + "
 
}

@MainActor func subtract() {
    currentOperator = .subtract
    isPressed = true
    if let result = Double(value1.joined()) {
        combinedValues.append("\(result)")
    }

    if var doubleValue2 = Double(value2.joined()) {
        combinedValues.append("- \(doubleValue2)")
        print(combinedValues)
        value2.removeAll()
    }
//    operatorCount += 1

}

@MainActor func multiply() {
    currentOperator = .multiply
    isPressed = true
    if let result = Double(value1.joined()) {
        combinedValues.append("\(result)")
    }

    if var doubleValue2 = Double(value2.joined()) {
        combinedValues.append("* \(doubleValue2)")
        print(combinedValues)
        value2.removeAll()
    }
//    operatorCount += 1

}

@MainActor func divide() {
    currentOperator = .divide
    isPressed = true
    if let result = Double(value1.joined()) {
        combinedValues.append("\(result)")
    }

    if var doubleValue2 = Double(value2.joined()) {
        combinedValues.append("/ \(doubleValue2)")
        print(combinedValues)
        value2.removeAll()
    }
//    operatorCount += 1

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
//    operatorCount = 0
}



@MainActor func equals() {
    if let results = Double(combinedValues.joined()) {
        print(results)
    }
        isPressed = false
}

var result: Double




numberInputButton(value: 1)
print(value1)
print(value2)
print(combinedValues)
print("\n")

add()
numberInputButton(value: 2)
print(value1)
print(value2)
print(combinedValues)
print("\n")


multiply()
numberInputButton(value: 3)
print(value1)
print(value2)
print(combinedValues)
print("\n")


equals() // Should print 9


