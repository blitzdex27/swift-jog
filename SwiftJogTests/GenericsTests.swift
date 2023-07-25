//
//  GenericsTests.swift
//  SwiftJogTests
//
//  Created by Dexter Ramos on 7/25/23.
//

import XCTest
@testable import SwiftJog

final class GenericsTests: XCTestCase {

    
    // MARK: - Generic function
    
    func testGenericFunction() {
        let sum_int = getSumOf(2, 3)
        XCTAssertTrue(sum_int == 5)
        
        let sum1_int8: Int8 = getSumOf(2, 3)
        XCTAssertTrue(sum1_int8 == 5)
        
        let sum1_int16: Int16 = getSumOf(2, 3)
        XCTAssertTrue(sum1_int16 == 5)
        
        let sum1_int32: Int32 = getSumOf(2, 3)
        XCTAssertTrue(sum1_int32 == 5)
        
        let sum1_int64: Int64 = getSumOf(2, 3)
        XCTAssertTrue(sum1_int64 == 5)
        
        let sum2 = getSumOf(2.2, 3.3)
        XCTAssertTrue(sum2 == 5.5)

        let sum3: Float = getSumOf(2.2, 3.3)
        XCTAssertTrue(sum3 == 5.5)
    }
    
    // MARK: Generic type
    
    func testGenericClass() {
        // Tip: ShapeStorage below will only store Rectangle type instances
        let rectangle = Rectangle(width: 2, length: 3)
        XCTAssertTrue(rectangle.width == 2)
        XCTAssertTrue(rectangle.length == 3)
        
        var rectangleStorage = ShapeStorage<Rectangle>()
        XCTAssertTrue(rectangleStorage.container is [Rectangle])
        
        rectangleStorage.push(shape: rectangle)

        // Tip: ShapeStorage below will only store Square type instances
        let square = Square(width: 2)
        var squareStorage = ShapeStorage<Square>()
        squareStorage.push(shape: square)
    }
    

}
