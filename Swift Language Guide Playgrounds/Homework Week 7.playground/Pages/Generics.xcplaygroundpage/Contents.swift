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

//:### Generic Types
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

//:### Defining Constraints For Types
//: __________
//: A contrived example is a function taking two parameters where we check the type of the elements contained within each collection are equal AND the types conform to the `Equatable` protocol. NOTE: As C1 and C2 element types have already been checked to be equal, we can omit a check that C2's item type also conforms to Equatable

func collectionIsSubsetOfOtherCollection<C1: CollectionType, C2: CollectionType where C1.Generator.Element == C2.Generator.Element, C1.Generator.Element: Equatable>(possibleSubsetCollection: C1, collectionToCheckAgainst: C2) -> Bool
{
    for itemA in possibleSubsetCollection
    {
        if !collectionToCheckAgainst.contains(itemA)
        {
            return false
        }
    }
    
    // If we get to here then all items in collection A exist in collection B
    return true
}

var queueOfStrings = Set<String>()
queueOfStrings.insert("Sam")
queueOfStrings.insert("Ryan")
queueOfStrings.insert("Rob")
//queueOfStrings.insert("Andy") // <- Would cause to return false

var arrayOfStrings = Array<String>()
arrayOfStrings.append("Sam")
arrayOfStrings.append("Ryan")
arrayOfStrings.append("Rob")

collectionIsSubsetOfOtherCollection(queueOfStrings, collectionToCheckAgainst:arrayOfStrings)

//: Tried to implement the above as an extension of CollectionType but had no luck :(´®
//extension CollectionType
//{
//    func isSubsetOfCollection<T: CollectionType where T.Generator.Element == Self.Generator.Element, T.Generator.Element: Equatable>(otherCollection: T) -> Bool
//    {
//        for itemA in self
//        {
//            var found = false
//            for itemB in otherCollection
//            {
//                if itemA == itemB
//                {
//                    found = true
//                }
//            }
//            if !found
//            {
//                return false
//            }
//        }
//        
//        // If we get to here then all items in collection A exist in collection B
//        return true
//    }
//}

//arrayOfStrings.isSubsetOfCollection(queueOfStrings)

//:### Associated types
//: Protocols cannot be defined generically using type parameters. Can instead define an **associated type** using `typealias` keyword
protocol FoodItemDigestingType
{
    typealias Food: FoodItemType
    
    func eat(food: Food)
    
    func excrete(food: Food)
}

protocol FoodItemType {}
struct Bamboo: FoodItemType {}
struct Honey: FoodItemType {}

struct IronGirder {}

//: Note that if the types we pass in for `eat` and `excrete` don't match we get a compiler error
struct Panda: FoodItemDigestingType
{
    func eat(food: Bamboo)
    {
    }
    
    func excrete(food: Bamboo)
    {
    }
}

//: **Note:** The below does not compile as we're passing a type that does not conform to `FoodItemType`. This constraint is set by due to: `typealias Food: FoodItemType`
//struct Alien: FoodItemDigestingType {
//    func eat(food: IronGirder) {}
//    
//    func excrete(food: IronGirder) {}
//}

//: [Next](@next)
