//
//  CustomOperatorsTests.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 7/25/23.
//

import XCTest
@testable import SwiftJog

final class CustomOperatorsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExponentialOperation() {
        XCTAssert(2 ** 4 == 16)
        XCTAssert(2 ** 0 == 1)
        XCTAssert(2 ** 1 == 2)
        XCTAssert(2 ** 2 == 4)
        XCTAssert(2 ** 3 == 8)
        XCTAssert(2 ** -1 == 0)
        XCTAssert(2 ** -999 == 0)
    }
    
    func testCompoundExponentialOperation() {
        var x = 2
        x **= 4
        XCTAssert(x == 16)
    }
    
    func testPrefixOperator() {
        XCTAssert(~"5" + ~"4" == 9.0, #"~"5" + ~"4" == 9.0"#)
    }
    
    func testPostFixOperator() {
        XCTAssert("5"~ == 5.0, #""5"~ == 5.0"#)
        XCTAssert("-5"~ == 5.0, #""-5"~ == 5.0"#)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
