//
//  EncodeDecodeTests.swift
//  SwiftJogTests
//
//  Created by Dexter Ramos on 8/8/23.
//

import XCTest
@testable import SwiftJog

class EncodeDecodeTests: XCTestCase {
    
    /*
     Part 1: Default
     */
    
    func testDefaultEncode() {
        // object -> data -> json
        let employee = Employee(name: "Dexter", department: "Tech")
        
        
        let jsonEncoder = JSONEncoder()
        let employeeData = try! jsonEncoder.encode(employee)
        XCTAssertNotNil(employeeData)
        
        let encodedJson = String(data: employeeData, encoding: .utf8)!
        XCTAssertTrue(encodedJson.contains(#""name":"Dexter""#))
        XCTAssertTrue(encodedJson.contains(#""department":"Tech""#))
    }
    
    func testDefaultDecode() {
        // json -> data -> object
        let employeeJSON = #"{"name":"Dexter","department":"Tech"}"#
        let employeeData = employeeJSON.data(using: .utf8)!
        
        let jsonDecoder = JSONDecoder()
        let employee = try? jsonDecoder.decode(Employee.self, from: employeeData)
        XCTAssertNotNil(employee)
        
        let expectedEmployeeObject = Employee(name: "Dexter", department: "Tech")

        XCTAssertTrue(employee!.name == expectedEmployeeObject.name)
        XCTAssertTrue(employee!.department == expectedEmployeeObject.department)
    }

    /*
     Part 2: Nested data struct
     */

    func testDefaultEncode2() {
        let profile = Profile(language: "English")
        let employee = Employee(name: "Dexter", department: "Tech", profile: profile)


        let jsonEncoder = JSONEncoder()
        let employeeData = try! jsonEncoder.encode(employee)
        XCTAssertNotNil(employeeData)

        let encodedJson = String(data: employeeData, encoding: .utf8)!
        XCTAssertTrue(encodedJson.contains(#""name":"Dexter""#))
        XCTAssertTrue(encodedJson.contains(#""department":"Tech""#))
        XCTAssertTrue(encodedJson.contains(#""profile":{"language":"English"}"#))
    }

    func testDefaultDecode2() {
        let employeeJSON = #"{"name":"Dexter","department":"Tech","profile":{"language":"English"}}"#
        let employeeData = employeeJSON.data(using: .utf8)!


        let jsonDecoder = JSONDecoder()
        let employee = try? jsonDecoder.decode(Employee.self, from: employeeData)
        XCTAssertNotNil(employee)


        let profile = Profile(language: "English")
        let expectedEmployeeObject = Employee(name: "Dexter", department: "Tech", profile: profile)

        XCTAssertTrue(employee!.name == expectedEmployeeObject.name)
        XCTAssertTrue(employee!.department == expectedEmployeeObject.department)
    }

    /*
     Part 3: different key
     - name key was changed to first_name
     - create a copy of Employee model and name it EmployeeV2
     - do not change the structure and names of EmployeeV2 directly
     */

    func testCustomKeyEncode() {
        let employee = EmployeeV2(name: "Dexter", department: "Tech")

        let jsonEncoder = JSONEncoder()
        let employeeData = try! jsonEncoder.encode(employee)

        let employeeJson = String(data: employeeData, encoding: .utf8)!
        let expectedEmployeeJson = #"{"first_name":"Dexter","department":"Tech"}"#
        XCTAssertTrue(employeeJson.contains(#""first_name":"Dexter""#))
        XCTAssertTrue(employeeJson.contains(#""department":"Tech""#))
                                            

    }

    func testCustomKeyDecode() {
        let employeeJson = #"{"first_name":"Dexter","department":"Tech"}"#
        let employeeData = employeeJson.data(using: .utf8)!

        let jsonDecoder = JSONDecoder()
        let employee = try! jsonDecoder.decode(EmployeeV2.self, from: employeeData)
        XCTAssertNotNil(employee)

        let expectedEmployee = EmployeeV2(name: "Dexter", department: "Tech")
        XCTAssertTrue(employee.name == expectedEmployee.name)
        XCTAssertTrue(employee.department == expectedEmployee.department)
    }


    /*
     Part 4: Different data structure minimally
     - data structure was changed
        - from: {"name":"Dexter","department":"Tech","profile":{"profile":"English"}}
        - to: {"name":"Dexter","department":"Tech","profile":"English"}
     - copy Employee struct and name it to EmployeeV3
     - make a custom encode(to:) and decode(from:) function
     - do not change the structure of the model
     */

    func testCustomEncode() {
        let profile = Profile(language: "English")
        let employee = EmployeeV3(name: "Dexter", department: "Tech", profile: profile)

        let jsonEncoder = JSONEncoder()
        let employeeData = try! jsonEncoder.encode(employee)
        XCTAssertNotNil(employeeData)

        let encodedJson = String(data: employeeData, encoding: .utf8)!
        XCTAssertTrue(encodedJson.contains(#""name":"Dexter""#))
        XCTAssertTrue(encodedJson.contains(#""department":"Tech""#))
        XCTAssertTrue(encodedJson.contains(#""profile":"English""#))
    }
    
    func testCustomEncodeWithMissing() {
        let profile = Profile(language: "English")
        let employee = EmployeeV3(name: "Dexter", department: "Tech")

        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = [.sortedKeys]
        let employeeData = try! jsonEncoder.encode(employee)
        XCTAssertNotNil(employeeData)

        let encodedJson = String(data: employeeData, encoding: .utf8)!
        
        let expectedJson = #"{"department":"Tech","name":"Dexter"}"#
        XCTAssertTrue(encodedJson == expectedJson, """
        
        compared:\t\(encodedJson)
        expected:\t\t\(expectedJson)
        """)
        XCTAssertTrue(encodedJson.contains(#""name":"Dexter""#))
        XCTAssertTrue(encodedJson.contains(#""department":"Tech""#))
        XCTAssertTrue(!encodedJson.contains(#""profile":"English""#))
    }


    func testCustomDecode() {
        let employeeJSON = #"{"name":"Dexter","department":"Tech","profile":"English"}"#
        let employeeData = employeeJSON.data(using: .utf8)!


        let jsonDecoder = JSONDecoder()
        let employee = try! jsonDecoder.decode(EmployeeV3.self, from: employeeData)
        XCTAssertNotNil(employee)


        let profile = Profile(language: "English")
        let expectedEmployeeObject = Employee(name: "Dexter", department: "Tech", profile: profile)

        XCTAssertTrue(employee.name == expectedEmployeeObject.name)
        XCTAssertTrue(employee.department == expectedEmployeeObject.department)
    }
    
    func testCustomDecodeWithMissing() {
        let employeeJSON = #"{"name":"Dexter","department":"Tech"}"#
        let employeeData = employeeJSON.data(using: .utf8)!


        let jsonDecoder = JSONDecoder()
        let employee = try! jsonDecoder.decode(EmployeeV3.self, from: employeeData)
        XCTAssertNotNil(employee)

        let profile = Profile(language: "English")
        let expectedEmployeeObject = Employee(name: "Dexter", department: "Tech", profile: profile)
        
        XCTAssertTrue(employee.name == expectedEmployeeObject.name)
        XCTAssertTrue(employee.department == expectedEmployeeObject.department)
        XCTAssertNil(employee.profile)
    }



    
    
}
