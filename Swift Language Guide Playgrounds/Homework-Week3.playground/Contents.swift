//: Tennis

import Foundation

class Player {
    
    // Enum time
    enum PlayingStyle {
        case LeftHanded
        case RightHanded
        case AmbiDextrous
    }
    
    // Boring boring stored properties
    let name: String
    let dateOfBirth: NSDate
    let playingStyle: PlayingStyle
    
    // Let's try a computed property
    var age: Int {
        get {
            let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            return calendar.components(.Year, fromDate: dateOfBirth, toDate: NSDate(), options: .MatchFirst).year
        }
    }
    
    init(name: String, dateOfBirth: NSDate, playingStyle: PlayingStyle = .RightHanded) {
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.playingStyle = playingStyle
    }
    
    // Convenience initialiser that may return nil if date cannot be extracted from string
    convenience init?(name: String, dateOfBirth: String, playingStyle: PlayingStyle = .RightHanded) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        if let birthDate = dateFormatter.dateFromString(dateOfBirth) {
            self.init(name: name, dateOfBirth: birthDate, playingStyle: playingStyle)
        }
        else {
            return nil
        }
    }
}

//: It's recommended to use extensions to separate protocol implementations - below we have *Hashable* and *CustomStringConvertible*
extension Player: Hashable {
    // Implement Hashable protocol so we can use Player in Dictionary
    var hashValue: Int {
        get {
            return self.name.hashValue
        }
    }
}

extension Player: CustomStringConvertible {
    var description: String {
        get {
            return name
        }
    }
}

//: We need to implement the **Equatable** protocol so we can use Player as a key in a Dictionary later on
func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.name == rhs.name
}

//: Let's create a few Tennis Players
let grumpyScot = Player(name: "Andy Murray", dateOfBirth: "1987-05-15")
grumpyScot?.age
let swissWithAHeadband = Player(name: "Roger Federer", dateOfBirth: "1981-08-08")!
swissWithAHeadband.age

let mysteryPlayer = Player(name: "Un Known", dateOfBirth: "") == nil

let superSerb = Player(name: "Novak Djokovic", dateOfBirth: "1987-05-22")!

let bigRafa = Player(name: "Rafael Nadal", dateOfBirth: "1986-06-03", playingStyle: .LeftHanded)
bigRafa?.age

//: Tennis Match


class Game {
    
    enum Point: Equatable {
        case Numeric(value: Int)
        case Advantage
    }
    
    enum GameState {
        case InProgress
        case Won(winningPlayer: Player)
        case Error
    }
    
    typealias PlayerScores = [Player: Point]
    
    // Create an empty score dictionary
    var playerScores = PlayerScores()
    
    var state: GameState
    
    init(players: [Player]) {
        state = .InProgress
        players.map({
            playerScores[$0] = .Numeric(value: 0)
        })
    }
    
    func awardPointTo(player: Player) -> GameState {
        // Check a score exists for the given player
        guard var currentPlayerScore = playerScores[player] else { return .Error }
        
        // Stupid tennis scoring system
        switch currentPlayerScore {
            
        case .Numeric(value: let value) where value <= 15:
            currentPlayerScore = .Numeric(value: value + 15)
            
        case .Numeric(value: 30):
            currentPlayerScore = .Numeric(value: 40)
            
        case .Numeric(value: 40):
            
            guard let opponent = retrieveOpponent(to: player) else { return .Error } // In a real life application, these would probably be thrown as errors
            guard let opponentScore = playerScores[opponent] else { return .Error }
            
            // Slightly tricky bit - we need to work out if the player's opponent is currently on 'advantage'
            switch opponentScore {
            case .Numeric(value: 40): currentPlayerScore = .Advantage
            case .Advantage: playerScores[opponent] = .Numeric(value: 40) // Opponent was on advantage, therefore reduce
            default: state = .Won(winningPlayer: player); return state
            }
            
        case .Advantage: state = .Won(winningPlayer: player); return state
            
        default: break
        }
        
        playerScores[player] = currentPlayerScore
        
        return .InProgress
    }
    
    // Search through playerScores' keys to retrieve other player
    func retrieveOpponent(to player: Player) -> Player? {
        return playerScores.keys.array.filter({ $0 != player }).first
    }
}

//: Swift doesn't automatically generate the enum equalities for us, so we'll cover those here
func ==(lhs: Game.Point, rhs: Game.Point) -> Bool {
    switch (lhs, rhs) {
    case (.Numeric(let a),   .Numeric(let b))   where a == b: return true
    case (.Advantage, .Advantage): return true
    default: return false
    }
}

class Match {
    
    let players: [Player]
    var games = [Game]()
    
    init(players: [Player]) {
        self.players = players

        games.append(Game(players: players))
    }
    
    func awardPointTo(player: Player) {
        guard let game = currentGame() else { return }
        let gameState = game.awardPointTo(player)
        
        switch gameState {
        case .Won(let winningPlayer):
            print("\(winningPlayer.name) won the game!")
            let newGame = Game(players: players)
            games.append(newGame)
        default: break
        }
    }
    
    /// Returns the current game in progress
    func currentGame() -> Game? {
        return games.last
    }
}

extension Match: CustomStringConvertible {
    var description: String {
        get {
            // TODO: This counts all games won - count games won by each player and return nicely formatted string
            var outputString = ""
            
            
            for player in players {
                let gameCount = games.reduce(0) {
                    (numGames, game) in
                    switch game.state {
                    case .Won(player): return numGames + 1
                    default: return numGames
                    }
                }
                
                outputString += "\(player) \(gameCount)\n"
            }
            
            
            return outputString
        }
    }
}

let wimbledonFinal = Match(players: [superSerb, swissWithAHeadband])

//: First Game
wimbledonFinal.awardPointTo(superSerb)
wimbledonFinal.awardPointTo(superSerb)
wimbledonFinal.awardPointTo(superSerb) // What a beast!

wimbledonFinal.awardPointTo(swissWithAHeadband)
wimbledonFinal.awardPointTo(swissWithAHeadband)
wimbledonFinal.awardPointTo(swissWithAHeadband) // Nice comeback Roger!

wimbledonFinal.awardPointTo(superSerb)
wimbledonFinal.currentGame()?.playerScores
wimbledonFinal.awardPointTo(swissWithAHeadband) // On a knife-edge!
wimbledonFinal.currentGame()?.playerScores
wimbledonFinal.awardPointTo(superSerb)
wimbledonFinal.awardPointTo(superSerb)
wimbledonFinal.currentGame()?.playerScores // Game has been reset

// What's the current score, Sue Barker?
print(wimbledonFinal)

//: Let's have another game
wimbledonFinal.awardPointTo(swissWithAHeadband)
wimbledonFinal.awardPointTo(swissWithAHeadband)
wimbledonFinal.awardPointTo(swissWithAHeadband)
wimbledonFinal.awardPointTo(swissWithAHeadband)

print(wimbledonFinal)
