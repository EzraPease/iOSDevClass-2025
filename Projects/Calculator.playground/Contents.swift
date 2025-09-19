import UIKit

//Your overall goal is to recreate the functionality of an actual calculator as possible while using functions in the place of buttons. To that end, your mathematical functions must not accept any parameters. Instead, you must have one function for inputting a value, then "press" the other functions for adding, subtracting, multiplying, dividing, invert sign (+/-) and percentage, as well as C/AC to clear the current value. Use print statements to output the running total of the calculator.







var currentValue: [String] = [] //Stores inputed values before calculation
var valuesDouble: [Double] = [] //Stores inputed values after during / after calculation
var inputedOperators: [Operator] = [] //Stores the order of which operators to use

enum Operator {
    case add
    case subtract
    case multiply
    case divide
}


//    Must be 0 - 9
@MainActor func numberInputButton(value: Int) {     //Used to input a value from 0 - 9 (Like a button on a calculator)
    switch value {
    case 0...9:
        if currentValue.count < inputedOperators.count + 1 {
            currentValue.append("0")
        }
        currentValue[inputedOperators.count] += String(value)
    default:        //Runs if the inputed value is not 0-9
        print("INVALID INPUT")
        return
    }
}

@MainActor func add() {     //Checks conditionals and adds ".add" into inputedOperators (Same for subtract, multiply, and divide)
    if currentValue.count > inputedOperators.count {
        inputedOperators.append(.add)
    } else {
        inputedOperators.removeLast()       //Checks for 2 operators in a row and replaces the old one with the new one if there is
        inputedOperators.append(.add)
    }
}

@MainActor func subtract() {
    if currentValue.count > inputedOperators.count {
        inputedOperators.append(.subtract)
    } else if inputedOperators.last == .multiply || inputedOperators.last == .divide {
        currentValue.append("-0")
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

@MainActor func decimal() {     //Adds a decimal into the most recent stored value in the "currentValue" array
    if !currentValue[inputedOperators.count].contains(".") {        //Wont run if the value already contains a decimal point
        currentValue[inputedOperators.count] += "."
    }
}

@MainActor func invertSign() {      //Takes the most recent value in "currentValue" and multiplies it by -1 to inverse it
    if let currentValueDouble = Double(currentValue[inputedOperators.count]) {
        currentValue[inputedOperators.count] = String(currentValueDouble * -1)
    }
}

@MainActor func percentage() {          // *BLACK DIAMOND CHALLENGE*
    var percentResult = 0.0
    guard currentValue.count > 1 else { return }        // Ensures there is at least 2 values in "currentValue"
    if currentValue.count > inputedOperators.count {        //CALCULATING PERCENT VALUE
        if var percentValue = Double(currentValue[currentValue.count - 1]) {
            percentValue /= 100
            percentResult = percentValue
        } else if currentValue.count <= inputedOperators.count {
            inputedOperators.removeLast()
            if var percentValue = Double(currentValue[currentValue.count - 1]) {
                percentValue /= 100
                percentResult = percentValue
            } else {
                return
            }
        }
        
        guard let currentOperator = inputedOperators.last else { return }     //Initializing of values
        var tempCurrentValue = Double(currentValue[currentValue.count - 2])
        guard let tempCurrentValue else { return }
        
        
        var result: Double
        
        switch currentOperator {        //Runs calcuations based on the stored operator in "currentOperator"
        case .add:
            result = tempCurrentValue + (tempCurrentValue * percentResult)
        case .subtract:
            result = tempCurrentValue - (tempCurrentValue * percentResult)
        case .multiply:
            result = tempCurrentValue * (tempCurrentValue * percentResult)
        case .divide:
            result = tempCurrentValue / (tempCurrentValue * percentResult)
        }
        currentValue[currentValue.count - 2] = String(result)     //Stores the calculated value in the coresponding value in "currentValue"
        currentValue.removeLast()
        inputedOperators.removeLast()
    }
}

// C/AC
var valueClearCount = 0

@MainActor func clearValues() {     //Clears values / operators depending on the number of times called
    if currentValue.count > inputedOperators.count {        //removes the last added variable in "currentValue" if it was the most recent input
        currentValue.removeLast()
        valueClearCount = 1
    } else if valueClearCount == 1 && currentValue.count <= inputedOperators.count {        //Removes all values and operators from their arrays (Only runs if its already been..
        currentValue.removeAll()                                                            //..called once and the most recent input was an operator
        inputedOperators.removeAll()
        valueClearCount = 0
    } else if valueClearCount == 0 && currentValue.count <= inputedOperators.count {        //Adds 1 to "valueClearCount" if this is the first time being called, most recent input
        valueClearCount = 1                                                                 //was an operator
    }
}
    



@MainActor func equals() -> Double {        //Calculates the result based on stored values in "currentValue" and "inputedOperators"
    valuesDouble = currentValue.compactMap { Double($0) }       //Type casts values of "currentValue" into "valuesDouble" as type Double
    var index = 0
    
    while index < inputedOperators.count {      //Loops through all multiplication and division operations first (Keeps the order of operations correctly)
        switch inputedOperators[index] {
        case .multiply:
            valuesDouble[index] = valuesDouble[index] * valuesDouble[index + 1]
            valuesDouble.remove(at: index + 1)      //Removes left over value from calulation
            inputedOperators.remove(at: index)      //Removes the used operator from "inputedOperators" so that it doesn't run the same one twice
        case .divide:
            valuesDouble[index] = valuesDouble[index] / valuesDouble[index + 1]
            valuesDouble.remove(at: index + 1)
            inputedOperators.remove(at: index)
        default:
            index += 1
        }
    }
    var result = valuesDouble[0]
    
    for (index, inputedOperator) in inputedOperators.enumerated() {     //Loops through inputedOperators with an index value to calculate the remaining addition and subtraction
        switch inputedOperator {
        case .add:
            result += valuesDouble[index + 1]       //Adds value to result
        case .subtract:
            result -= valuesDouble[index + 1]       //Subtracts value from result
        default:
            break
        }
    }
    return result       //Returns the final result to the "equals()" func
}





//numberInputButton(value: 1)
//numberInputButton(value: 5)
//decimal()
//print(currentValue)
//print(inputedOperators)
//print("\n")
//
//add()
//numberInputButton(value: 2)
//invertSign()
//print(currentValue)
//print(inputedOperators)
//print("\n")
//
//
//divide()
//numberInputButton(value: 3)
//print(currentValue)
//print(inputedOperators)
//print("\n")
//
//
//multiply()
//numberInputButton(value: 8)
//print(currentValue)
//print(inputedOperators)
//print("\n")

numberInputButton(value: 1)
numberInputButton(value: 0) //10

add()
numberInputButton(value: 1)
numberInputButton(value: 0) //10
percentage()

add()
numberInputButton(value: 5)

multiply()
subtract()
numberInputButton(value: 1)



print(equals()) // Should equal 6


