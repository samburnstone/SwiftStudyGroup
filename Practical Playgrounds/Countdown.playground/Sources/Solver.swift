import Foundation

public protocol CountdownPuzzleSolvingType
{
    func attemptToReachTarget(target: Double, usingNumbers: [Double]) -> Double
}

extension CountdownPuzzleSolvingType
{
     public func attemptToReachTarget(target: Double, usingNumbers: [Double]) -> Double
     {
        print("Computer says no")
        return 0
    }
}

public struct StupidSolver: CountdownPuzzleSolvingType
{
    public func attemptToReachTarget(target: Double, usingNumbers: [Double]) -> Double {
        return reachTarget(target, usingNumbers: usingNumbers, currentValue: 0)
    }
    
    private func reachTarget(target: Double, usingNumbers: [Double], currentValue: Double) -> Double
    {
        if usingNumbers.isEmpty || currentValue == target
        {
            return currentValue
        }
        
        var numbersRemaining = usingNumbers
        
        let number = numbersRemaining.removeFirst()
        
        let newValue = performRandomOperationOnOperand(currentValue, and: number)
        
        print("New total is: \(newValue)")
        
        return currentValue + reachTarget(target, usingNumbers: numbersRemaining, currentValue: newValue)
    }
    
    private func performRandomOperationOnOperand(operand: Double, and otherOperand: Double) -> Double
    {
        let randomNumber = arc4random_uniform(4)
        
        var product: Double = 0
        var operatorType = ""
        
        switch randomNumber
        {
        case 0:
            product = operand + otherOperand
            operatorType = "+"
        case 1:
            product = operand - otherOperand
            operatorType = "-"
        case 2:
            product = operand * otherOperand
            operatorType = "*"
        case 3:
            product = operand / otherOperand
            operatorType = "/"
        default:
            product = 0
        }
        
        print("\(operand) \(operatorType) \(otherOperand)")
        
        return product
    }
}

public struct RoughSolver: CountdownPuzzleSolvingType
{
    public func attemptToReachTarget(target: Double, usingNumbers: [Double]) -> Double {
        var numbersAvailable = usingNumbers
        
        // Try and get to same hundreds digit using max element and then stop i.e. if target is 250, get to 200
        guard let maxElement = numbersAvailable.maxElement(),
            maxElementIndex = numbersAvailable.indexOf(maxElement) else { return 0 }
        
        numbersAvailable.removeAtIndex(maxElementIndex)
        
        var total: Double = maxElement
        
        for number in numbersAvailable
        {
            if sameHundredsDigitAsTarget(target, currentTotal: maxElement * total)
            {
                return maxElement * total
            }
            
            print(total)
            
            total += number
        }
        
        return maxElement * total
    }
    
    func sameHundredsDigitAsTarget(target: Double, currentTotal: Double) -> Bool {
        return Int(target / 100) <= Int(currentTotal / 100)
    }
}