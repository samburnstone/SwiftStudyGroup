public protocol WordSanitiser
{
    /// Modifies `message` based on banned words contained within `bannedWords` array
    func santiseMessage(message: String, bannedWords: [FlaggedWordToken]) -> String
}