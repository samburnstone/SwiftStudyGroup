//: [Previous](@previous)

import Foundation

//:## Initialization

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

//: [Next](@next)
