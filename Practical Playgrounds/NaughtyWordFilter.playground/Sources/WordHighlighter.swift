import Foundation
import UIKit

public protocol WordHighlighter
{
    func highlightWordsInMessage(message: String, flaggedWordTokens: [FlaggedWordToken]) -> NSAttributedString
}

public class WordStrikeThroughHighlighter: WordHighlighter
{
    public init() {}
    
    public func highlightWordsInMessage(message: String, flaggedWordTokens: [FlaggedWordToken]) -> NSAttributedString
    {
        let highlightedMessage = NSMutableAttributedString(string: message)
        
        for flaggedWord in flaggedWordTokens
        {
            let range = RangeToLegacyRangeConverter.legacyRangeFromFlaggedWord(flaggedWord, message: message)
            highlightedMessage.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(integer: 2), range: range)
        }
        
        // Return an immutable attributed string
        return NSAttributedString(attributedString: highlightedMessage)
    }
}

public class WordRedHighlighter: WordHighlighter
{
    public init() {}
    
    public func highlightWordsInMessage(message: String, flaggedWordTokens: [FlaggedWordToken]) -> NSAttributedString
    {
        let highlightedMessage = NSMutableAttributedString(string: message)
        
        for flaggedWord in flaggedWordTokens
        {
            let range = RangeToLegacyRangeConverter.legacyRangeFromFlaggedWord(flaggedWord, message: message)
            highlightedMessage.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: range)
        }
        
        // Return an immutable attributed string
        return NSAttributedString(attributedString: highlightedMessage)
    }
}

struct RangeToLegacyRangeConverter
{
    static func legacyRangeFromFlaggedWord(flaggedWord: FlaggedWordToken, message: String) -> NSRange
    {
        let startIndex = message.startIndex.distanceTo(flaggedWord.range.startIndex)
        let endIndex = flaggedWord.range.startIndex.distanceTo(flaggedWord.range.endIndex)
        return NSMakeRange(startIndex, endIndex)
    }
}