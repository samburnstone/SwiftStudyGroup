//: [Previous](@previous)
/*:
## Balanced Brackets (Improved)
*/

import Foundation

//: Completely unnecessary, however there's an append... why not a prepend? Let's make one!
extension Array {
    mutating func prepend(item: T) {
        self.insert(item, atIndex: 0)
    }
}

//: Now for the Big Boy
struct Stack<T> {
    private var items = [T]()
    
    mutating func push(item: T) {
        items.prepend(item)
    }
    
    mutating func pop() -> T? {
    
        if let topItem = items.first {
            items.removeAtIndex(0)
            return topItem
        }
        return nil
    }
    
}

//: Before doing anything too fancy, let's test our Stack implementation
var stack = Stack<Character>()
stack.push("[")
stack.push("{")
stack.push("}")

stack.items == ["}", "{", "["]

stack.pop()

// This is quite fun, Swift infers this is an array of Strings
//let itemsAdded = ["{", "["]
// However, if we create the array inline, Swift is smart enough to infer we want to compare an array of Characters
stack.items == ["{", "["]
//: [Next](@next)
