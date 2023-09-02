//
//  PropertyWrapperTests.swift
//  SwiftJogTests
//
//  Created by Dexter Ramos on 9/2/23.
//

import XCTest
@testable import SwiftJog

final class PropertyWrapperTests: XCTestCase {

    func testLimitingWrapper() {
        
        @ZeroToOne var number: Int = 4
        XCTAssertTrue(number == 1)
        
        number = -4
        XCTAssertTrue(number == 0)
    }
    
    func testGenericLimitingWrapper() {
        
        @ZeroToTwo var numberInt: Int = 4
        XCTAssertTrue(numberInt == 2)
        numberInt = -4
        XCTAssertTrue(numberInt == 0)
        
        @ZeroToTwo var numberDouble: Double = 100
        XCTAssertTrue(numberDouble == 2)
        numberDouble = -200
        XCTAssertTrue(numberDouble == 0)
    }
    
    func testLimitingWrapperWithParameter() {
        
        @ZeroToX(max: 3) var number = 10
        XCTAssertTrue(number == 3)
        
        number = -20
        XCTAssertTrue(number == 0)
    }
    
    func testProjectedValue() {
        
        @ZeroToThree var number: Int = 10
        XCTAssertTrue(number == 3)
        
        XCTAssertTrue($number == 10)
    }
    
    func testProjectedValueChangeMaxAndMin() {
        
        @ZeroToY(max: 3) var number: Int = 10
        XCTAssertTrue(number == 3)
        
        $number.max = 4
        XCTAssertTrue(number == 4)
        
        number = 20
        XCTAssertTrue(number == 4)
        
        number = -200
        XCTAssertTrue(number == 0)
        
        $number.min = 2
        number = -200
        XCTAssertTrue(number == 2)
    }
    
    func testChallenge() {
        @ValidatedDate var dateString = "2023-09-01"
        XCTAssertTrue(dateString == "2023-09-01")
        
        dateString = "2023"
        XCTAssertTrue(dateString == "Invalid date")
        
        @ValidatedDate(format: "MM dd, yyyy") var dateString2 = "12 27, 1992"
        XCTAssertTrue(dateString2 == "12 27, 1992", dateString)
        
        $dateString2.dateFormat = "yyyy-MM-dd"
        XCTAssertTrue(dateString2 == "1992-12-27")
        
        $dateString2.dateFormat = "MMM dd, yyyy"
        XCTAssertTrue(dateString2 == "Dec 27, 1992")
    }
   
}
