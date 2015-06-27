//: Swift Homework

//: Palindrome

func verifyPalindrome(stringToValidate: String) -> Bool {
    let charactersArray = generateCharacterArrayFromCollection(stringToValidate.characters)
    let reverseCharactersArray = generateCharacterArrayFromCollection(charactersArray.reverse())
    
    return charactersArray == reverseCharactersArray
}

func generateCharacterArrayFromCollection<T: CollectionType>(collection: T) -> [Character] {
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