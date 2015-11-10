//:# Naughty Word Filter

import Foundation
import UIKit

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

func test_wordRedactor_replaces_banned_word_with_asterisks()
{
    let message = "Vote for corbyn"
    
    let flaggedWords = bannedWordsParser.parse(message) // Would probably mock the parser if we were doing 'proper' testing
    
    let redactor = WordRedactor()
    let redactedMessage = redactor.santiseMessage(message, bannedWords: flaggedWords)
    
    samAssertTrue(redactedMessage == "Vote for ******")
}

func test_wordStrikeThroughHighlighter_strikes_through_banned_word()
{
    let message = "Vote for corbyn"
    
    let flaggedWords = bannedWordsParser.parse(message)
    
    let strikeThrougher = WordStrikeThroughHighlighter()
    
    let struckThroughMessage = strikeThrougher.highlightWordsInMessage(message, flaggedWordTokens: flaggedWords)
    
    let expected = NSMutableAttributedString(string: message)
    expected.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(integer: 2), range: NSMakeRange(9, 6))
    
    samAssertTrue(struckThroughMessage.isEqualToAttributedString(expected))
}

//: Run the tests

/*:
 Basic method that prints out a nicely formatted string to the console depending on value passed as `condition` parameter

 To ensure the `__FUNCTION__` identifier expands to evaluate to the test that calls this method we define it as a default argument - see: https://developer.apple.com/swift/blog/?id=15
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

// Word sanistisers
test_wordRedactor_replaces_banned_word_with_asterisks()
test_wordStrikeThroughHighlighter_strikes_through_banned_word()
