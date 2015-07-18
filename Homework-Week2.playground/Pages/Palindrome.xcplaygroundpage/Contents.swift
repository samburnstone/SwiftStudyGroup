/*: 
# Swift Homework

----

## Palindrome
*/

func verifyPalindrome(stringToValidate: String) -> Bool {
    let charactersArray = stringToValidate.characters.toCharacterArray()
    let reverseCharactersArray = charactersArray.reverse().toCharacterArray()
    
    return charactersArray == reverseCharactersArray
}

func verifyPalindrome(characterArray: [Character]) -> Bool {
    return verifyPalindrome(String(characterArray))
}

//: Or we can use a protocol extension
extension CollectionType {
    func toCharacterArray() -> [Character] {
        var charactersArray = [Character]()
        
        for item in self {
            
            if let item = item as? Character {
                charactersArray.append(item)
            }
            
        }
        
        return charactersArray
    }
}

//: Tests
verifyPalindrome("hannah")
verifyPalindrome("thisisiht")
verifyPalindrome("sam") == false

// Overloaded character array version of function
verifyPalindrome(["h", "a", "n", "n", "a", "h"])
verifyPalindrome(["n", "o", "p", "e"]) == false
