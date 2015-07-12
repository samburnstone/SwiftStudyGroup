//: [Previous](@previous)

import UIKit

//: Let's start simply

let point1 = CGPoint(x: 5, y: 5)
let point2 = CGPoint(x: 10, y: 10)

func +(p1: CGPoint, p2: CGPoint) -> CGPoint {
    return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
}

func -(p1: CGPoint, p2: CGPoint) -> CGPoint {
    return CGPoint(x: p1.x - p2.x, y: p1.y - p2.y)
}

func *(p1: CGPoint, p2: CGPoint) -> CGPoint {
    return CGPoint(x: p1.x * p2.x, y: p1.y * p2.y)
}

func /(p1: CGPoint, p2: CGPoint) -> CGPoint {
    return CGPoint(x: p1.x / p2.x, y: p1.y / p2.y)
}

let combinedPointAdding = point1 + point2
let combinedPointSubtracting = point1 - point2
let combinedPointMultiplying = point1 * point2
let combinedPointDividing = point2 / point1

//: [Next](@next)
