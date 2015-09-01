//: [Previous](@previous)

//:## Property Observers
//:_________
//: We can use didSet and willSet to 'observe' a property.
//:_________
//: **Note:** If overriding the setter (which requires us to also override the getter) we cannot use didSet and willSet (you just use set instead).

struct Doubler {
    
    var number: Int? {
        
        // By default, previous value is passed in as 'oldValue'
        // Note, that if we set number within didSet this wouldn't cause the observer to be called again
        didSet {
            if oldValue != number {
                recalculate()
            }
            else {
                print("You've just calculated the double of \(number) - stop wasting energy!")
            }
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
doubler.number = 5
