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
            let startIndex = message.startIndex.distanceTo(flaggedWord.range.startIndex)
            let endIndex = flaggedWord.range.startIndex.distanceTo(flaggedWord.range.endIndex)
            highlightedMessage.addAttribute(NSStrikethroughStyleAttributeName, value: NSNumber(integer: 2), range: NSMakeRange(startIndex, endIndex))
        }
        
        // Return an immutable attributed string
        return NSAttributedString(attributedString: highlightedMessage)
    }
}