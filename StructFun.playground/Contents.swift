//: How about something a tiny bit more complicated - a 2*2 matrix?
struct Matrix: CustomStringConvertible {
    
    static private let columnCount = 2
    static private let rowCount = 2
    
    var grid:[Double] = Array(count: rowCount * columnCount, repeatedValue: 0)
    
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

//: Now let's override some operators
func *(scalar: Int, var matrix: Matrix) -> Matrix {
    for var i = 0; i < matrix.grid.count; i++ {
        matrix.grid[i] = matrix.grid[i] * Double(scalar)
    }
    
    return matrix
}

//: Test it!
var matrix = Matrix()

matrix[0, 0] = 10
matrix[0, 1] = 5
matrix[1, 0] = 20
matrix[1, 1] = 30

print(matrix)
// Multiple that Matrix
let multipledMatrix = 5 * matrix
print(matrix) // Untouched
print(multipledMatrix)
