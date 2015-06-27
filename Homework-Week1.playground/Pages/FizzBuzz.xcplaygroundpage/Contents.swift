//: [Previous](@previous)
/*:
## FizzBuzz
*/
let maximumValue = 100

for index in 1...maximumValue {
    
    var outputString: String = ""
    
    // fizz if multiple of 3
    if index % 3 == 0 {
        outputString += "fizz"
    }
    
    // buzz if five
    if index % 5 == 0 {
        outputString += "buzz"
    }
    
    print("\(index): \(outputString)")
}

//: [Next](@next)
