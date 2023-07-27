//
//  ResultBuilderTests.swift
//  Swift-jog2Tests
//
//  Created by Dexter Ramos on 7/27/23.
//

import XCTest
@testable import Swift_jog2

class ResultBuilderTests: XCTestCase {
    
    func testPlainString() {
        let expected = NSAttributedString(string: "testString")
        XCTAssertTrue(Text("testString").string == expected.string)
    }
    
    func testAttributedString() {
        let text = Text("testString")
            .color(.green)
        
        let expected = NSAttributedString(string: "testString", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.green
        ])
        
        
        XCTAssertTrue(text == expected)
    }
    
    func testCustomResultBuilder() {
        let greetings = greetBuilder(name: "Deks")
        
        let expected = manualGreetBuilder(name: "Deks")
        
        XCTAssertTrue(greetings == expected)
    }
    
    func testBuilderWithConditionalLogicOptional() {
        let greetingsAsk = greetBuilder(name: "Deks", shouldAskWellBeing: true)
        let expectedAsk = manualGreetBuilder(name: "Deks", shouldAskWellBeing: true)
        XCTAssertTrue(greetingsAsk == expectedAsk)
        
        
        let greetingsNoAsk = greetBuilder(name: "Deks", shouldAskWellBeing: false)
        let expectedNoAsk = manualGreetBuilder(name: "Deks", shouldAskWellBeing: false)
        XCTAssertTrue(greetingsNoAsk == expectedNoAsk)
    }
    
    func testBuilderWithConditionalLogicIfElse() {
        let greetings = greetBuilder(name: "Deks", title: "iOS Developer")
        let expected = manualGreetBuilder(name: "Deks", title: "iOS Developer")
        
        XCTAssertTrue(greetings == expected)
        
        let greetingsNoTitle = greetBuilder(name: "Deks", title: "")
        let expectedNoTitle = manualGreetBuilder(name: "Deks", title: "")
        
        XCTAssertTrue(greetingsNoTitle == expectedNoTitle)
    }
    
    func testBuilderWithControlFlowSwitch() {
        let greetings1 = greetBuilder(name: "Deks", style: .yellowRed)
        let expected1 = manualGreetBuilder(name: "Deks", style: .yellowRed)
        XCTAssertTrue(greetings1 == expected1)
        
        let greetings2 = greetBuilder(name: "Deks", style: .orangeBlue)
        let expected2 = manualGreetBuilder(name: "Deks", style: .orangeBlue)
        XCTAssertTrue(greetings2 == expected2)
        
        let greetings3 = greetBuilder(name: "Deks", style: .bluePurple)
        let expected3 = manualGreetBuilder(name: "Deks", style: .bluePurple)
        XCTAssertTrue(greetings3 == expected3)
        
        let greetings4 = greetBuilder(name: "Deks", style: .yellowRed)
        let expected4 = manualGreetBuilder(name: "Deks", style: .bluePurple)
        XCTAssertFalse(greetings4 == expected4)
        
    }
    
    func testBuilderWithLoop() {
        let titles = [
            "iOS Developer",
            "Pineapple Drinker",
            "Panda Neck Pillow Wearer",
        ]
        
        let greetings = greetBuilder(name: "Deks", titles: titles)
        let expected = manualGreetBuilder(name: "Deks", titles: titles)
        XCTAssertTrue(greetings == expected)
    }
    
    func testBuilderWithDifferentExpression() {
        let titles = [
            "iOS Developer",
            "Pineapple Drinker",
            "Panda Neck Pillow Wearer",
        ]
        
        let greetings = greetBuilderV2(name: "Deks", titles: titles)
        let expected = manualGreetBuilderV2(name: "Deks", titles: titles)
        
        XCTAssertTrue(greetings == expected)
    }
    
    //
    
    enum GreetingStyle {
        case yellowRed
        case bluePurple
        case orangeBlue
    }
    
    // MARK: - Result builders
    
    @AttributedStringBuilder
    func greetBuilder(name: String, style: GreetingStyle) -> Text {
        
        switch style {
        case .yellowRed:
            Text("Hello ")
                .color(.yellow)
                .font(.systemFont(ofSize: 25))
            Text(name)
                .color(.red)
                .font(.systemFont(ofSize: 25))
            Text("!")
                .color(.yellow)
                .font(.systemFont(ofSize: 25))
        case .bluePurple:
            Text("Hello ")
                .color(.blue)
                .font(.systemFont(ofSize: 25))
            Text(name)
                .color(.purple)
                .font(.systemFont(ofSize: 25))
            Text("!")
                .color(.blue)
                .font(.systemFont(ofSize: 25))
        case .orangeBlue:
            Text("Hello ")
                .color(.orange)
                .font(.systemFont(ofSize: 25))
            Text(name)
                .color(.blue)
                .font(.systemFont(ofSize: 25))
            Text("!")
                .color(.orange)
                .font(.systemFont(ofSize: 25))
        }
    }
    
    @AttributedStringBuilder
    func greetBuilder(name: String) -> Text {
        Text("Hello ")
            .color(.yellow)
            .font(.systemFont(ofSize: 25))
        Text(name)
            .color(.red)
            .font(.systemFont(ofSize: 25))
        Text("!")
            .color(.yellow)
            .font(.systemFont(ofSize: 25))
    }
    
    @AttributedStringBuilder
    func greetBuilder(name: String, shouldAskWellBeing: Bool) -> Text {
        greetBuilder(name: name)
        
        if shouldAskWellBeing {
            Text(" How are you?")
                .color(.green)
                .font(.systemFont(ofSize: 25))
        }
    }
    
    @AttributedStringBuilder
    func greetBuilder(name: String, title: String) -> Text {
        greetBuilder(name: name)
        
        if !title.isEmpty {
            Text(" \(title)")
                .color(.blue)
                .font(.systemFont(ofSize: 25))
        } else {
            Text("No title")
                .color(.blue)
                .font(.systemFont(ofSize: 25))
        }
    }
    @AttributedStringBuilder
    func greetBuilder(name: String, titles: [String]) -> Text {
        greetBuilder(name: name)
        
        if !titles.isEmpty {
            for (index, title) in titles.enumerated() {
                if index != 0 {
                    Text(",")
                        .color(.blue)
                        .font(.systemFont(ofSize: 25))
                }
                Text(" ")
                    .color(.blue)
                    .font(.systemFont(ofSize: 25))
                Text(title)
                    .color(.blue)
                    .font(.systemFont(ofSize: 25))
            }
        }
    }
    
    // Expression aside from NSAttributedString
    
    @AttributedStringBuilder
    func greetBuilderV2(name: String, titles: [String]) -> Text {
        greetBuilder(name: name)
        
        if !titles.isEmpty {
            for title in titles {
                GreetSpecialCharacters.comma
                GreetSpecialCharacters.newLine
                Text(title)
                    .color(.blue)
                    .font(.systemFont(ofSize: 25))
            }
        }
    }
    
    // MARK: - Manual
    func manualGreetBuilder(name: String, style: GreetingStyle) -> NSMutableAttributedString {
        
        let greeting = NSMutableAttributedString()
        
        let color1: UIColor
        let color2: UIColor
        
        switch style {
        case .yellowRed:
            color1 = .yellow
            color2 = .red
        case .bluePurple:
            color1 = .blue
            color2 = .purple
        case .orangeBlue:
            color1 = .orange
            color2 = .blue
        }
        
        greeting.append(NSAttributedString(string: "Hello ", attributes: [
            NSAttributedString.Key.foregroundColor: color1,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
        ]))
        greeting.append(NSAttributedString(string: "Deks", attributes: [
            NSAttributedString.Key.foregroundColor: color2,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
        ]))
        greeting.append(NSAttributedString(string: "!", attributes: [
            NSAttributedString.Key.foregroundColor: color1,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
        ]))
        return greeting
    }
    
    func manualGreetBuilder(name: String) -> NSMutableAttributedString {
        let greeting = NSMutableAttributedString()
        greeting.append(NSAttributedString(string: "Hello ", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.yellow,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
        ]))
        greeting.append(NSAttributedString(string: "Deks", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.red,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
        ]))
        greeting.append(NSAttributedString(string: "!", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.yellow,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
        ]))
        return greeting
    }
    
    func manualGreetBuilder(name: String, shouldAskWellBeing: Bool) -> NSAttributedString {
        let greeting = manualGreetBuilder(name: name)
        
        if shouldAskWellBeing {
            greeting.append(NSAttributedString(string: " How are you?", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.green,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
            ]))
        }
        return greeting
    }
    
    func manualGreetBuilder(name: String, title: String) -> NSAttributedString {
        let greeting = manualGreetBuilder(name: name)
        if !title.isEmpty {
            greeting.append(NSAttributedString(string: " \(title)", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.blue,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
            ]))
        } else {
            greeting.append(NSAttributedString(string: "No title", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.blue,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
            ]))
        }
        
        return greeting
    }
    
    func manualGreetBuilder(name: String, titles: [String]) ->NSAttributedString {
        let greeting = manualGreetBuilder(name: name)
        
        var concatenatedTitles: String = ""
        
        if !titles.isEmpty {
            
            for (index, title) in titles.enumerated() {
                if index != 0 {
                    concatenatedTitles.append(",")
                }
                concatenatedTitles.append(" \(title)")
            }
        } else {
            concatenatedTitles = " No title"
        }
        
        greeting.append(NSAttributedString(string: concatenatedTitles, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
        ]))
        
        return greeting
    }
    
    func manualGreetBuilderV2(name: String, titles: [String]) -> Text {
        let greeting = manualGreetBuilder(name: name)
        
        var concatenatedTitles: String = ""
        
        if !titles.isEmpty {
            
            for title in titles {
                concatenatedTitles.append(",")
                concatenatedTitles.append("\n\(title)")
            }
        } else {
            concatenatedTitles = " No title"
        }
        
        greeting.append(NSAttributedString(string: concatenatedTitles, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
        ]))
        
        return greeting
    }
}
