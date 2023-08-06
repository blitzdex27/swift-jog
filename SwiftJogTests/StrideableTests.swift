//
//  StrideableTests.swift
//  SwiftJogTests
//
//  Created by Dexter Ramos on 8/6/23.
//

import XCTest
@testable import SwiftJog

final class StrideableTests: XCTestCase {

    func testStudnet() {
        let s1 = Student(name: "Johnny", classification: .senior)
        let s2 = Student(name: "Jenny", classification: .senior)
        let s3 = Student(name: "Jiggy", classification: .senior)
        let s4 = Student(name: "July", classification: .senior)
        let s5 = Student(name: "Danny", classification: .junior)
        let s6 = Student(name: "Denny", classification: .junior)
        let s7 = Student(name: "Dinny", classification: .junior)
        let s8 = Student(name: "Donny", classification: .junior)

        
        let allStudents: StudentClosedRange<Student> = s1...s8
        let juniorStudents = allStudents.filter { $0.classification == .junior }
        let seniorStudents = allStudents.filter { $0.classification == .senior }
        
        for juniorStudent in juniorStudents {
            XCTAssertTrue(juniorStudent.classification == .junior)
        }
        
        for seniorStudent in seniorStudents {
            XCTAssertTrue(seniorStudent.classification == .senior)
        }
        
        let studentNames = (s1...s8).map { $0.name }
        let expected = [
            "Johnny",
            "Jenny",
            "Jiggy",
            "July",
            "Danny",
            "Denny",
            "Dinny",
            "Donny",
        ]
        XCTAssertTrue(studentNames == expected)
        
        let studentsExceptLast: StudentRange<Student> = s1..<s8
        let studentNamesExceptLast = studentsExceptLast.map { $0.name }
        let expectedNames = [
            "Johnny",
            "Jenny",
            "Jiggy",
            "July",
            "Danny",
            "Denny",
            "Dinny",
        ]
        XCTAssertTrue(studentNamesExceptLast == expectedNames)

    }

}
