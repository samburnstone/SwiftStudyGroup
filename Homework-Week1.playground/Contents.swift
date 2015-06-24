//: Swift Homework

//: Palindrome

func verifyPalindrome(stringToValidate: String) -> Bool
{
    let charactersArray = generateCharacterArrayFromCollection(stringToValidate.characters)
    let reverseCharactersArray = generateCharacterArrayFromCollection(charactersArray.reverse())
    
    return charactersArray == reverseCharactersArray
}

func generateCharacterArrayFromCollection<T: CollectionType>(collection: T) -> [Character]
{
    var charactersArray = [Character]()
    
    for item in collection {
        
        if let item = item as? Character {
            charactersArray.append(item)
        }
    
    }
    
    return charactersArray
}

// Tests
verifyPalindrome("hannah") // Expect true
verifyPalindrome("sam") // Expect false
verifyPalindrome("thisisiht") // Expect true

//: FizzBuzz
let maximumValue = 100

for index in 1...maximumValue {
    
    var outputString: String = ""
     
    // fizz if multiple of 3
    if index % 3 == 0 {
        outputString += "fizz"
    }

    // buzz if five
    if index % 5 == 0 {
        outputString += "buzz"
    }
    
    print("\(index): \(outputString)")
}

//: Brackets

func verifyValidBracketString(bracketedString: String) -> Bool
{
    var openBracketStack = [Character]()
    
    func openBracketCharacterFromClosedBracketCharacter(closedBracketCharacter: Character) -> Character?
    {
        switch closedBracketCharacter {
        case "}": return "{"
        case "]": return "["
        case ")": return "("
        default: break
        }
        
        return nil
    }
    
    for character in bracketedString.characters
    {
        switch character
        {
        case "{", "(", "[":
            openBracketStack.insert(character, atIndex: 0)
            openBracketStack
        case "}", ")", "]":
            // Compare to item at top of stack
            if let characterAtTopOfStack = openBracketStack.first
            {
                if let openBracketCharacter = openBracketCharacterFromClosedBracketCharacter(character)
                {
                    if openBracketCharacter != characterAtTopOfStack {
                        return false
                    }
                }
            } else
            {
                return false
            }
            
            openBracketStack.removeAtIndex(0)
            print("Removing first item")
            openBracketStack
        default: break
        }
    }
    
    // Check whether we still have brackets that haven't been popped off the stack
    if !openBracketStack.isEmpty
    {
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


