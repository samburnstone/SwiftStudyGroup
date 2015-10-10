//: [Previous](@previous)

//:## Protocols

import UIKit

//: Protocol properties are always marked with `var`
//: ________
//: **Note**: If a protocol requires a property to be gettable and settable, that property requirement cannot be fulfilled by a constant stored property or a read-only computed property. If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property, and it is valid for the property to be also settable if this is useful for your own code.
protocol Postionable
{
    var position: CGPoint { get }
}

//: Bare bones version: Create a brand-spanking new struct and make it conform to the protocol
struct Square: Postionable
{
    let position: CGPoint
}

//: Little bit more interesting: use a computed property (we can do this because the position property on the protocol doesn't have to be writable) to return a different property's value
extension UIView: Postionable
{
    var position: CGPoint
    {
        return center
    }
}

let square = Square(position: CGPoint(x: 0, y: 0))
let view = UIView()
view.center = CGPoint(x: 100, y: 100)

let positionables: [Postionable] = [square, view] // Need to declare types within array as otherwise get an 'ambiguous type' warning

positionables.forEach
{
    print($0.position)
}

//: Let's me snarky and create a non-random random number generator

protocol VendingType
{
    mutating func dispense() // Mark as mutating so structs can use it
}

class CoffeeMachine: VendingType
{
    func dispense()
    {
        print("Dispensing coffee 🍵")
    }
}

//: This seemed interesting - compiler complains if machine is a `let` constant - perhaps unsurprising as it knows `dispense` is a `mutating` function, but it doesn't necessarily know that machine is a class
var machine: VendingType = CoffeeMachine()
machine.dispense()

//: Now let's give it a go with a struct
struct TeaLady: VendingType
{
    var teaCount = 0
    
    mutating func dispense()
    {
        teaCount++
    }
}

var teaLady = TeaLady()
teaLady.dispense()
teaLady.dispense()
teaLady.teaCount

//: Protocol Inheritance

protocol Printable
{
    var printableDescription: String { get }
}

protocol GorgeouslyFabulousPrintable: Printable
{
    var prettyPrintableDescription: String { get }
}

struct Person: GorgeouslyFabulousPrintable
{
    let name: String
    
    var printableDescription: String
    {
        return "\(name)"
    }
    
    // Nothing too fancy going on here... we just augment the bare bones 'printableDescription' with an emoji icon prepended to it
    var prettyPrintableDescription: String
    {
        return "👦 \(printableDescription)"
    }
}

let sam = Person(name: "Sam")
sam.printableDescription
sam.prettyPrintableDescription

//: [Next](@next)
