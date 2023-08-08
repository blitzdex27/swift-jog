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
        let employeeData = try? jsonEncoder.encode(employee)
        XCTAssertNotNil(employeeData)
        

        let expectedEncodedJson = #"{"name":"Dexter","department":"Tech"}"#
        let encodedJson = String(data: employeeData, encoding: .utf8)!
        XCTAssertTrue(encodedJson == expectedEncodedJson)
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
        let employeeData = try? jsonEncoder.encode(employee)
        XCTAssertNotNil(employeeData)
        

        let expectedEncodedJson = #"{"name":"Dexter","department":"Tech","profile":{language:"English"}}"#
        let encodedJson = String(data: employeeData, encoding: .utf8)!
        XCTAssertTrue(encodedJson == expectedEncodedJson)
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
     - create a copy of Employee model and name it EmployeeV3
     - do not change the structure and names of EmployeeV3 directly
     */
    
    func testCustomKeyEncode() {
        let employee = EmployeeV3(name: "Dexter", department: "Tech")
        
        let jsonEncoder = JSONEncoder()
        let employeeData = jsonEncoder.encode(employee)
        
        let employeeJson = String(data: employeeData, encoding: .utf8)!
        let expectedEmployeeJson = #"{"first_name":"Dexter","department":"Tech"}"#
        XCTAssertTrue(employeeJson == expectedEmployeeJson)
        
    }
    
    func testCustomKeyDecode() {
        let employeeJson = #"{"first_name":"Dexter","department":"Tech"}"#
        let employeeData = employeeJson.data(using: .utf8)!
        
        let jsonDecoder = JSONDecoder()
        let employee = jsonDecoder.decode(EmployeeV3.self, from: employeeData)
        XCTAssertNotNil(employee)
        
        let expectedEmployee = EmployeeV3(name: "Dexter", department: "Tech")
        XCTAssertTrue(employee.name == expectedEmployee.name)
        XCTAssertTrue(employee.department == expectedEmployee.department)
    }
    

    /*
     Part 4: Different data structure
     - data structure was changed
        - from: {"name":"Dexter","department":"Tech","profile":{"language":"English"}}
        - to: {"name":"Dexter","department":"Tech","language":"English"}
     - make a custom encode(to:) and decode(from:) function
     - do not change the structure of the model
     */
    
    func testCustomEncode() {
        let profile = Profile(language: "English")
        let employee = EmployeeV2(name: "Dexter", department: "Tech", profile: profile)
        
        let jsonEncoder = JSONEncoder()
        let employeeData = try? jsonEncoder.encode(employee)
        XCTAssertNotNil(employeeData)
        
        let expectedEncodedJson = #"{"name":"Dexter","department":"Tech","language":"English"}"#
        let encodedJson = String(data: employeeData, encoding: .utf8)!
        XCTAssertTrue(encodedJson == expectedEncodedJson)
    }
    

    func testCustomDecode() {
        let employeeJSON = #"{"name":"Dexter","department":"Tech","language":"English"}"#
        let employeeData = employeeJSON.data(using: .utf8)!
        

        let jsonDecoder = JSONDecoder()
        let employee = try? jsonDecoder.decode(EmployeeV2.self, from: employeeData)
        XCTAssertNotNil(employee)


        let profile = Profile(language: "English")
        let expectedEmployeeObject = Employee(name: "Dexter", department: "Tech", profile: profile)

        XCTAssertTrue(employee!.name == expectedEmployeeObject.name)
        XCTAssertTrue(employee!.department == expectedEmployeeObject.department)
    }
    

    
}
