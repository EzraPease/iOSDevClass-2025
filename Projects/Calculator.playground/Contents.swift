import UIKit

//Your overall goal is to recreate the functionality of an actual calculator as possible while using functions in the place of buttons. To that end, your mathematical functions must not accept any parameters. Instead, you must have one function for inputting a value, then "press" the other functions for adding, subtracting, multiplying, dividing, invert sign (+/-) and percentage, as well as C/AC to clear the current value. Use print statements to output the running total of the calculator.







var currentValue: [String] = []
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
    default:
        print("INVALID INPUT")
        return
    }
}


@MainActor func add() {
    if currentValue.count > inputedOperators.count {
        inputedOperators.append(.add)
    } else {
        inputedOperators.removeLast()
        inputedOperators.append(.add)
    }
}

@MainActor func subtract() {
    if currentValue.count > inputedOperators.count {
        inputedOperators.append(.subtract)
    } else {
        inputedOperators.removeLast()
        inputedOperators.append(.subtract)
    }
}

@MainActor func multiply() {
    if currentValue.count > inputedOperators.count {
        inputedOperators.append(.multiply)
    } else {
        inputedOperators.removeLast()
        inputedOperators.append(.multiply)
    }
}

@MainActor func divide() {
    if currentValue.count > inputedOperators.count {
        inputedOperators.append(.divide)
    } else {
        inputedOperators.removeLast()
        inputedOperators.append(.divide)
    }
}

@MainActor func decimal() {
    if !currentValue[inputedOperators.count].contains(".") {
        currentValue[inputedOperators.count] += "."
    }
}

@MainActor func invertSign() {
    if let currentValueDouble = Double(currentValue[inputedOperators.count]) {
        currentValue[inputedOperators.count] = String(currentValueDouble * -1)
    }
}

//@MainActor func percentage() {
//    
//}

// C/AC
@MainActor func clearValues() {
    
}



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
decimal()
decimal()
print(currentValue)
print(inputedOperators)
print("\n")

add()
numberInputButton(value: 2)
invertSign()
print(currentValue)
print(inputedOperators)
print("\n")


add()
multiply()
numberInputButton(value: 3)
print(currentValue)
print(inputedOperators)
print("\n")

divide()
numberInputButton(value: 8)
print(currentValue)
print(inputedOperators)
print("\n")


print(equals())


