//: [Previous](@previous)
/*:
## FizzBuzz
*/
let maximumValue = 100

//: We'll define an alias... because we can
typealias outputResult = Int -> String

//: Now for the core function
func fizzBuzz(f: outputResult) {
    for i in 1...maximumValue {
        f(i)
    }
}

//: Example without using trailing closure
fizzBuzz({
    index in
    var output = ""
    if index % 3 == 0 {
        output += "fizz"
    }
    if index % 5 == 0 {
        output += "buzz"
    }
    return output
})

//: Example using trailing closure
fizzBuzz() {
    index in
    var output = ""
    if index % 3 == 0 {
        output += "fizz"
    }
    if index % 5 == 0 {
        output += "buzz"
    }
    return output
}

//: [Next](@next)
