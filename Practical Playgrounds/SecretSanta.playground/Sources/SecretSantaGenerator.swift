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
        case InsufficientNumberOfParticipantsFromSeparateFamilies
    }
    
    public func generatePairingsFromParticipants(participants: [Person]) throws -> [Pairing]
    {
        if participants.count < 2
        {
            throw Error.TooFewParticipants
        }
        
        if !FamilyNameValidator().validateSufficientParticipantsFromDifferentFamilies(participants)
        {
            throw Error.InsufficientNumberOfParticipantsFromSeparateFamilies
        }
        
        return validPairingsFromParticipants(participants)
    }
    
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

private struct FamilyNameValidator
{
    
    /// Returns true if the number of people from the largest single family is **<=** half the total number of participants
    func validateSufficientParticipantsFromDifferentFamilies(participants: [Person]) -> Bool
    {
        let families = sortParticipantsIntoFamilyNames(participants)
        
        let familiesSortedInDescendingNumberOfFamilyMembers = families.sort { $0.members.count > $1.members.count }
        
        guard let largestFamily = familiesSortedInDescendingNumberOfFamilyMembers.first else { return false }
        
        return largestFamily.members.count <= (participants.count / 2)
    }
    
    func sortParticipantsIntoFamilyNames(participants: [Person]) -> [Family]
    {
        var familyStore = FamilyStore()
        
        for participant in participants
        {
            familyStore.sortParticipantIntoFamily(participant)
        }
        
        return familyStore.families
    }
    
}

private struct Family
{
    let name: String
    var members = [Person]()
    
    init(name: String)
    {
        self.name = name
    }
}

extension Family: Equatable {}

private func ==(lhs: Family, rhs: Family) -> Bool
{
    return lhs.name == rhs.name
}

private struct FamilyStore
{
    var families = [Family]()
    
    mutating func sortParticipantIntoFamily(participant: Person)
    {
        var participantsFamily = families.filter
            { $0 == Family(name: participant.lastName) }
            .first
        
        if participantsFamily == nil
        {
            participantsFamily = Family(name: participant.lastName)
            families.append(participantsFamily!) // Look back at this
        }
        
        participantsFamily?.members.append(participant)
        updateFamily(participantsFamily!)
    }
    
    // This is required due to us defining `Family` as a struct. Any changes we make to the Family will be written to a copy of the original family, therefore we need to replace the previous family with the newly amend instance
    // This is an interesting read on the issue of using Structs everywhere: http://faq.sealedabstract.com/structs_or_classes/
    // Note for future: We'd perhaps have beeen better off defining `Family` as a class, yet maintaining Person as a struct.
    mutating func updateFamily(family: Family)
    {
        guard let index = families.indexOf(family) else { return }
        families.removeAtIndex(index)
        families.append(family)
    }
}
