//: [Previous](@previous)

//:## ARC Memory Management

//:### Weak References
//:___________
//: From the docs: Use a weak reference whenever it is valid for that reference to become nil at some point during its lifetime. Because weak references are allowed to have no 'no value', every weak variable must be defined as having an optional type.

class Person {
    var pets = [Pet]() // Strongly hold reference to any credit card instances
    
    func addPet(pet: Pet) {
        pets.append(pet)
    }
    
    deinit {
        print("Deinit Person")
    }
}

class Pet {
    weak var owner: Person? // Need to mark this as 'weak' so we don't get a strong reference cycle - let's say it's possible for a Pet to not have an owner (i.e. when it's been lost)
    
    init(owner: Person) {
        self.owner = owner
    }
    
    deinit {
        print("Deinit Pet")
    }
}

func temp() {
    let sam = Person()
    let dog = Pet(owner: sam)
    sam.addPet(dog)
}

temp()

//:### Unowned References
//: _______________
//: An unowned reference does not keep a strong hold on the instance it refers to. However, unlike a weak reference, unowned references are assumed to always have a value and are therefore **not** optional.

class Pat {
    var beverages = [Tea]()
    
    func addBeverage(beverage: Tea) {
        beverages.append(beverage)
    }
    
    deinit {
        print("Deinit Pat")
    }
}

class Tea {
    unowned var drinker: Pat // Mark as unowned to avoid strong reference cycle - a tea can not have a 'nil' drinker... It must be drunk!
    
    init(drinker: Pat) {
        self.drinker = drinker
    }
    
    deinit {
        print("Deinit Tea")
    }
}

func temp2() {
    let pat = Pat()
    let tea = Tea(drinker: pat)
    pat.addBeverage(tea)
}

temp2()

//:### Funky third scenario
//: ____________
//: We have two instances that reference each other that cannot be nil

class Country {
    let name: String
    var capitalCity: CapitalCity! // This must be an implicitly unwrapped property as we can't reference self and still satisfy Swift's initialization rules (capitalCity will be nil when instantiating CapitalCity)
    
    init(name: String, capitalName: String) {
        self.name = name
        capitalCity = CapitalCity(name: capitalName, country: self)
    }
    
    deinit {
        print("Deinit country")
    }
}

class CapitalCity {
    let name: String
    unowned var country: Country
    
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
    
    deinit {
        print("Deinit capital city")
    }
}

func temp3() {
    let algeria = Country(name: "Algeria", capitalName: "Algiers")
    algeria.name
    algeria.capitalCity.name
}

temp3()

//: Reference Cycles within Closures

class Trumpet {
    var noise = "TRRRRMMPPPPHHHH"
    
    lazy var repeatNoise: Int -> String = { //Note: Needs to marked as lazy as we refer to 'self' -> this could not be done if not marked as lazy due to Swift's strict init strategy
        
        
        [unowned self] // Mark self as being unowned (self cannot become nil during the execution of the closure) so we don't get a strong reference cycle
        
        (count: Int) -> String in // The closure's parameter list and return type
        
        var output = ""
        
        for _ in 0..<count  {
            output += "\(self.noise)! "
        }
        
        return output
    }
    
    deinit {
        print("Deinit trumpet")
    }
}

func temp4() {
    let trumpet = Trumpet()
    trumpet.repeatNoise(5)
}

temp4()

//: [Next](@next)
