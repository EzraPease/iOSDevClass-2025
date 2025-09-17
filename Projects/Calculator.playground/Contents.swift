import UIKit

//Your overall goal is to recreate the functionality of an actual calculator as possible while using functions in the place of buttons. To that end, your mathematical functions must not accept any parameters. Instead, you must have one function for inputting a value, then "press" the other functions for adding, subtracting, multiplying, dividing, invert sign (+/-) and percentage, as well as C/AC to clear the current value. Use print statements to output the running total of the calculator.






//var currentValue: Double? = nil
//var isPressed: Bool = false
//var currentOperator: Operator = .add
var operatorCount = 0
//Coresponds with the section of "combinedValues" operators should be placed

var currentValue: [String] = []
//var value2: [String] = []
//var combinedValues: [String] = []
var valuesDouble: [Double] = []
var inputedOperators: [Operator] = []

enum Operator {
    case add
    case subtract
    case multiply
    case divide
}


//    Must be 1 - 9
@MainActor func numberInputButton(value: Int) {
    switch value {
    case 0...9:
        if currentValue.count < inputedOperators.count + 1 {
            currentValue.append("0")
        }
        currentValue[inputedOperators.count] += String(value)
        //        if isPressed != true {
        //            value1.append("\(value)")
        //        } else {
        //            value2.append("\(value)")
        //        }
    default:
        print("INVALID INPUT")
        return
    }
}


@MainActor func add() {
    inputedOperators.append(.add)
}

@MainActor func subtract() {
    inputedOperators.append(.subtract)
}

@MainActor func multiply() {
    inputedOperators.append(.multiply)
}

@MainActor func divide() {
    inputedOperators.append(.divide)
}
//
//    @MainActor func invertSign() {
//        currentOperator = .invertSign
//        if isPressed != true {
//            if var doubleValue1 = Double(value1.joined()) {
//                doubleValue1 *= -1
//            }
//        } else {
//            if var doubleValue2 = Double(value2.joined()) {
//                doubleValue2 *= -1
//            }
//        }
//    }
//
//    //@MainActor func percentage() {
//    //    currentOperator = .percentage
//    //    isPressed = true
//    //
//    //}
//
//    // C/AC
//    @MainActor func clearValues() {
//        currentValue = nil
//        isPressed = false
//        value1.removeAll()
//        value2.removeAll()
//        combinedValues.removeAll()
//        //    operatorCount = 0
//    }



@MainActor func equals() -> Double {
    valuesDouble = currentValue.compactMap { Double($0) }
    var index = 0
    
    while index < inputedOperators.count {
        switch inputedOperators[index] {
        case .multiply:
            valuesDouble[index] = valuesDouble[index] * valuesDouble[index + 1]
            valuesDouble.remove(at: index + 1)
            inputedOperators.remove(at: index)
        case .divide:
            valuesDouble[index] = valuesDouble[index] / valuesDouble[index + 1]
            valuesDouble.remove(at: index + 1)
            inputedOperators.remove(at: index)
        default:
            index += 1
        }
    }
    var result = valuesDouble[0]

        for (index, inputedOperator) in inputedOperators.enumerated() {
            switch inputedOperator {
            case .add:
               result += valuesDouble[index + 1]
            case .subtract:
                result -= valuesDouble[index + 1]
            default:
                break
            }
    }
    return result
}





numberInputButton(value: 1)
numberInputButton(value: 5)
print(currentValue)
print(valuesDouble)
print(inputedOperators)
print("\n")

add()
numberInputButton(value: 2)
print(currentValue)
print(valuesDouble)
print(inputedOperators)
print("\n")


add()
numberInputButton(value: 3)
print(currentValue)
print(valuesDouble)
print(inputedOperators)
print("\n")


print(equals())


