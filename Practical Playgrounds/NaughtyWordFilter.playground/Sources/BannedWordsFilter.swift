import Foundation

public struct FlaggedWordToken
{
    public let range: Range<String.CharacterView.Index>
    public let word: String
}

public class BannedWordsParser
{
    private let bannedWordsList: [String]
    
    public init(bannedWordsList: [String])
    {
        self.bannedWordsList = bannedWordsList
    }
    
    public func parse(message: String) -> [FlaggedWordToken]
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