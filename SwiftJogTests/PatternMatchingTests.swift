//
//  PatternMatchingTests.swift
//  SwiftJogTests
//
//  Created by Dexter Ramos on 8/1/23.
//

import XCTest
@testable import SwiftJog

/// Pattern Matching
///
/// - A pattern represents the structure of a value.
/// - Pattern matching can help you write more readable code than the alternative logical conditions.
/// - Pattern matching is the only way to extract associated values from enumeration values.
class PatternMatchingTests: XCTestCase {
    
    /// In the Fibonacci sequence, every element is the sum of the two preceding elements. The sequence starts with 0, 1, ...
    func testFibonacci() {
        XCTAssertTrue(fibonacciNumber(position: 1) == 0)
        XCTAssertTrue(fibonacciNumber(position: 2) == 1)
        XCTAssertTrue(fibonacciNumber(position: 3) == 1)
        XCTAssertTrue(fibonacciNumber(position: 4) == 2)
        XCTAssertTrue(fibonacciNumber(position: 5) == 3)
        XCTAssertTrue(fibonacciNumber(position: 6) == 5)
        XCTAssertTrue(fibonacciNumber(position: 7) == 8)
    }
    
    /// In the FizzBuzz algorithm, your objective is to return the numbers from 1 to 100, except:
    /// - On multiples of three, print "Fizz" instead of the number.
    /// - On multiples of five, print "Buzz" instead of the number.
    /// - On multiples of both three and five, print "FizzBuzz" instead of the number.
    func testFizzBuzz() {
        fizzBuzz()
        XCTAssertTrue(fizzBuzzResult(number: 1) == "1")
        XCTAssertTrue(fizzBuzzResult(number: 2) == "2")
        XCTAssertTrue(fizzBuzzResult(number: 3) == "Buzz")
        XCTAssertTrue(fizzBuzzResult(number: 4) == "4")
        XCTAssertTrue(fizzBuzzResult(number: 5) == "Fizz")
        XCTAssertTrue(fizzBuzzResult(number: 30) == "FizzBuzz")
        XCTAssertTrue(fizzBuzzResult(number: 100) == "Fizz")
    }
    
    /// Overloading ~=
    /// Comparing x and y
    /// - will use == if same time
    /// - else, will use ~=
    func testOverloading() {
        let list = [0, 1, 2, 3]
        let integer = 2
        
        let _ = (list ~= integer)
        
        if case list = integer {
            print("The integer is in the array")
        } else {
            print("The integer is not in the array")
        }
    }
    
    /// If age is less then the minimum age, reject
    /// else, welcome
    func testChallenge1() {
        
        let minimumAge = 21
        
        XCTAssertTrue(checkAge(FormField.age(22), minimum: minimumAge) == "Welcome")
        XCTAssertTrue(checkAge(FormField.age(20), minimum: minimumAge) == "Sorry, you're too young!")
        XCTAssertTrue(checkAge(FormField.firstName("dex"), minimum: minimumAge) == "Incorrect formfield instance")
        XCTAssertTrue(checkAge(FormField.lastName("dex"), minimum: minimumAge) == "Incorrect formfield instance")
        XCTAssertTrue(checkAge(FormField.emailAddress("dex@com"), minimum: minimumAge) == "Incorrect formfield instance")
    }
    
    /// Find planets that can contain life
    func testChallenge2() {
        let telescopeCensus = [
            CelestialBody.star,
            .planet(name: "Pluto", liquidWater: false),
            .planet(name: "Earth", liquidWater: true),
            .planet(name: "Mars", liquidWater: true),
            .comet
        ]
        
        var planetsWithLiquidWater: [CelestialBody] = []
        
        for case .planet(let name, let liquidWater) in telescopeCensus where liquidWater == true {
            planetsWithLiquidWater.append(.planet(name: name, liquidWater: liquidWater))
        }
        
        XCTAssertTrue(planetsWithLiquidWater == [
            .planet(name: "Earth", liquidWater: true),
            .planet(name: "Mars", liquidWater: true)
        ])
    }
    
    // extract the albums released on 1974
    func testChallenge3() {
        let queenAlbums = [
            ("A Night at the Opera", 1974),
            ("Shee Heart Attack", 1974),
            ("Jazz", 1978),
            ("The Game", 1980)
        ]
        
        let albumsReleasedIn1974 = extractAlbums(queenAlbums, for: 1974)
        XCTAssertTrue(albumsReleasedIn1974.contains("A Night at the Opera"))
        XCTAssertTrue(albumsReleasedIn1974.contains("Shee Heart Attack"))
        XCTAssertFalse(albumsReleasedIn1974.contains("Jazz"))
        XCTAssertFalse(albumsReleasedIn1974.contains("The Game"))
    }
    
    /// Write a switch statement that will print out whether the monument is located in the northern hemisphere, the southern hemisphere, or on the equator.
    func testChallenge4() {
        
        XCTAssertTrue(getHemisphereOrEquator(coordinates: (lat: 37.334890, long: -122.009000)) == .northernHemisphere)
        XCTAssertTrue(getHemisphereOrEquator(coordinates: (lat: -37.334890, long: -122.009000)) == .southernHemisphere)
        XCTAssertTrue(getHemisphereOrEquator(coordinates: (lat: 0, long: -122.009000)) == .equator)
    }
}
