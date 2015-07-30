//: Tennis

import Foundation

class Player {
    //: Boring boring stored properties
    let name: String
    let dateOfBirth: NSDate
    
    //: Let's try a computed property
    var age: Int {
        get {
            let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            return calendar.components(.Year, fromDate: dateOfBirth, toDate: NSDate(), options: .MatchFirst).year
            
            //: Primitive way of getting rough age
//            let currentYear = calendar.components(.Year, fromDate: NSDate()).year
//            let playerYear = calendar.components(.Year, fromDate: dateOfBirth).year
//            
//            return currentYear - playerYear
        }
    }
    
    init(name: String, dateOfBirth: NSDate) {
        self.name = name
        self.dateOfBirth = dateOfBirth
    }
    
    //: Convenience initialiser that may return nil if date cannot be extracted from string
    convenience init?(name: String, dateOfBirth: String) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        if let birthDate = dateFormatter.dateFromString(dateOfBirth) {
            self.init(name: name, dateOfBirth: birthDate)
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