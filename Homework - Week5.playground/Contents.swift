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
mangyCar.speed = 100
