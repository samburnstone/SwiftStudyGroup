import Foundation

public struct Pairing
{
    let giver: Person
    let receiver: Person
}

extension Pairing: CustomStringConvertible
{
    public var description: String
    {
        return "\(giver) -> \(receiver)" // NO SNIGGERING
    }
}
