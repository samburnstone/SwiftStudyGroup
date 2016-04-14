//: [Previous](@previous)

// This NSHipster article provides a nice summary of the different Collection types in Swift: http://nshipster.com/swift-collection-protocols/

let names = ["Sam", "Andy", "Rob", "Dan"]

// map
let initials = names.flatMap // Using flatMap unwraps the result of `characters.first` (as its return type is optional)
{
    $0.characters.first
}

initials

// filter
let threeLetterNames = names.filter
{
    $0.characters.count == 3
}

threeLetterNames

// reduce

let groupName = names.reduce("Team: ")
{
    "\($0) \($1)"
}

groupName

//: [Next](@next