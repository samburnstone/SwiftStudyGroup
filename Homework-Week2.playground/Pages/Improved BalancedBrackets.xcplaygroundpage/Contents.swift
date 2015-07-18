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
    
    var isEmpty: Bool {
        get  { return items.count == 0 }
    }
    
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

//: Here's the real stuff
func verifyValidBracketString(bracketedString: String) -> Bool {
    var bracketStack = Stack<Character>()
    
    func openBracketCharacterFromClosedBracketCharacter(closedBracketCharacter: Character) -> Character? {
        switch closedBracketCharacter {
        case "}": return "{"
        case "]": return "["
        case ")": return "("
        default: break
        }
        
        return nil
    }
    
    for character in bracketedString.characters {
        switch character {
        case "{", "(", "[":
            bracketStack.push(character)
        case "}", ")", "]":
            // Compare to item at top of stack
            guard let characterAtTopOfStack = bracketStack.pop() else { return false }
            
            guard let openBracketCharacter = openBracketCharacterFromClosedBracketCharacter(character) else { return false }
  
            if openBracketCharacter != characterAtTopOfStack {
                return false
            }
        default: break
        }
    }
    
    // Check whether we still have brackets that haven't been popped off the stack
    if !bracketStack.isEmpty {
        return false
    }
    
    return true
}

//: Tests
verifyValidBracketString("")
verifyValidBracketString("()")
verifyValidBracketString("[]")
verifyValidBracketString("(([]{}))")
verifyValidBracketString("{sam is cool}")

verifyValidBracketString("{") == false
verifyValidBracketString("{{{{{]") == false
verifyValidBracketString("{sam is cool}]") == false
//: [Next](@next)
