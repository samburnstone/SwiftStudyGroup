//: # Homework - Week 7
//: __________
//:## Extensions
//: Let's add a method to `String` that appends a happy face
extension String
{
    // As we're altering 'self' we mark this method as mutating
    mutating func appendMrHappy()
    {
        self += "😀" // Or could do ' self = "\(self)😀" '
    }
}

var happyString = "I'm feeling happy happy happy"
happyString.appendMrHappy()

//: That was just spiffing! Let's try something a bit stranger...
//: _________
//: Add dynamic proprties to convert a double into other units
extension Double
{
    var km: Double
    {
        return self / 1000
    }
    
    var cm: Double
    {
        return self * 100
    }

    var miles: Double
    {
        return self.km * 0.621
    }
}

// Now let's try it out
let metresRan: Double = 5000
metresRan.km
metresRan.miles
metresRan.cm

//: How about passing in closures?

extension Int
{
    func times(block: Void -> Void)
    {
        for _ in 0..<self
        {
           block()
        }
    }
}

3.times {
    print("Is there an echo?")
}
