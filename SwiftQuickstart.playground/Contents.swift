//: ## Quickfire introduction to Swift
//: Inspired by http://learnxinyminutes.com/docs/swift/

//: Swift imports all files within the current module automcatically

//: When using other modules, we import them like:
import UIKit

//: Printing to the console
println("Hello everybody, I hope you aren't bored!")

//: ## Variables
//: Apple (and general programming guidelines) encourage the use of constants whenever we're certain a value shouldn't be mutated.
//: Constants are represented using the *let* keyword:
let constant = 40
// COMPILER ERROR: constant = 10

//: We don't have to immediately assign values to a constant, however once it has been assigned a value, we can't reassign one
//: We also need to ensure it has a value before we can use it (we'll get a ghastly compilation error otherwise!)
//: N.B. Swift tries its best to **infer** the type being assigned to a constant/variable. However, when we're not assigning anything immediately, we need to give it a bit of a helping hand
let animal = "Beetle"
let numberOfLegs: UInt

if animal == "Beetle" {
    numberOfLegs = 6
}
else {
    numberOfLegs = 2
}

//: We can use *string interpolation* to directly print out values into a string. Objective-C develops rejoice!!!
println("A \(animal) has \(numberOfLegs) legs")

//: A small nicety of Swift is the ability to use any unicode character for a variable name
let € = "Euro"
let 🐷 = "Oink"

println(🐷)

//: ## Optionals
//: Due to Swift being an inherently *safe* language, every variable (constant or otherwise) must have a value.
//: Optionals provide an indication when a value could possibly be nil - if it ain't optional then it's almost certainly not nil
var optionalString: String?

println(optionalString)

optionalString = "No longer nil"
println(optionalString)

if optionalString == "No longer nil" {
    println("The optional contains a value")
}

//: If a variable is not marked as being optional (indicated by ?) then nil cannot be assigned to it
var nonNilString = "Are you all still awake?"
// COMPILER ERROR: nonNilString = nil

 //: **Unwrapping** optionals to get at the sweet, sweet value contained within it.
// So we can do this:
if optionalString != nil {
    // optional is not nil
}

// But how do we get the non-optional value out of it:
if optionalString != nil {
    println(optionalString)
    println(optionalString!) // Force unwrap is safe as we know optionalString is not nil
}

//: Force unwrapping is a little dangerous if we just use it liberally without checking whether an optional contains a value
var nilOptional: String?

// RUNTIME ERROR: println(nilOptional!)

//: There's a nicer way of unwrapping optional values...
var stringToUnwrap: String? = "Beetle"
println(stringToUnwrap)

if let animal = stringToUnwrap {
    println(animal) // No longer 'optional'
}

//: ## Collections

//: ### Arrays
//: Arrays (as with any other object/struct/enum) can be constant or 'variable'
var nerds = ["Sam", "Rob", "Ryan", "Chris", "Andy"] // This is inferred to be of type [String]
nerds[0] // Use subscripting
nerds.append("James")

let untouchableNerds = nerds
// COMPILER ERROR: untouchableNerds.append("Dan")

//: ### Dictionaries
var occupations = [
    "Rob" : "Nerd",
    "Chris" : "Loser"
] // This is inferred to be of type [String : String]

//: N.B. Sets were added in version 1.2 of the language. Some collections do not yet have a Swift implementation, but we can continue using the Objective-C implementations for now.

//: ## Control Flow

//: We can iterate over items in an array using a for in loop
for nerd in nerds {
    println(nerd)
}

//: ..< excludes last number
for index in 0..<nerds.count {
    println(index)
    println(nerds[index])
}

//: ... includes last number
for index in 0...nerds.count {
    println(index)
}

//: Alternatively we could use Swift's version of the classic for (i = 0; i < 10; i++)
for var index = 0; index < 3; ++index {
    println("index is \(index)")
}

//: While loops are very familiar
var i = 0
while i < nerds.count {
    println(i)
    i++
}

//: Switch statements are a lot more powerful than they were in Objective-C.
//: Note that there's no **break** statement required - no 'fall-through' to next case and that a *default* case is required
let nerd = "Sam"

switch nerd {
    case "Sam": println("A fine choice of nerd!")
    default: // Required
    println("You should reconsider your choice of nerd!")
}

let boardPosition = (0, -1)

switch boardPosition {
case (0, 0): println("You haven't moved yet")
case (_, 1...10): println("Your position on y axis is greater than 0!!!")
default: println("You're off the board moron!")
}

//: ## Functions
//: Swift treats functions as *first-class citizens*, effectively meaning they can be passed around like objects and structs.
func sayHelloTo(name: String = "Sam") {
    println("Hello \(name)")
}

sayHelloTo() // Use default parameter
sayHelloTo(name: "Chris")

//: Swift also has support for tuples
func getPrices() -> (Double, Double) {
    return (0.79, 1.50)
}

let prices = getPrices()

//: Due to this first-class citizen thing, we can assign functions to variables and pass them around.

func makeIncrementer() -> (Int -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    
    return addOne
}

let incrementer = makeIncrementer()
incrementer(7)
