//
//  MemoryManagement.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 8/12/23.
//

import Foundation



/// testStrongReference
class Author {
    static var instanceCount: Int = 0
    deinit {
        Self.instanceCount -= 1
    }
    
    var name: String
    var book: Book?
    
    init(name: String, book: Book? = nil) {
        self.name = name
        self.book = book
        Self.instanceCount += 1
    }
}

class Book {
    static var instanceCount: Int = 0
    deinit {
        Self.instanceCount -= 1
    }
    
    let title: String
    var author: Author?
    
    init(title: String) {
        self.title = title
        Self.instanceCount += 1
    }
}

/// testWeakReference
class AuthorV2 {
    static var instanceCount: Int = 0
    deinit {
        Self.instanceCount -= 1
    }
    
    var name: String
    weak var book: Book?
    
    init(name: String) {
        self.name = name
        Self.instanceCount += 1
    }
}


class AuthorV3 {
    static var instanceCount: Int = 0
    deinit {
        Self.instanceCount -= 1
    }
    
    typealias WriteClosure = () -> Void
    var writeClosure: WriteClosure?
    
    var name: String
    init(name: String) {
        self.name = name
        Self.instanceCount += 1
    }
}

class AuthorV4 {
    static var instanceCount: Int = 0
    deinit {
        Self.instanceCount -= 1
    }
    
    var name: String
    init(name: String) {
        self.name = name
        Self.instanceCount += 1
    }
}
