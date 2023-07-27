//
//  ResultBuilder.swift
//  Swift-jog2
//
//  Created by Dexter Ramos on 7/27/23.
//

import Foundation
import UIKit

typealias Text = NSMutableAttributedString

extension Text {
    func color(_ color: UIColor) -> Text {
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: 0, length: self.length))
        return self
    }
    func font(_ font: UIFont) -> Text {
        self.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: self.length))
        return self
    }
}

extension Text {
    convenience init(_ string: String) {
        self.init(string: string)
    }
}

enum GreetSpecialCharacters {
    case newLine
    case comma
}

@resultBuilder
enum AttributedStringBuilder {
    static func buildOptional(_ component: Text?) -> Text {
        return component ?? Text()
    }
    
    static func buildEither(first component: Text) -> Text {
        return component
    }
    
    static func buildEither(second component: Text) -> Text {
        return component
    }
    
    static func buildArray(_ components: [Text]) -> Text {
        let attributtedString = Text()
        for component in components {
            attributtedString.append(component)
        }
        return attributtedString
    }
    
    static func buildExpression(_ expression: GreetSpecialCharacters) -> Text {
        switch expression {
        case .newLine:
            return Text("\n")
                .color(.blue)
                .font(.systemFont(ofSize: 25))
        case .comma:
            return Text(",")
                .color(.blue)
                .font(.systemFont(ofSize: 25))
        }
    }
    
    static func buildExpression(_ expression: Text) -> Text {
        expression
    }
    
 
    static func buildBlock(_ components: Text...) -> Text {
        let attributtedString = Text()
        for component in components {
            attributtedString.append(component)
        }
        return attributtedString
    }
}




