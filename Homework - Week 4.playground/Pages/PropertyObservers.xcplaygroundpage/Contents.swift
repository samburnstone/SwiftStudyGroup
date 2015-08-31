//:## Property Observers
//:_________
//: We can use didSet and willSet to 'observe' a property.
//:_________
//: **Note:** If overriding the setter (which requires us to also override the getter) we cannot use didSet and willSet (you just use set instead).

struct Doubler {
    
    var number: Int? {
        // Observers
        didSet {
            recalculate()
        }
        
        // By default, value that will be set is passed as constant 'newValue', we can change the name of this however if we wish
        willSet(newNumericValue) {
            print("Value of number will change from \(self.number) to \(newNumericValue)")
        }
    }
    
    func recalculate() {
        guard let number = number else { return }
        
        let doubledValue = number * number
        
        print("Double value of \(number) is \(doubledValue)")
    }
    
}

//: Put it into action
var doubler = Doubler()
doubler.number = 10
doubler.number = 5
