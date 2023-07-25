//
//  LoggerTests.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 7/25/23.
//

import XCTest
@testable import SwiftJog

final class LoggerTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testIsSingleton() {
        
        let logger1 = Logger.shared
        let logger2 = Logger.shared
        
        XCTAssert(logger1 == logger2)

    }

    func testCanOnlyBeInstantiatedUsingShared() {
        // Line below should have a compiler error
        // let logger = Logger()
    }
    
    func testLogMethod() {
        let id = Logger.shared.log()
        XCTAssert(id == Logger.shared.id)
    }

}
