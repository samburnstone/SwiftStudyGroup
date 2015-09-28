import UIKit

struct Point {
    var x: CGFloat
    var y: CGFloat
}

let p = Point(x: 10, y: 10)

let mirror = Mirror(reflecting: p)
for child in mirror.children {
    let (key, value) = child
    print(key)
    print(value)
}

//: Basic Optional Chaining
struct Square {
    var point: Point?
}

var square = Square()
let x = square.point?.x // Type of x is `CGFloat?`

//: Error Handling
square.point = Point(x: 0, y: 0)
square.point?.x = 20 // point could be nil, hence the '?'

extension Point {
    func printClass() {
        print("(\(x), \(y))")
    }
}

let returnType = square.point?.printClass() // Notice that return type is '()?' or 'Void?'

//: [Next](@next)
