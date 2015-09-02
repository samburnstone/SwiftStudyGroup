//: [Previous](@previous)
//:## Subscripts

//: Let's extend Array with a new subscript method to return a subarray starting at a given index with a given length
extension Array {
    subscript(startIndex: Int, length: Int) -> ArraySlice<Element> {
        // Array aleady has a subscipt that can take a range, so let's use that
        let range = startIndex..<startIndex + length
        return self[range]
    }
}

var array = [1, 10, 20, 50, 100]
// Probably not a very practical use, but demonstrates the point...
array[0, 1]
// Error array[1, 1]

// It's fine to set values using that range
array[1...2] = [1, 1]
array

// But not to retrieve
//array[1...2]

//: Let's try and create a basic Dictionary/Map

struct PoorMansDictionary{
    typealias Key = String
    typealias Value = Int
    
    var keys = [Key]()
    var values = [Value]()
    
    subscript(key: Key) -> Int? {
        get {
            guard let indexOfKey = keys.indexOf(key) else { return nil }
            return values[indexOfKey]
        }
        
        set {
            keys.append(key)
            values.append(newValue!)
        }
    }
    
}

var dict = PoorMansDictionary()
dict["One"] = 1
dict["One Hundred"] = 100
dict["Five Thousand"] = 5000

dict["Five Thousand"]
dict["One"]
dict["Two"] // Doesn't exist in our dictionary

//: [Next](@next)
