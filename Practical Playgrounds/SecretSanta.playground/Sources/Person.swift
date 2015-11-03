import Foundation

// NOTE: Need to add 'public' access attribute in order for items in this class to be accessible from Playground
public struct Person
{
    let firstName: String
    let lastName: String
    let email: String
    
    // We also need to override the auto-synthesized init as that's not publicly accessible either
    public init(firstName: String, lastName: String, email: String)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}

extension Person: CustomStringConvertible
{
    public var description: String
    {
        return "\(firstName) \(lastName)"
    }
}