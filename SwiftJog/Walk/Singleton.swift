//
//  Logger.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 7/25/23.
//

import Foundation

class Logger {
    let id = UUID().uuidString
    static let shared = Logger()
    private init() {}
    
    func log() -> String {
        return id
    }
}

extension Logger: Equatable {
    static func == (lhs: Logger, rhs: Logger) -> Bool {
        return lhs.id == rhs.id
    }

}
