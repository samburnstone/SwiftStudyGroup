//:# Naughty Word Filter
import Foundation

struct FlaggedWordToken
{
    let range: Range<String.CharacterView.Index>
    let word: String
}

class BannedWordsParser
{
    let bannedWordsList: [String]
    
    init(bannedWordsList: [String])
    {
        self.bannedWordsList = bannedWordsList
    }
    
    func parse(message: String) -> [FlaggedWordToken]
    {
        let transformedString = message.lowercaseString // For now, assume no punctuation and allwe need to do is convert to lowercase
        
        let wordTokens = transformedString.characters.split { $0 == " " }.map(String.init)
        
        // Iterate through each word, keeping track of the current index
        var index = transformedString.startIndex
        var flaggedWordTokens = [FlaggedWordToken]()
        
        for word in wordTokens
        {
            if bannedWordsList.contains(word)
            {
                let rangeInMessage = index...(index.advancedBy(word.characters.count - 1))
                flaggedWordTokens.append(FlaggedWordToken(range: rangeInMessage, word: word))
            }
            
            index = index.advancedBy(word.characters.count + 1, limit: message.characters.endIndex)
        }
        
        return flaggedWordTokens
    }
    
}

//:## Banned Words Tests

let naughtyWords = ["corbyn", "porcine", "pilling"]

let bannedWordsParser = BannedWordsParser(bannedWordsList: naughtyWords)

func test_parsing_of_empty_message_results_in_no_flagged_words()
{
    let bannedWords = bannedWordsParser.parse("")
    
    samAssertTrue(bannedWords.count == 0)
}

func test_parsing_of_docile_message_results_in_no_flagged_words()
{
    let message = "Bunny rabbits are fluffy!"
    
    let bannedWords = bannedWordsParser.parse(message)
    
    samAssertTrue(bannedWords.count == 0)
}

func test_parsing_of_enemy_propaganda_message_results_in_two_flagged_words()
{
    let message = "We believe in Corbyn for he is our saviour from the porcine lovers"
    
    let bannedWords = bannedWordsParser.parse(message)
    
    samAssertTrue(bannedWords.count == 2)
}

func test_range_of_flagged_word_at_beginning_of_message()
{
    let message = "pilling is a fool"
    
    let bannedWords = bannedWordsParser.parse(message)
    
    let range = bannedWords[0].range
    
    let substringWithGivenRange = message.substringWithRange(range)
    
    samAssertTrue(substringWithGivenRange == "pilling")
}

func test_range_of_flagged_word_in_middle_of_message()
{
    let message = "fifty reasons why corbyn is..."
    
    let bannedWords = bannedWordsParser.parse(message)
    
    let range = bannedWords[0].range
    
    let substringWithGivenRange = message.substringWithRange(range)
    
    samAssertTrue(substringWithGivenRange == "corbyn")
}

func test_range_of_flagged_word_at_end_of_message()
{
    let message = "porcine porcine porcine"
    
    let bannedWords = bannedWordsParser.parse(message)
    
    let range = bannedWords[2].range
    
    let substringWithGivenRange = message.substringWithRange(range)
    
    samAssertTrue(substringWithGivenRange == "porcine")
}

//: Run the tests

/*:
 Basic method that prints out a nicely formatted string to the console depending on value passed as `condition` parameter

 To be ensure the `__FUNCTION__` identifier expands to evaluate to the test that calls this method we define it as a default argument - see: https://developer.apple.com/swift/blog/?id=15
*/
func samAssertTrue(@autoclosure conditon: () -> Bool, methodName: String = __FUNCTION__)
{
    let icon = conditon() ? "✔︎" : "✖️"
    
    print("\(methodName) \(icon)")
}

print("\nRunning tests...\n")

// Message parsing tests
test_parsing_of_empty_message_results_in_no_flagged_words()
test_parsing_of_docile_message_results_in_no_flagged_words()
test_parsing_of_enemy_propaganda_message_results_in_two_flagged_words()

// Range calculation tests
test_range_of_flagged_word_at_beginning_of_message()
test_range_of_flagged_word_in_middle_of_message()
test_range_of_flagged_word_at_end_of_message()
