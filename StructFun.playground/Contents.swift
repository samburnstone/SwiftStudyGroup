import UIKit

//: Let's start simplly

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

//: How about something a tiny bit more complicated - a 2*2 matrix?
struct Matrix: CustomStringConvertible {
    
    var grid:[Double] = Array(count: 2 * 2, repeatedValue: 0)
    
    var description: String {
        get {
            return "\(self[0, 0]) \(self[0, 1])\n\(self[1, 0]) \(self[1, 1])"
        }
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            return grid[indexOfItemAtRow(row, column: column)]
        }
        set {
            grid[indexOfItemAtRow(row, column: column)] = newValue
        }
    }
    
    private func indexOfItemAtRow(row: Int, column: Int) -> Int {
        return row * 2 + column
    }
}

var matrix = Matrix()

print(matrix)

matrix[0, 0] = 10
matrix[0, 1] = 5
matrix[1, 0] = 20
matrix[1, 1] = 30

print(matrix)
