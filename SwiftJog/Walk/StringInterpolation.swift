//
//  StringInterpolation.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 8/4/23.
//

import Foundation

extension String.StringInterpolation {
    mutating func appendInterpolation(format age: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        if let result = formatter.string(from: age as NSNumber) {
            appendLiteral(result)
        }
    }
    
    mutating func appendInterpolation(format age: Int, style: NumberFormatter.Style) {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        
        if let result = formatter.string(from: age as NSNumber) {
            appendLiteral(result)
        }
    }
    
    mutating func appendInterpolation(format date: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        let result = formatter.string(from: date)
        appendLiteral(result)
    }
    
    mutating func appendInterpolation(format date: Date, style: DateFormatter.Style) {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        
        let result = formatter.string(from: date)
        appendLiteral(result)
    }
    
    mutating func appendInterpolation(twitter: StringLiteralType) {
        let result = #"<a href="https://www.twitter.com/\#(twitter)">@\#(twitter)</a>"#
        appendLiteral(result)
    }
    
    mutating func appendInterpolation(_ stringArray: [StringLiteralType]) {
        let result = stringArray.joined(separator: ", ")
        appendLiteral(result)
    }
    
    mutating func appendInterpolation(_ stringArray: [StringLiteralType], defaultValue: StringLiteralType) {
        print(stringArray)
        if stringArray.isEmpty {
            appendLiteral(defaultValue)
        } else {
            appendLiteral(stringArray.joined(separator: ", "))
        }
    }
    
    mutating func appendInterpolation(swiftRocks condition: Bool, _ literal: StringLiteralType) {
        guard condition == true else {
            return
        }
        appendLiteral(literal)
    }
    

}

struct Person: Encodable {
    let type: String
    let action: String
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ person: Person, count: Int) {
        let action = String(repeating: "\(person.action) ", count: count)
        appendLiteral("\n\(person.type) \(action)".trimmingCharacters(in: .whitespaces))
    }
    
    mutating func appendInterpolation(debug person: Person) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let data = try? encoder.encode(person),
           let result = String(data: data, encoding: .utf8)
        { appendLiteral(result) }
    }
    
    mutating func appendInterpolation(debugThrowing person: Person) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data = try encoder.encode(person)
        if let result = String(data: data, encoding: .utf8) {
            appendLiteral(result)
        }
    }
}
