//: [Previous](@previous)

//:## ARC Memory Management

class Person {
    var cards = [CreditCard]() // Strongly hold reference to any credit card instances
    
    func addCard(card: CreditCard) {
        cards.append(card)
    }
    
    deinit {
        print("Deinit Person")
    }
}

class CreditCard {
    weak var owner: Person? // Need to mark this as 'weak' so we don't get a strong reference cycle
    
    init(owner: Person) {
        self.owner = owner
    }
    
    deinit {
        print("Deint CreditCard")
    }
}

func temp() {
    let sam = Person()
    let visaCard = CreditCard(owner: sam)
    sam.addCard(visaCard)
}

temp()

//: [Next](@next)
