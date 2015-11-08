public protocol WordSanitiser
{
    /// Modifies `message` based on banned words contained within `bannedWords` array
    func santiseMessage(message: String, bannedWords: [FlaggedWordToken]) -> String
}

public class WordRedactor: WordSanitiser
{
    public init() {}
    
    public func santiseMessage(message: String, bannedWords: [FlaggedWordToken]) -> String
    {
        var redactedMessage = message
        
        for bannedWord in bannedWords
        {
            let redactedString = redactString(bannedWord.word)
            redactedMessage.replaceRange(bannedWord.range, with: redactedString)
        }
        
        return redactedMessage
    }
    
    private func redactString(string: String) -> String
    {
        return String(count: string.characters.count, repeatedValue: Character("*")) // Have to explicitly create `repeatedValue` as a Character otherwise get an ambiguous use of init(count:repeatedValue:)
    }
}