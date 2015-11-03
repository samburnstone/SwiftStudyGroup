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

//: We can use a function to generate a character array from a string
func generateCharacterArrayFromCollection<T: CollectionType>(collection: T) -> [Character] {
    var charactersArray = [Character]()
    
    for item in collection {
        
        if let item = item as? Character {
            charactersArray.append(item)
        }
    
    }
    
    return charactersArray
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
