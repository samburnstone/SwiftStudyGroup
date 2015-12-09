import Foundation

public protocol CountdownContestantType
{
    func solveCountdownPuzzleByReachingTarget(target: Double, usingNumbers: [Double]) -> Double
}

public class Person
{
    public init() {}
    
    public func pickAssortmentOfNumbers(largeOnes: [Double], smallOnes: [Double]) -> [Double]
    {
        var thisRoundsLargeOnes = largeOnes
        var thisRoundsSmallOnes = smallOnes
        return [
            thisRoundsLargeOnes.popRandomElement(),
            thisRoundsSmallOnes.popRandomElement(),
            thisRoundsSmallOnes.popRandomElement(),
            thisRoundsSmallOnes.popRandomElement(),
            thisRoundsSmallOnes.popRandomElement(),
            thisRoundsSmallOnes.popRandomElement()
        ]
    }
}

public class StupidPerson: Person, CountdownContestantType
{
    public func solveCountdownPuzzleByReachingTarget(target: Double, usingNumbers: [Double]) -> Double {
        return StupidSolver().attemptToReachTarget(target, usingNumbers: usingNumbers)
    }
}

public class MentalBlankPerson: Person, CountdownContestantType
{
    public func solveCountdownPuzzleByReachingTarget(target: Double, usingNumbers: [Double]) -> Double {
        return RoughSolver().attemptToReachTarget(target, usingNumbers: usingNumbers)
    }
}