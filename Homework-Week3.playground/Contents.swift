//: Tennis

import Foundation

class Player {
    
    //: Enum time...
    enum PlayingStyle {
        case LeftHanded
        case RightHanded
        case AmbiDextrous
    }
    
    //: Boring boring stored properties
    let name: String
    let dateOfBirth: NSDate
    let playingStyle: PlayingStyle
    
    //: Let's try a computed property
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
    
    //: Convenience initialiser that may return nil if date cannot be extracted from string
    convenience init?(name: String, dateOfBirth: String, playingStyle: PlayingStyle = .RightHanded) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        if let birthDate = dateFormatter.dateFromString(dateOfBirth) {
            self.init(name: name, dateOfBirth: birthDate, playingStyle: playingStyle)
        }
        else {
            print("Problem extracting date from dateOfBirth string")
            return nil
        }
    }
}

let grumpyScot = Player(name: "Andy Murray", dateOfBirth: "1987-05-15")
grumpyScot?.age
let swissWithAHeadband = Player(name: "Roger Federer", dateOfBirth: "1981-08-08")
swissWithAHeadband?.age

let mysteryPlayer = Player(name: "Un Known", dateOfBirth: "") == nil

let bigRafa = Player(name: "Rafael Nadal", dateOfBirth: "1986-06-03", playingStyle: .LeftHanded)
bigRafa?.age

