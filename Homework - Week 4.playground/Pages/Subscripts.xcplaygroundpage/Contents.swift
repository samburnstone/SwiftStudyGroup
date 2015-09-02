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

struct PoorMansDictionary {
    typealias Key = String
    typealias Value = Int
    
    var keys = [Key]()
    var values = [Value]()
    
    subscript(key: Key) -> Int? {
        get {
            // Check if key exists in keys array
            guard let indexOfKey = keys.indexOf(key) else { return nil }
            return values[indexOfKey]
        }
        
        // setter is smart enough to know that 'newValue' should be of type Int?
        set {
            
            // If newValue is nil, then remove key and value from dictionary
            guard let newValue = newValue else {
                if let indexOfKey = keys.indexOf(key) {
                    keys.removeAtIndex(indexOfKey)
                    values.removeAtIndex(indexOfKey)
                }
                return
            }
            
            if let indexOfKey = keys.indexOf(key) {
                // Update the value associated with the key
                values[indexOfKey] = newValue
            }
            else {
                // In this case, we have a brand new key, value pair
                keys.append(key)
                values.append(newValue)
            }
        }
    }
    
}

var agesDict = PoorMansDictionary()
agesDict["Sam"] = 22
agesDict["Chris"] = 27
agesDict["Rob"] = -2

agesDict["Sam"]
agesDict["Ryan"] // Doesn't exist in our dictionary

// Remove from our dictionary by assigning nil
agesDict["Chris"] = nil
agesDict["Chris"] // No longer exists

// Update a preexisting key with new value
agesDict["Rob"] = 26
agesDict["Rob"]

//: [Next](@next)
