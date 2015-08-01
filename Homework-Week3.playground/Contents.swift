//: Tennis

import Foundation

class Player: Hashable {
    
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
    
    // Implement Hashable protocol so we can use Player in Dictionary
    var hashValue: Int {
        get {
            return self.name.hashValue
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

//: We need to implement the **Equatable** protocol so we can use Player as a key in a Dictionary later on
func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.name == rhs.name
}

let grumpyScot = Player(name: "Andy Murray", dateOfBirth: "1987-05-15")
grumpyScot?.age
let swissWithAHeadband = Player(name: "Roger Federer", dateOfBirth: "1981-08-08")
swissWithAHeadband?.age

let mysteryPlayer = Player(name: "Un Known", dateOfBirth: "") == nil

let superSerb = Player(name: "Novak Djokovic", dateOfBirth: "1987-05-22")

let bigRafa = Player(name: "Rafael Nadal", dateOfBirth: "1986-06-03", playingStyle: .LeftHanded)
bigRafa?.age

//: Tennis Match

class Match {
    let players: [Player]
    var score = [Player: Int]()
    
    init(players: [Player]) {
        self.players = players
        
        // Set each player's score to 0
        self.players.map({
            score[$0] = 0
        })
    }
    
    func awardPointTo(player: Player) {
        // Check a score exists for the given player
        guard let currentScore = score[player] else { return }
        
        // Right, let's modify the current score
        var updatedScore = currentScore
        
        // Stupid tennis scoring system
        switch currentScore {
        case 0, 15: updatedScore += 15
        case 30: updatedScore += 10
        // TODO: case 40:
        default: break
        }
        
        score[player] = updatedScore
    }
    
}

let wimbledonFinal = Match(players: [superSerb!, swissWithAHeadband!])
wimbledonFinal.score

wimbledonFinal.awardPointTo(superSerb!)
wimbledonFinal.awardPointTo(swissWithAHeadband!)
wimbledonFinal.score

