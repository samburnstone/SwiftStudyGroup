//:# Naughty Word Filter

struct FlaggedWordToken
{
    let range: Range<Int>
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
        return []
    }
}

//:## Banned Words Tests

let naughtyWords = ["corbyn", "porcine", "nhs"]

let bannedWordsParser = BannedWordsParser(bannedWordsList: naughtyWords)

func test_empty_message_results_in_no_flagged_words()
{
    let bannedWords = bannedWordsParser.parse("")
    
    samAssertTrue(bannedWords.count == 0)
}

func test_docile_message_results_in_no_flagged_words()
{
    let message = "Bunny rabbits are fluffy!"
    
    let bannedWords = bannedWordsParser.parse(message)
    
    samAssertTrue(bannedWords.count == 0)
}

//: Run the tests

/// Basic method that prints out a nicely formatted string to the console depending on value passed as `condition` parameter
func samAssertTrue(@autoclosure conditon: () -> Bool, methodName: String = __FUNCTION__)
{
    let icon = conditon() ? "✔︎" : "✖️"
    
    print("\(methodName) \(icon)")
}

print("\nRunning tests...\n")
test_empty_message_results_in_no_flagged_words()
test_docile_message_results_in_no_flagged_words()
