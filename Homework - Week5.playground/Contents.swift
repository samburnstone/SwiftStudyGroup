//:## Homework - Week 4
//:____________
//: Inheritance

//: A base class in Swift inherits no cruft from any base object (unlike Objective-C with its NSObject class)
class Base {
    
    // To be able to instantiate from Base.Type we have to add an initializer
    required init() {}
    
    var description: String {
        return "A very basic class"
    }
}

extension Base: Equatable {}

func ==(lhs: Base, rhs: Base) -> Bool {
    return lhs.description == rhs.description
}

//: We get very little 'for free', bar a few simple ways for a class to introspect itself
let base = Base()

base.self // Equivalent of [Base class] in Obj-C

let baseType = base.dynamicType

let newInstance = baseType.init()
newInstance.description

//: Simple tests

newInstance == base // 'Equal'
newInstance === base // But not the same instance

//: Subclassing experiments

class Animal {
    func makeNoise() {
        print("A \(self) goes: ")
    }
}

class Dog: Animal {
    
    // Notice the override keyword
    override func makeNoise() {
        super.makeNoise() // Call up to superclass' method
        print("Baaaa")
    }
}

// \(self) defaults to printing the class name unless the class conforms to CustomStringConvertible
extension Dog: CustomStringConvertible {
    var description: String {
        return "mangy little spaniel"
    }
}

let dog = Dog()
dog.makeNoise()

class Car {
    var speed: Double = 0
}

class Pootler: Car {
    
    // Overridden properties also need to be marked
    override var speed: Double {
        willSet {
            if newValue > 30 {
                fatalError("Your car has blown up!")
            }
        }
    }
}

let mangyCar = Pootler()
mangyCar.speed = 10
// Fatal error mangyCar.speed = 100


//:## Initialization

//: (Copied from Apple's docs)
//:

struct Shape {
    let numberOfSides: UInt
}

let shape = Shape(numberOfSides: 3) // Auto generates an initializer for our struct

class Person {
    
    enum EmploymentStatus {
        case Employed
        case Unemployed
    }
    
    let name: String
    var status: EmploymentStatus = .Unemployed
    
    // As we have a non-optional, non-initialized property, we need to assign a value to it within an initializer
    init(name: String) {
        self.name = name
    }
    
    // We can require an initializer to be implemented in every subclass (in some form!)
    required init() {
        name = "A. N. Other"
    }
    
}

class EmployedPerson: Person {
    
    // Swift doesn't allow us to redefine the job property
    // ERROR: error: cannot override mutable property 'job' of type 'String?' with covariant type 'String' 
    // override var job: String = ""
    
    var salary: Double
    
    init(name: String, jobStatus: EmploymentStatus) {
        salary = 0
        // ERROR: Can't assign to any properties before super has been initialized: status = jobStatus
        super.init(name: name)
        status = jobStatus // Now the super class has been initialized, we can safely assign
    }
    
    convenience override init(name: String) {
        self.init(name: name, jobStatus: .Employed)
    }

    // We're forced to inherit this init method, though we use Xcode's default completion
    required init() {
        fatalError("init() has not been implemented")
    }
    
}

class DoublyEmployedPerson: EmployedPerson {
    // Note we don't have to implement the initializer
}

class ThriceEmployedPerson: EmployedPerson {
    // If we override one of the designated initializers
    override init(name: String, jobStatus: EmploymentStatus) {
        super.init(name: name, jobStatus: jobStatus)
    }
    
    // We also have to override any 'required' initializers
    required init() {
        fatalError("init() has not been implemented")
    }

}

let employedPerson = EmployedPerson(name: "Sam")
employedPerson.status

//:## Deinitialization

class Government {
    static var totalCoins: UInt = 1000
    
    static func absorbWealth(coinCount: UInt) {
        totalCoins += coinCount
    }
}

class Citizen {
    
    let coinCount: UInt
    
    init(coinAllocation: UInt) {
        coinCount = coinAllocation
    }
    
    deinit {
        Government.absorbWealth(coinCount)
    }
}

Government.totalCoins

// Pop items we want to demonstrate being 'released' in a function (otherwise the playground will keep the objects in memory)
func temp() {
    Citizen(coinAllocation: 100)
    Citizen(coinAllocation: 10)
    Citizen(coinAllocation: 1000)
}

temp()

Government.totalCoins

// Or we can assign citizens to variables and then assign nil afterwards (note they must be optional for us to do this)
var citizen1: Citizen? = Citizen(coinAllocation: 10)
var citizen2: Citizen? = Citizen(coinAllocation: 150)

citizen1 = nil
citizen2 = nil

Government.totalCoins
