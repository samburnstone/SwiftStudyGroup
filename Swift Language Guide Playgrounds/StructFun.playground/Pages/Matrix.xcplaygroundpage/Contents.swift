//: How about something a tiny bit more complicated - a 2*2 matrix?
struct Matrix: CustomStringConvertible {
    
    struct Dimensions {
        let rows: Int
        let columns: Int
    }
    
    let dimensions: Dimensions
    
    private var grid = [Double]()
    
    init?(topRow: [Double], bottomRow: [Double]) {
        
        dimensions = Dimensions(rows: 2, columns: 2)
        
        guard topRow.count == dimensions.columns && bottomRow.count == dimensions.columns else { return nil }
        grid = topRow + bottomRow;
    }
    
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
        return row * dimensions.columns + column
    }
    
}

//: Now let's override some operators
func *(scalar: Int, matrix: Matrix) -> Matrix {
    
    // We want to be able to pass in a constant matrix, so we need to copy the contents
    // into a mutable variable
    var copy = matrix
    
    copy.grid.enumerate()
    
    for (index, _) in copy.grid.enumerate() {
        copy.grid[index] = copy.grid[index] * Double(scalar)
    }
    
    return copy
}

func *(matrix: Matrix, scalar: Int) -> Matrix {
    // We've defined Int * Matrix, so we can just use that method, rather than duplicating it
    return scalar * matrix
}

//: Test it!
if let matrix = Matrix(topRow: [0], bottomRow: [10, 5]) {
    print("Not nil")
}
else {
    print("Returns nil")
}

if let matrix = Matrix(topRow: [0, 10], bottomRow: [10]) {
    print("Not nil")
}
else {
    print("Returns nil")
}

if let matrix = Matrix(topRow: [10, 5], bottomRow: [20, 30]) {
    print(matrix)
    // Multiple that Matrix
    let multipledMatrix = 5 * matrix
    print(multipledMatrix)
}


