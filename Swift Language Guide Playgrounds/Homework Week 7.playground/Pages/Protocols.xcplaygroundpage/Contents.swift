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

//: Little bit more interesting: use a read-only computed property (we can do this because the position property on the protocol doesn't have to be writable) to return a different property's value
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

//: Let's be snarky and create a non-random random number generator

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

//:### Protocol Inheritance

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

//:### Protocol composition
//: __________
//: We can force a parameter/property to conform to multiple specific protocols
protocol DeveloperType {}

protocol Named
{
    var name: String { get }
}

struct Developer {
    let name: String
}

extension Developer: Named {}
extension Developer: DeveloperType {}

func learnNewProgrammingSkill(developer: protocol<Named, DeveloperType>)
{
    print("Greetings \(developer.name)! Have you tried React Native? It's the new fish in the sea!")
}

let developer = Developer(name: "Nerd") // Note, that if we declared the type to be 'DeveloperType' or 'Named' then we'd get a compiler error when passing the constant to the function
learnNewProgrammingSkill(developer)

//:### Extending Protocols
//: ________
//: Let's add a method to `SignedIntegerType` which just simply flips the sign of the value (i.e. negative number becomes positive counterpart and vice versa).
//: `SignedNumberType` defines `prefix func -(x: Self) -> Self` which we make use of to get the 'flipped' value
extension SignedNumberType
{
    func flip() -> Self
    {
        return -self;
    }
}

//: We can now use this method on any type that conforms to `SignedIntegerType` e.g. `Float`, `Int, `Double`, e.t.c
var integerValue = 10
var doubleValue = -3.0

integerValue.flip()
doubleValue.flip()

//:### Default Protocol Implementations
//: _________
//: Example based on something I noticed when working on Enterprise Charts - want a small amount of shared code between two protocol implementations without having to implement classes and add `fatalError("Implement in subclass")`
protocol WindowInserter
{
    func numberOfPointsInNextWindow() -> UInt
    func hasPointsRemainingToWindow() -> Bool
}

//: Extend protocol with default implementation of method
extension WindowInserter
{
    func hasPointsRemainingToWindow() -> Bool
    {
        return numberOfPointsInNextWindow() > 0
    }
}

struct WindowAppender: WindowInserter
{
    func numberOfPointsInNextWindow() -> UInt
    {
        return 100
    }
    // Notice how we don't have to implement `hasPointsRemainingToWindow`?
}

struct WindowPrepender: WindowInserter
{
    func numberOfPointsInNextWindow() -> UInt
    {
        return 0
    }
}

WindowAppender().hasPointsRemainingToWindow()
WindowPrepender().hasPointsRemainingToWindow()

//:### Add Constraints to Protocols

protocol RecipeIngredientType
{
    var item: String { get }
    var amount: UInt { get }
}

struct Ingredient: RecipeIngredientType
{
    let item: String
    let amount: UInt
}

let recipeItems = [
    Ingredient(item: "Eggs", amount: 6),
    Ingredient(item: "Sugar", amount: 200),
    Ingredient(item: "Baked Beans", amount: 56),
    Ingredient(item: "Birds-Eye Chilli", amount: 150)
]

//: We'll add an extension to any collection type, but add a constraint that the type of `Generator.Element` must conform to `RecipeIngredientType`
//: __________
//: Note that `Generator` is a type that encapsulates the collection's iteration state, while `Generator.Element` is the type 'generated' by the Generator (i.e. the type of the items included within the collection)
extension CollectionType where Generator.Element: RecipeIngredientType
{
    func asBulletedList() -> String
    {
        var bulletedString: String = ""
        
        for ingredient: RecipeIngredientType in self
        {
            bulletedString += "• \(ingredient.amount) x \(ingredient.item)\n"
        }
        
        return bulletedString
    }
}

recipeItems.asBulletedList()


//: [Next](@next)
