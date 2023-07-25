//
//  CustomOperators.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 7/25/23.
//

import Foundation

precedencegroup ExponentialPrecedence {
    higherThan: MultiplicationPrecedence
    associativity: right
}

infix operator **: ExponentialPrecedence

func **(lhs: Int, rhs: Int) -> Int {
    switch rhs {
    case _ where rhs == 0:
        return 1
    case _ where rhs == 1:
        return lhs
    case _ where rhs > 1:
        var result = 1
        for _ in 1...rhs {
            result *= lhs
        }
        return result
    default:
        return 0
    }
}


// Compound Exponential Operation

precedencegroup CompoundExponentialPrecedence {
    higherThan: DefaultPrecedence
    associativity: right
}

infix operator **=

func **=(lhs: inout Int, rhs: Int) {
    lhs = lhs ** rhs
}

// prefix operator

prefix operator ~

prefix func ~(str: String) -> Double {
    return Double(str) ?? 0.0
}

// postfix operator

postfix operator ~

postfix func ~(str: String) -> Double {
    switch ~str {
    case ...0:
        return ~str * -1
    default:
        return ~str
    }
}
