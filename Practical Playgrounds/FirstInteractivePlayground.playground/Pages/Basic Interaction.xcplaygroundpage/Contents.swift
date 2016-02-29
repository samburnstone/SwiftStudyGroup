//: [Previous](@previous)

import UIKit
import XCPlayground

// Create a view using a 'color literal'. Editor -> Insert Color Literal
let demoView = DemoView(backgroundColor: [#Color(colorLiteralRed: 0.4028071761131287, green: 0.7315050363540649, blue: 0.2071235477924347, alpha: 1)#])

// Show the view in the right sidebar
XCPlaygroundPage.currentPage.liveView = demoView

//: [Next](@next)