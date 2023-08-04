//
//  StringInterpolationTests.swift
//  SwiftJogTests
//
//  Created by Dexter Ramos on 8/4/23.
//

import XCTest
@testable import SwiftJog

final class StringInterpolationTests: XCTestCase {
    
    func testInterpolation() {
        XCTAssertTrue("hello, I am \(format: 31)" == "hello, I am thirty-one")
        XCTAssertTrue("hello, I am \(format: 31, style: .spellOut)" == "hello, I am thirty-one")
    }
    
    func testDateInterpolation() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        var dateString = dateFormatter.string(from: Date())
        XCTAssertTrue("Today is \(format: Date())" == "Today is \(dateString)")
        
        dateFormatter.dateStyle = .long
        dateString = dateFormatter.string(from: Date())
        XCTAssertTrue("Today is \(format: Date(), style: .long)" == "Today is \(dateString)")
    }
    
    func testTwitter() {
        let expected = #"Follow me on <a href="https://www.twitter.com/superdex27">@superdex27</a>"#
        XCTAssertTrue("Follow me on \(twitter: "superdex27")" == expected)
    }
    
    func testArrayString() {
        XCTAssertTrue("Visitors: \(["Jenny", "Tom", "Jack"])" == "Visitors: Jenny, Tom, Jack")
        XCTAssertTrue("Visitors: \(["Jenny", "Tom", "Jack"], defaultValue: "No one")" == "Visitors: Jenny, Tom, Jack")
        XCTAssertTrue("Visitors: \([String](), defaultValue: "No one")" == "Visitors: No one")
    }
    
    func testDoesSwiftRocks() {
        XCTAssertTrue("Swift rocks: \(swiftRocks: true, "(*)")" == "Swift rocks: (*)")
        XCTAssertTrue("Swift rocks: \(swiftRocks: false, "(*)")" == "Swift rocks: ")
    }
    
    func testInterpolationPart2() {
        let hater = Person(type: "hater", action: "hate")
        let breaker = Person(type: "breaker", action: "break")
        let faker = Person(type: "faker", action: "fake")
        
        print("Let's sing: \(hater, count: 5) \(breaker, count: 5) \(faker, count: 5)")

    }
    
    func testEncoding() {
        // encoding
        let hater = Person(type: "hater", action: "hate")
        print("\(debug: hater)")

    }
    
    func testEncodingThatThrows() throws {
        let faker = Person(type: "faker", action: "fake")
        print(try "\(debugThrowing: faker)")
    }
}
