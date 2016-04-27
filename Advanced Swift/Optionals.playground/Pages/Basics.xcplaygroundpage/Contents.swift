//:## Optionals

/*:
 Optional is represented as an enum
 ```
 enum Optional<T> {
     case None
     case Some(T)
 }
 ```
 
 [Swift source file for Optional](https://github.com/apple/swift/blob/master/stdlib/public/core/Optional.swift)
*/
// The following two methods are equivalent
func optional1() -> Optional<Int>
{
    return .Some(10)
}

let returnedVal1 = optional1()

func optional2() -> Int?
{
    return 10
}

let returnedVal2 = optional2()

func some_CRAY_func_that_requires_non_optional_int(nonOptionalInt: Int)
{
    print("\(nonOptionalInt) is not an optional value")
}

// Note that we have to unwrap the values for the code to compile
some_CRAY_func_that_requires_non_optional_int(returnedVal1!)
some_CRAY_func_that_requires_non_optional_int(returnedVal2!)

// Optional conforms to NilLiteralConvertible - the following lines are equivalent
// see:
let optionalString1: String? = .None
let optionalString2: String? = nil

// I couldn't help myself...
class DOG: NilLiteralConvertible
{
    required init(nilLiteral: ()) {
        print("Initialising DOG with nil")
    }
}

let dog: DOG = nil

//: [Next](@next)
