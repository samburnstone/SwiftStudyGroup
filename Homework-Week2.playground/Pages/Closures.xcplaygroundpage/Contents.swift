//: [Previous](@previous)

import Foundation

//: ## Closures
//: See [Naughty titled site](http://fuckingclosuresyntax.com/) for more detail

//: Example taken from Swift reference guide

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [16, 58, 510]

let strings = numbers.map {
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}

//: Bank Account Example
class Account {
    
    typealias AccountHolderReaction = () -> ()
    
    var balance: Double = 0
    
    func deposit(amount: Double) {
        balance += amount
    }
    
    func withdraw(amount: Double, success: AccountHolderReaction, failure: AccountHolderReaction) {
        // Check the peasant has some funds in their account
        guard balance - amount > 0 else { failure(); return }
        
        // Rich peasant, therefore allow them to withdraw
        balance -= amount
        success()
    }
}

func printSuccessful() {
    print("I have MOONNNEEYYY. Get the Prosecco out!")
}

func printFailure() {
    print("Doh... better sell the donkey")
}

let samAccount = Account()
samAccount.withdraw(50, success: printSuccessful, failure: printFailure)
samAccount.deposit(100)
samAccount.withdraw(80, success: printSuccessful, failure: printFailure)

var result: String = ""

samAccount.withdraw(50, success: {
    result = "Got money!"
}, failure: {
    result = "No money!"
})
result

samAccount.withdraw(10, success: {
    result = "Got money!"
}) {
    print("No money")
}
result



//: [Next](@next)
