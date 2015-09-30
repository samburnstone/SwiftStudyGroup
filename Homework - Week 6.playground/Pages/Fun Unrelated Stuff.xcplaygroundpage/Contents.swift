//: [Previous](@previous)

import UIKit

//: Mirror Type
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

//: Crazy Extensions

extension Int {
    func repetitions(reptitiveTask: Void -> Void) {
        for _ in 0..<self {
            reptitiveTask()
        }
    }
}

3.repetitions {
    print("OINK!")
}

//: [Next](@next)
