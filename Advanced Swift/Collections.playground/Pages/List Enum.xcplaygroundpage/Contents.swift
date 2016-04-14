//: Playground - noun: a place where people can play

import UIKit

// Apple seem to be advocating a move away from naming protocols with a 'Type' suffix
protocol StackType
{
    associatedtype Element
    
    mutating func pop() -> Element?
    mutating func push(Element: Element)
}

// Let's create a linked-list kind of thing

enum List<Element>
{
    case End
    indirect case Node(Element, next: List<Element>)
}

extension List
{
    /**
     #### Quoting 'The Book':
     *“We name this prepending method cons, because that is the name of the operation in LISP (it’s short for “construct,” and adding elements onto the front of the list is sometimes called “consing”).”*
     
     Excerpt From: Chris Eidhof. “Advanced Swift.” iBooks.
     */
    func cons(x: Element) -> List
    {
        return .Node(x, next: self)
    }
}

// Make our list conform to StackType protocol so we can push and pop away

extension List: StackType
{
    mutating func pop() -> Element? {
        switch self
        {
        case .End: return nil
        case let .Node(x, next: nextNode):
            self = nextNode
            return x
        }
    }
    
    mutating func push(element: Element) {
        self = self.cons(element)
    }
}

// Let's test it out

var l = List<Int>.End.cons(10).cons(20).cons(30)

l.pop()
l.pop()
l.push(100)
