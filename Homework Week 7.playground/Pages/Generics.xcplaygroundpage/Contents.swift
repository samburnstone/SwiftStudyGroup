//: [Previous](@previous)

//:## Generics
//: _________
//: Start with a simple function that swaps the values of the two parameters
func swapValues<T>(inout a: T, inout b: T)
{
    let tempA = a
    a = b
    b = tempA
}

var value1 = 100
var value2 = 5

swapValues(&value1, b: &value2)

// Note how value1 now contains the value 5, whilst value2 stored 100
value1
value2

//: Generic Types
struct Queue <Element>
{
    var items = [Element]()
    
    mutating func push(element: Element)
    {
        items.append(element)
    }
    
    mutating func pop() -> Element?
    {
        if items.isEmpty
        {
            return nil
        }
        return items.removeFirst()
    }
    
    func peek() -> Element?
    {
        return items.first
    }
    
}

//: Let's try it out on some types
var integerQueue = Queue(items: [0, 1, 2, 4])
integerQueue.dynamicType // Note that compiler automatically infers the type of the Queue
integerQueue.pop()
integerQueue.peek()
integerQueue.pop()

var stringQueue = Queue<String>()
stringQueue.push("Sam")
stringQueue.push("Chris")
stringQueue.pop()
stringQueue.pop()
stringQueue.peek()

//: [Next](@next)
