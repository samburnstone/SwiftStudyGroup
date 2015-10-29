import Foundation

public struct Pairing
{
    let giver: Person // NO SNIGGERING
    let receiver: Person
}

extension Pairing: CustomStringConvertible
{
    public var description: String
    {
        return "\(giver) -> \(receiver)"
    }
}
