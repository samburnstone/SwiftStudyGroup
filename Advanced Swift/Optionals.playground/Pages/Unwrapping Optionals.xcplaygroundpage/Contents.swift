//: [Previous](@previous)
import Foundation
import UIKit

let numbers = [1, 2, 3, 4, 5]

//: Our good old friend, `if let`
if let indexOfTwo = numbers.indexOf(2)
{
    indexOfTwo
}

if let indexOfOne = numbers.indexOf(1) where indexOfOne != numbers.startIndex
{
    // Don't enter this due to our 'where' clause
}

let imageName = "chilli_jam.jpg"

if let url = NSURL(string: imageName) where url.pathExtension == ".jpg",
    let data = NSData(contentsOfURL: url)
{
    // If chilli_jam.jpg existed, then we'd enter this block
    print("Here we are")
}

class Counter
{
    var _counter = 0
    
    /// Increments until it reaches 7... cos no numbers exist beyond that
    func increment() -> Int?
    {
        if _counter == 7
        {
            return nil
        }
        
        _counter += 1
        
        return _counter
    }
}

let counter1 = Counter()

//: `while let`
while let value = counter1.increment()
{
    print("Value: \(value)")
}

let counter2 = Counter()

print("\nConstrained counter")
while let value = counter2.increment() where value < 5
{
    print("Value: \(value)")
}

// `for case` - bit of pattern matching when iterating through collections that contain optional values
let funkyArray: [Int?] = [1, 5, 8, nil, 10, nil]

var nonOptionalCount = 0
for case let i? in funkyArray // shorthand for 'for cast let .Some(i)
{
    nonOptionalCount += 1
}

var optionalCount = 0
for case nil in funkyArray
{
    optionalCount += 1
}

let result = "There are \(nonOptionalCount) non-optional values and \(optionalCount) optional values in 'funkArray'"

//: Optional chaining

// Optional chaining is normally a 'flattening' operation i.e.
let view: UIView? = UIView()
view?.layer.cornerRadius = 2 // Only optional required is after view, as other properties are non optional

// However... if the method/property being accessed itself returns an optional value:
extension Int {
    func half() -> Int? {
        guard self > 1 else { return nil }
        return self / 2
    }
}

20.half()?.half()?.half()

//: Nil Coalescing
let i = numbers.first ?? 10 // 10 if numbers.first does not exist

var hello: [Int] = []
hello.first ?? 10

//: [Next](@next)
