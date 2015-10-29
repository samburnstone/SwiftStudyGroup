//
//  SecretSantaGenerator.swift
//  
//
//  Created by Samuel Burnstone on 28/10/2015.
//
//
public struct SecretSantaGenerator
{
    public init() {}
    
    public enum Error: ErrorType
    {
        case TooFewParticipants
        case AllParticipantsHaveSameName
    }
    
    public func generatePairingsFromParticipants(participants: [Person]) throws -> [Pairing]
    {
        if participants.count < 2
        {
            throw Error.TooFewParticipants
        }
        
        return validPairingsFromParticipants(participants)
    }
    
    // TODO: Check if all people in the array have the same name
    
    // Shuffle array (assume no people can have same last name for now)
    
    /// Generates an array of `Person` where `i` is given present by `i-1` (unless `i = 0`, where `i` receives present from `participants.endIndex`)
    func validPairingsFromParticipants(participants: [Person]) -> [Pairing]
    {
        var pairings: [Pairing]
        
        /// Prevent people from same family receiving items
        func pairingsAreValid(pairings: [Pairing]) -> Bool
        {
            for pairing in pairings
            {
                if pairing.giver.lastName == pairing.receiver.lastName
                {
                    return false
                }
            }
            return true
        }
        
        repeat {
            pairings = buildPairingsListFromCircularArray(participants.shuffle())
        }
        while (!pairingsAreValid(pairings))
        
        return pairings
    }
    
    func buildPairingsListFromCircularArray(circularArray: [Person]) -> [Pairing]
    {
        var pairings = [Pairing]()
        for i in 0..<(circularArray.count - 1)
        {
            let giver = circularArray[i]
            let receiver = circularArray[i+1]
            pairings.append(Pairing(giver: giver, receiver: receiver))
        }
        pairings.append(Pairing(giver: circularArray[circularArray.endIndex.predecessor()], receiver: circularArray[0]))
        
        return pairings
    }
}
