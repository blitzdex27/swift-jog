//
//  PatternMatching.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 8/1/23.
//

import Foundation

func fibonacciNumber(position: Int) -> Int {
    
    switch position {
    case let n where n <= 1:
        return 0
    case 2:
        return 1
    case let n:
        return fibonacciNumber(position: n - 1) + fibonacciNumber(position: n - 2)
    }
}

//func fizzBuzz() {
//    for i in 1...100 {
//        switch i {
//        case let n where n % 3 == 0 && n % 5 == 0:
//            print("FizzBuzz")
//        case let n where n % 3 == 0:
//            print("Fizz")
//        case let n where n % 5 == 0:
//            print("Buzz")
//        case let n:
//            print("\(n)")
//        }
//    }
//}

func fizzBuzz() {
    for i in 1...100 {
        switch (i % 3, i % 5) {
        case (0, 0):
            print("FizzBuzz", terminator: " ")
        case (_, 0):
            print("Fizz", terminator: " ")
        case (0, _):
            print("Buzz", terminator: " ")
        case (_, _):
            print("\(i)", terminator: " ")
        }
        print("")
    }
}

func fizzBuzzResult(number: Int) -> String {
    switch (number % 3, number % 5) {
    case (0, 0):
        return "FizzBuzz"
    case (_, 0):
        return "Fizz"
    case (0, _):
        return "Buzz"
    case (_, _):
        return "\(number)"
    }
}

// overloading
func ~=(pattern: [Int], value: Int) -> Bool {
    for i in pattern {
        if i == value {
            return true
        }
    }
    return false
}

// challenge 1
enum FormField {
    case firstName(String)
    case lastName(String)
    case emailAddress(String)
    case age(Int)
}

func checkAge(_ age: FormField, minimum: Int) -> String {
    if case .age(let year) = age {
        if year >= 21 {
            return "Welcome"
        } else {
            return "Sorry, you're too young!"
        }
    }
    return "Incorrect formfield instance"
}

// challenge 2
enum CelestialBody {
    case star
    case planet(name: String, liquidWater: Bool)
    case comet
}

extension CelestialBody: Equatable {
    static func ==(lhs: CelestialBody, rhs: CelestialBody) -> Bool {
        switch (lhs, rhs) {
        case (.star, let x):
            return x == .star
        case (.comet, let x):
            return x == .comet
        case (.planet(name: let lhsName, liquidWater: let lhsLiquidWater),
              .planet(name: let rhsName, liquidWater: let rhsLiquidWater)):
            return lhsName == rhsName && lhsLiquidWater == rhsLiquidWater
        case (_, _):
            return false
        }
    }
}

// challenge 3
func extractAlbums(_ albums: [(String, Int)], for year: Int) -> [String] {
    
    var titles: [String] = []
    for case let (title, year) in albums where year == 1974 {
        titles.append(title)
    }
    return titles
}

// challenge 4
enum HemisphereAndEquator {
    case northernHemisphere
    case southernHemisphere
    case equator
}

func getHemisphereOrEquator(coordinates: (lat: Double, long: Double)) -> HemisphereAndEquator {
    
    switch coordinates {
    case let (latitude, _) where latitude > 0:
        return .northernHemisphere
    case let (latitude, _) where latitude < 0:
        return .southernHemisphere
    case (_, _):
        return .equator
    }
}
