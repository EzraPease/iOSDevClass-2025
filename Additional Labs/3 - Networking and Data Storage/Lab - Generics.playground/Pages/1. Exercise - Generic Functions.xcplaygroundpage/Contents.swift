/*:
## Exercise - Generic Functions
 
 The `duplicate` function below works only when working with Ints, but its body could work with any type. Rewrite the function to use a generic type `<T>` instead. Test your new function by calling it several times, using a String, an Int, and a Double.
 */

import Foundation

func duplicate(_ int: Int) -> (Int, Int) {
    return (int, int)
}

//:  The function below retrieves a random value from an array of Ints and then deletes that value. The `inout` keyword means that it modifies the array passed into it directly. This function could work with an array of any type, so long as the type conforms to Equatable. Rewrite the function to use a generic type `<U>` instead, constraining to Equatable types. Test your new function by calling it several times, using an array of Strings, of Ints, and of Doubles.

func pullRandomElement(_ array: inout [Int]) -> Int? {
    let randomElement = array.randomElement()
    
    guard let randomElement, let index = array.firstIndex(of: randomElement) else { return nil }
    array.remove(at: index)
    
    return randomElement
}

//:  The function below sorts an array, then returns a new array containing only the first and last Strings of the array after sorting. This function could work with an array of any type, so long as the type conforms to Comparable. Rewrite the function to use a generic type `<V>` instead, constraining to Comparable types. Test your new function by calling it several times, using an array of Strings, of Ints, and of Doubles.

func minMaxArray(_ array: [String]) -> [String] {
    var output: [String] = []
    
    let minElement = array.min()
    let maxElement = array.max()
    
    if let minElement {
        output.append(minElement)
    }
    
    if let maxElement {
        output.append(maxElement)
    }
    
    return output
}

/*:
page 1 of 4  |  [Next: Exercise - Generic Types](@next)
 */
