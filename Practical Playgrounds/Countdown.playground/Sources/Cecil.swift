import Foundation
import Darwin

public class Cecil
{
    public let largeNumbers = Array((25 as Double).stride(through: 100, by: 25))
    public let smallNumbers = Array((1 as Double).stride(through: 10, by: 1))
    
    public init() {}
    
    public func generateTarget() -> Double
    {
        return Double(arc4random_uniform(UInt32(800))) + 100
    }
    
    public func howFarOffWasI(contestantReachedValue: Double, target: Double)
    {
        let distance = abs(target - contestantReachedValue)
        print("You were \(distance) off")
    }
}

extension Array
{
    mutating func popRandomElement() -> Element
    {
        if self.isEmpty
        {
            fatalError("oh dear, oh dear")
        }
        
        let index = Int(arc4random_uniform(UInt32(self.count)))
        
        return self.removeAtIndex(index)
    }
}