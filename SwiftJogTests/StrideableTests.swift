//
//  StrideableTests.swift
//  SwiftJogTests
//
//  Created by Dexter Ramos on 8/6/23.
//

import XCTest
@testable import SwiftJog

final class StrideableTests: XCTestCase {

    func testOne() {
        let p1 = Student(name: "p1")
        let p2 = Student(name: "p2")
        let p3 = Student(name: "p3")
        let p4 = Student(name: "p4")
        

        let people = Array(p1...p4)

        XCTAssertTrue(people[0] == p1)
        XCTAssertTrue(people[1] == p2)
        XCTAssertTrue(people[2] == p3)
        XCTAssertTrue(people[3] == p4)
    }
    
    func testTwo() {
        
    }

}
