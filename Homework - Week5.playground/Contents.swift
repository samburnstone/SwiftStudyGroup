//:## Homework - Week 4
//:____________
//: Inheritance

//: A base class in Swift inherits no cruft from any base object (unlike Objective-C with its NSObject class)
class Base {
    
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