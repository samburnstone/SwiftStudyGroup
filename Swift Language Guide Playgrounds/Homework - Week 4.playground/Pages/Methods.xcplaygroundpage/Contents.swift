//: [Previous](@previous)
import UIKit // Import UIKit so we can use CGPoints

//: Class / static method
class AdderClass {
    
    // Type method
    class func addNumbers(num1: Double, num2: Double) -> Double {
        return num1 + num2
    }
    
    // Instance method
    func addNumbers(num1 num1: Double, num2: Double) -> Double {
        return AdderClass.addNumbers(num1, num2: num2)
    }
    
    func addNumber(num1: Double, toNumber num2: Double, numberOfTimes: UInt) -> Double {
        return (Double(numberOfTimes) * num1) + num2
    }
    
}

// Type method
AdderClass.addNumbers(10, num2: 5)

// Instance method
let adder = AdderClass()
adder.addNumbers(num1: 10, num2: 2)

adder.addNumber(1, toNumber: 0, numberOfTimes: 10)

//: Type methods using structs

struct AdderStruct {
    
    // Note we're using static func, rather than class func
    static func addNumbers(num1: Double, num2: Double) -> Double {
        return num1 + num2
    }
    
}

AdderStruct.addNumbers(10, num2: 5)

// Type methods can also be added to enumerations as well

//: Structs - mutating functions

// Let's chuck in some generics
struct Queue <Element> {
    var items = [Element]()
    
    // As it's struc and we're modifying our instance variables, this function needs to be marked as 'mutating'
    mutating func push(item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element? {
        if !items.isEmpty {
            return items.removeFirst()
        }
        return nil
    }
    
    func peek() -> Element? {
        return items.first
    }
    
    // Mildly crazy... we can assign an entirely new instance to self
    mutating func empty() {
        self = Queue<Element>()
    }
}

// Create our queue and fill it with doubles
var queue = Queue<Double>()
queue.push(2.0)
queue.push(1.0)
queue.peek()
queue.pop()
queue.pop()
queue.pop() // Phew, we haven't crashed

queue.push(10)
queue.push(20)

queue.items

queue.empty()

queue.items // See... we're empty!
//: [Next](@next)
