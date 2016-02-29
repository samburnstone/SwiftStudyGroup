//: [Previous](@previous)

import Foundation
import UIKit
import XCPlayground

let view = UIView()
view.frame = CGRect(x: 0, y: 0, width: 300, height: 300)

let subview1 = UIView(frame: view.frame)
subview1.backgroundColor = .purpleColor()

let subview2 = UIView(frame: view.frame)
subview2.backgroundColor = .greenColor()


let func1 = view.insertSubview(_: atIndex:)
let func2 = view.insertSubview(_: aboveSubview:)
let func3 = view.insertSubview(_: belowSubview:)

func1(subview1, atIndex: 0)

func2(subview2, aboveSubview: subview1)

XCPlaygroundPage.currentPage.liveView = view

//: [Next](@next)
