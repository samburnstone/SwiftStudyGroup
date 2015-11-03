import Foundation
import Darwin

extension Array // This could probably be 'MutableCollectionType' as long as Index == Int
{
    // From http://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
    public mutating func shuffleInPlace()
    {
        if count < 2 { return }
        
        for i in 0..<(count - 1)
        {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            
            swap(&self[i], &self[j])
        }
    }
    
    public func shuffle() -> [Generator.Element] // Return array with same type of content
    {
        var tempArray = self
        tempArray.shuffleInPlace()
        return tempArray
    }
}