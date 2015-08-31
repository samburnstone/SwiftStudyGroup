import UIKit

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
    
    init (start: UInt, end: UInt) {
        guard end >= start else { fatalError("End must be greater than or equal to start") }
        self.start = start
        self.end = end
    }
}

let smallRange = SimpleRange(start: 0, end: 10)
smallRange.length

let largeRange = SimpleRange(start: 10, end: 15)
largeRange.length

// ERROR: let incorrectRange = SimpleRange(start: 10, end: 3)

//: Let's be a little fancier. We'll create a protocol with a readonly computed property.
protocol ThreeDShape {
    // Read-only volume property
    var volume: Double { get }
}

//: Create a struct that conforms to this protocol
struct Cube: ThreeDShape {
    var sideLength: Double = 10
    
    var volume: Double {
        return pow(sideLength, 3)
    }
}

var cube = Cube()
cube.sideLength = 6
cube.volume

//: OOOOOHHHHHHHHH!!!!!!!
let π = M_PI

struct Sphere: ThreeDShape {
    var radius = 0.0
    
    var volume: Double {
        return 4/3 * π * pow(radius, 3)
    }
}

var sphere = Sphere(radius: 5)
sphere.volume

//: [Next](@next)
