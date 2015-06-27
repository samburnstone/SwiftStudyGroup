//: [Previous](@previous)

import Foundation

//: Brackets

func verifyValidBracketString(bracketedString: String) -> Bool {
    var openBracketStack = [Character]()
    
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
            openBracketStack.insert(character, atIndex: 0)
            openBracketStack
        case "}", ")", "]":
            // Compare to item at top of stack
            if let characterAtTopOfStack = openBracketStack.first {
                if let openBracketCharacter = openBracketCharacterFromClosedBracketCharacter(character) {
                    if openBracketCharacter != characterAtTopOfStack {
                        return false
                    }
                }
            } else {
                return false
            }
            
            openBracketStack.removeAtIndex(0)
            print("Removing first item")
            openBracketStack
        default: break
        }
    }
    
    // Check whether we still have brackets that haven't been popped off the stack
    if !openBracketStack.isEmpty {
        return false
    }
    
    return true
}

// Tests
verifyValidBracketString("") // Expect true
verifyValidBracketString("()") // Expect true
verifyValidBracketString("[]") // Expect true
verifyValidBracketString("(([]{}))") // Expect true

verifyValidBracketString("{") // Expect false
verifyValidBracketString("{{{{{]") // Expect false

//: [Next](@next)
