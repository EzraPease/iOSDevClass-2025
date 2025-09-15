import UIKit

enum Operator {
    case add
    case subtract
    case multiply
    case divide
    case invertSign
    case none
}

var currentValue: Double? = nil
var result: Double?
var isPressed: Bool = false
var currentOperator: Operator = .none

var value1: [String] = []
var value2: [String] = []



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
}

@MainActor func subtract() {
    currentOperator = .subtract
    isPressed = true
    
}

@MainActor func multiply() {
    currentOperator = .multiply
    isPressed = true
    
}

@MainActor func divide() {
    currentOperator = .divide
    isPressed = true
    
}

@MainActor func invertSign() {
    currentOperator = .invertSign
    isPressed = true
    
}

//@MainActor func percentage() {
//    currentOperator = .percentage
//    isPressed = true
//    
//}

@MainActor func clearValues() {
    currentValue = nil
    isPressed = false
    currentOperator = .none
    value1.removeAll()
    value2.removeAll()
}



@MainActor func equals() {
    if let doubleValue1 = Double(value1.joined()),
       let doubleValue2 = Double(value2.joined()) {
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
            
        case .none:
            result = Double(value1.joined())
            print(result)
        }
    }
    isPressed = false
    currentOperator = .none
}



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
