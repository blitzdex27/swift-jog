//
//  StackTests.swift
//  SwiftJogTests
//
//  Created by Dexter Ramos on 7/25/23.
//

import XCTest
@testable import SwiftJog

final class StackTests: XCTestCase {

    func testPush() {
        var stack: Stack<String> = Stack()
        
        stack.push("Chrome")
        XCTAssertTrue(stack._container.count == 1)
        XCTAssertTrue(stack._container[0] == "Chrome")
        
        stack.push("Safari")
        XCTAssertTrue(stack._container.count == 2)
        XCTAssertTrue(stack._container[1] == "Safari")
        
        stack.push("App Store")
        XCTAssertTrue(stack._container.count == 3)
        XCTAssertTrue(stack._container[2] == "App Store")
    }
    
    func testPop() {
        var stack: Stack<String> = Stack()
        XCTAssertTrue(stack.pop() == nil)
        XCTAssertTrue(stack._container.count == 0)
        
        stack.push("Chrome")
        stack.push("Safari")
        stack.push("App Store")
        
        XCTAssertTrue(stack.pop() == "App Store")
        XCTAssertTrue(stack._container[stack._container.count-1] == "Safari")
        XCTAssertTrue(stack._container.count == 2)
        
        XCTAssertTrue(stack.pop() == "Safari")
        XCTAssertTrue(stack._container[stack._container.count-1] == "Chrome")
        XCTAssertTrue(stack._container.count == 1)
        
        XCTAssertTrue(stack.pop() == "Chrome")
        XCTAssertTrue(stack._container.count == 0)
    }
    
    func testCount() {
        var stack: Stack<String> = Stack()
        XCTAssertTrue(stack.count == 0)
        
        stack.push("Chrome")
        XCTAssertTrue(stack.count == 1)
        
        stack.push("Safari")
        XCTAssertTrue(stack.count == 2)
        
        stack.push("App Store")
        XCTAssertTrue(stack.count == 3)
        
    }
    
    func testPeek() {
        var stack: Stack<String> = Stack()
        XCTAssertTrue(stack.peek() == nil)
        
        stack.push("Chrome")
        XCTAssertTrue(stack.peek() == "Chrome")
        
        stack.push("Safari")
        XCTAssertTrue(stack.peek() == "Safari")
        
        stack.push("App Store")
        XCTAssertTrue(stack.peek() == "App Store")
    }
    
    func testAll() {
        var stack: Stack<String> = Stack()

        stack.push("First element")
        XCTAssertTrue(stack.count == 1)
        XCTAssertTrue(stack.peek() == "First element")
        
        stack.push("Second element")
        XCTAssertTrue(stack.count == 2)
        XCTAssertTrue(stack.peek() == "Second element")
        
        stack.push("Third element")
        XCTAssertTrue(stack.count == 3)
        XCTAssertTrue(stack.peek() == "Third element")
        
        let thirdElement = stack.pop()
        XCTAssertTrue(stack.count == 2)
        XCTAssertTrue(stack.peek() == "Second element")
        guard let thirdElement else { XCTFail(); return }
        XCTAssertTrue(thirdElement == "Third element")
        
        let secondElement = stack.pop()
        XCTAssertTrue(stack.count == 1)
        XCTAssertTrue(stack.peek() == "First element")
        guard let secondElement else { XCTFail(); return }
        XCTAssertTrue(secondElement == "Second element")
        
        let firstElement = stack.pop()
        XCTAssertTrue(stack.count == 0)
        XCTAssertTrue(stack.peek() == nil)
        guard let firstElement else { XCTFail(); return }
        XCTAssertTrue(firstElement == "First element")
    }
    
    // Advanced
    
    func testEquality() {
        var stack1: Stack<String> = Stack()
        var stack2 = Stack<String>()
        XCTAssertTrue(stack1 == stack1)
        XCTAssertTrue(stack2 == stack2)
        XCTAssertTrue(stack1 == stack2)
        
        stack1.push("Chrome")
        stack2.push("Chrome")
        XCTAssertTrue(stack1 == stack2)
        
        stack1.push("Safari")
        stack2.push("Safari")
        XCTAssertTrue(stack1 == stack2)
        
        stack1.push("App Store")
        stack2.push("App Store")
        XCTAssertTrue(stack1 == stack2)

        let _ = stack2.pop()
        XCTAssertFalse(stack1 == stack2)
        
        let _ = stack1.pop()
        XCTAssertTrue(stack1 == stack2)
        
        let _ = stack2.pop()
        let _ = stack2.pop()
        XCTAssertFalse(stack1 == stack2)
        
        let _ = stack1.pop()
        XCTAssertFalse(stack1 == stack2)
        
        let _ = stack1.pop()
        XCTAssertTrue(stack1 == stack2)
        
        let _ = stack1.pop()
        let _ = stack1.pop()
        let _ = stack2.pop()
        let _ = stack2.pop()
        XCTAssertTrue(stack1 == stack2)
        
    }

}
