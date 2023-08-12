//
//  ErrorHandling.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 8/12/23.
//

import Foundation

protocol Storage {
    var storage: [String] { get }
    func store(_ item: String) throws
}

/// testSimpleErrorHandling
enum AppleStorageError: Error {
    case notAnApple
}

class AppleStorage: Storage {

    private(set) var storage: [String] = []
    
    func store(_ item: String) throws {
        guard item == "apple" else {
            throw AppleStorageError.notAnApple
        }

        storage.append(item)
    }
}

/// testErrorWithAssociativeData
enum BananaStorageError: Error {
    case notABanana(item: String)
}
class BananaStorage: Storage {
    private(set) var storage: [String] = []
    
    func store(_ item: String) throws {
        guard item == "banana" else {
            throw BananaStorageError.notABanana(item: item)
        }
        storage.append(item)
    }
}

/// testErrorWithParameter
enum MangoStorageError: Error {
    case notAMango
    case noMangoAvailable
    case dirtyMango(reason: String)
}

class MangoStorage: Storage {
    private(set) var storage: [String] = []
    
    func store(_ item: String) throws {
        guard item == "mango" else {
            throw MangoStorageError.notAMango
        }
        storage.append(item)
    }
    
    var isEmpty: Bool {
        return storage.isEmpty
    }
    
    /// testErrorWithParameter
    var latestMango: String? {
        get throws {
            guard !isEmpty else {
                throw MangoStorageError.noMangoAvailable
            }
            return storage.popLast()
        }
    }
    
    func peelAMango(using peeler: String, completion: (_ peeledMango: String) throws -> Void) rethrows {
        if peeler.hasPrefix("teeth") {
            try completion("bitten-peeled-mango")
        } else {
            try completion("peeled-mango")
        }
    }
}
