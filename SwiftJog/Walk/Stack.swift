//
//  Stack.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 7/25/23.
//

/*:
 Create a generic stack having these operations:
 - peek - returns the top element of the stack,  returns nil if no element
 - push - add element to stack
 - pop  - removes element from stack and returns it; returns nil if no element
 - count - returns the number of elements in the stack
 */

import Foundation

struct Stack<Element: Equatable> {
    let id = UUID().uuidString
    var _container: [Element] = []
    
    mutating func push(_ element: Element) {
        _container.append(element)
    }
    
    mutating func pop() -> Element? {
        guard !_container.isEmpty else { return nil }
        return _container.removeLast()
    }
    
    func peek() -> Element? {
        return _container.last
    }
    
    var count: Int {
        return _container.count
    }
}

extension Stack: Equatable {
    static func == (lhs: Stack<Element>, rhs: Stack<Element>) -> Bool {
        
        if lhs.id == rhs.id {
            return true
        }
        
        return lhs._container == rhs._container
    }
}
