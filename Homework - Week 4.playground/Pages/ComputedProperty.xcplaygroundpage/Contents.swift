//: Something simple to start us off
//: A basic Range struct with a computed property
struct SimpleRange {
    let start: UInt
    let end: UInt
    
    // Computed property.
    // Note we don't have to explicitly use: get { return endIndex - startIndex } as Swift infers it's a readonly property
    var length: UInt {
        return end - start
    }
}

let smallRange = SimpleRange(start: 0, end: 10)
smallRange.length

let largeRange = SimpleRange(start: 10, end: 15)
largeRange.length

//: [Next](@next)
