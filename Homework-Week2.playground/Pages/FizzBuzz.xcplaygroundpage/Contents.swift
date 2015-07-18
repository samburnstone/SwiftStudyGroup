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

func fizz(index: Int) -> String {
    if index % 3 == 0 {
        return "fizz"
    }
    return ""
}

func buzz(index: Int) -> String {
    if index % 5 == 0 {
        return "buzz"
    }
    return ""
}

//: Example without using trailing closure
fizzBuzz({
    index in
    return fizz(index) + buzz(index)
})

//: Example using trailing closure
fizzBuzz() {
    index in
    return fizz(index) + buzz(index)
}

//: [Next](@next)
