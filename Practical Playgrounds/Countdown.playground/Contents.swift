//: Playground - noun: a place where people can play

import UIKit

let cecil = Cecil()
let target = cecil.generateTarget()

public func solve(person: CountdownContestantType, target: Double, numbers: [Double])
{
    let reachedTarget = person.solveCountdownPuzzleByReachingTarget(target, usingNumbers: numbers)
    cecil.howFarOffWasI(reachedTarget, target: target)
}


let person = StupidPerson()
let pickedNumbers = person.pickAssortmentOfNumbers(cecil.largeNumbers, smallOnes: cecil.smallNumbers)

solve(person, target: target, numbers: pickedNumbers)

let mentalBlankPerson = MentalBlankPerson()

solve(mentalBlankPerson, target: target, numbers: pickedNumbers)

