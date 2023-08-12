//
//  MemoryManagementTests.swift
//  SwiftJogTests
//
//  Created by Dexter Ramos on 8/12/23.
//

import XCTest
@testable import SwiftJog

/// When reference count of an instance reaches 0, it will be deinitialized automatically
///
final class MemoryManagementTests: XCTestCase {
    
    override class func setUp() {
        Author.instanceCount = 0
        Book.instanceCount = 0
        AuthorV2.instanceCount = 0
        AuthorV3.instanceCount = 0
    }

    func testStrongReference() {
        do {
            let author: Author
            var book: Book?
            
            do {
                author = Author(name: "Dexter"); precondition(Author.instanceCount == 1)
                precondition(Author.instanceCount == 1)
                book = Book(title: "Swift basics") /// reference counts: Author(name: "Dexter")=1; Book(title: "Swift basics")=1
                precondition(Book.instanceCount == 1)
                
                author.book = book /// reference counts: Author(name: "Dexter")=1; Book(title: "Swift basics")=2
                book = nil /// reference counts: Author(name: "Dexter")=1; Book(title: "Swift basics")=1
            }
            
            /// The author.book property **should not be nil** since it has a *strong reference attribute*
            XCTAssertTrue(author.book != nil)
            XCTAssertTrue(Author.instanceCount == 1)
            XCTAssertTrue(Book.instanceCount == 1)
        }
        
        XCTAssertTrue(Author.instanceCount == 0)
        XCTAssertTrue(Book.instanceCount == 0)
    }
    
    
    func testWeakReference() {
        do {
            let author: AuthorV2
            var book: Book?
            do {
                author = AuthorV2(name: "Dexter") /// reference counts: AuthorV2(name: "Dexter")=1; Book(title: "Swift basics")=0
                precondition(AuthorV2.instanceCount == 1)
                book = Book(title: "Swift basics") /// reference counts: AuthorV2(name: "Dexter")=1; Book(title: "Swift basics")=1
                precondition(Book.instanceCount == 1)
                
                author.book = book /// reference counts: AuthorV2(name: "Dexter")=1; Book(title: "Swift basics")=1
                book = nil /// reference counts: AuthorV2(name: "Dexter")=1; Book(title: "Swift basics")=0
            }
            /// reference counts: AuthorV2(name: "Dexter")=1; Book(title: "Swift basics")=0
            
            /// The author.book property **should be nil** since it has a *weak reference attribute*
            XCTAssertTrue(author.book == nil)
            XCTAssertTrue(AuthorV2.instanceCount == 1)
            XCTAssertTrue(Book.instanceCount == 0)
        }
        
        /// reference counts: AuthorV2(name: "Dexter")=0; Book(title: "Swift basics")=0
        XCTAssertTrue(AuthorV2.instanceCount == 0)
        XCTAssertTrue(Book.instanceCount == 0)
        
    }
    
    
    func testCycleReference() {
        var author: Author?
        var book: Book?
        
        do {
            author = Author(name: "Dexter") /// reference counts: Authorname: "Dexter")=1; Book(title: "Swift basics")=0
            precondition(Author.instanceCount == 1)
            book = Book(title: "Swift basics") /// reference counts: Authorname: "Dexter")=1; Book(title: "Swift basics")=1
            precondition(Book.instanceCount == 1)
            
            author?.book = book /// reference counts: Authorname: "Dexter")=1; Book(title: "Swift basics")=2
            book?.author = author /// reference counts: Authorname: "Dexter")=2; Book(title: "Swift basics")=2
            
            author?.book = nil /// reference counts: Authorname: "Dexter")=2; Book(title: "Swift basics")=1
            book?.author = nil /// reference counts: Authorname: "Dexter")=1; Book(title: "Swift basics")=1
        }
        /// reference counts: Authorname: "Dexter")=1; Book(title: "Swift basics")=1
        
        XCTAssertTrue(author?.book == nil)
        XCTAssertTrue(book?.author == nil)
        
        /// MEMORY LEAK!
        /// Even though we cannot access the instances of `Author(name: "Dexter")` and `Book(title: "Swift basics")` that we created earlier using the `book.author` and `author.book`, the instances were in the memory, and we have no way to access or destroy them now.
        XCTAssertTrue(Author.instanceCount == 1)
        XCTAssertTrue(Book.instanceCount == 1)
    }
    
    // MARK: - Closures
    
    func testClosureStrongReference() {
        do {
            var author = AuthorV3(name: "Dexter") /// RefCounts: AuthorV3(name: "Dexter")=1
            precondition(AuthorV3.instanceCount == 1)
            do {
                var book = Book(title: "Swift basics")
                precondition(Book.instanceCount == 1) /// RefCounts: AuthorV3(name: "Dexter")=1; Book(title: "Swift basics")=1
                
                author.writeClosure = {
                    print(book.title) /// RefCounts: AuthorV3(name: "Dexter")=1; Book(title: "Swift basics")=2
                }
            }
            /// RefCounts: AuthorV3(name: "Dexter")=1; Book(title: "Swift basics")=1
            
            XCTAssertTrue(AuthorV3.instanceCount == 1)
            /// Now, even though the book variable is out of scope, which was holding the `Book(title: "Swift basics")` instance,
            /// the **closure** held a strong reference to this instance
            /// And that closure is owned by the `AuthorV3(name: "Dexter")` instance, which still exists
            XCTAssertTrue(Book.instanceCount == 1)
        }
        /// RefCounts: AuthorV3(name: "Dexter")=0; Book(title: "Swift basics")=0
        ///
        /// `author` variable was out of scope now and so the reference count of the instance it holds will decrease
        /// Once the instance `AuthorV3(name: "Dexter")` goes to zero, it will be destroyed
        /// Also, since the *closure*, `{ print(book.title) }`  is owned by this instance, it will also be destroyed
        /// This closure owns the `Book(title: "Swift basics")` so it will be destroyed with it
        
        XCTAssertTrue(AuthorV3.instanceCount == 0)
        XCTAssertTrue(Book.instanceCount == 0)
    }
    
    func testClosureWeakRerence() {
        do {
            let author = AuthorV3(name: "Dexter") /// RefCounts: AuthorV3(name: "Dexter")=1
            precondition(AuthorV3.instanceCount == 1)
            do {
                let book = Book(title: "Swift basics")
                precondition(Book.instanceCount == 1) /// RefCounts: AuthorV3(name: "Dexter")=1; Book(title: "Swift basics")=1
                
                /// using capture list, we can capture the `book` variable weakly
                author.writeClosure = { [weak book] in
                    print(book?.title ?? "") /// RefCounts: AuthorV3(name: "Dexter")=1; Book(title: "Swift basics")=1
                }
            }
            /// RefCounts: AuthorV3(name: "Dexter")=1; Book(title: "Swift basics")=0
            
            XCTAssertTrue(AuthorV3.instanceCount == 1)
            XCTAssertTrue(Book.instanceCount == 0)
        }
        XCTAssertTrue(AuthorV3.instanceCount == 0)
        XCTAssertTrue(Book.instanceCount == 0)
    }
    
    func testClosureCycleReference() {
        do {
            let author = AuthorV3(name: "Dexter") /// RefCounts: AuthorV3(name: "Dexter")=1
            precondition(AuthorV3.instanceCount == 1)
            do {
                author.writeClosure = {
                    print(author.name) /// RefCounts: AuthorV3(name: "Dexter")=2
                }
            }
            /// RefCounts: AuthorV3(name: "Dexter")=2
            
            XCTAssertTrue(AuthorV3.instanceCount == 1)
        }
        /// RefCounts: AuthorV3(name: "Dexter")=1
        /// **MEMORY LEAK!**
        ///
        /// since `author` is now out of scope, we cannot access it and the instance it holds
        /// this instance is being owned by closure, and the closure is owned by the instance
        /// and we call it cycle reference
        /// They now become something that cannot be access nor destroyed!
        XCTAssertTrue(AuthorV3.instanceCount == 1)
        /// **Note:**
        /// If you are coding inside a class, *accessing* the property of that class or by calling *self* inside the closure will introduce cycle reference. That is, if the closure is also a property of the that class
        /// This is only one of the possible situation. Just keep tract of the reference count if you want to check for a possible reference cycle
        
    }
    
    func testClosureAvoidCycleReference() {
        do {
            let author = AuthorV3(name: "Dexter") /// RefCounts: AuthorV3(name: "Dexter")=1
            precondition(AuthorV3.instanceCount == 1)
            do {
                author.writeClosure = { [weak author] in
                    print(author?.name ?? "") /// RefCounts: AuthorV3(name: "Dexter")=1
                }
            }
            /// RefCounts: AuthorV3(name: "Dexter")=2
            
            XCTAssertTrue(AuthorV3.instanceCount == 1)
        }

        XCTAssertTrue(AuthorV3.instanceCount == 0)
    }
    
    func testClosureWeakStrongDance() {
        let expectAuthorInstanceExists = expectation(description: "Expect author instance exists")
        let expectAuthorInstanceDestroyed = expectation(description: "Expect author instance destroyed")
        
        do {
            let author = AuthorV3(name: "Dexter") /// RefCount: AuthorV3(name: "Dexter")=1
            precondition(AuthorV3.instanceCount == 1)
            
            /// The author instance will not be destroyed until all strongAuthor accesses are executed in this closure
            author.writeClosure = { [weak author] in
                guard let strongAuthor = author else { return } /// RefCount: AuthorV3(name: "Dexter")=2

                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: DispatchWorkItem(block: {

                    expectAuthorInstanceExists.fulfill()
                    print("\(strongAuthor) instance is still alive!)")
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: DispatchWorkItem(block: {
                        
                        print("\(strongAuthor) instance will be destroyed after this line of code!)")
                        /// RefCount: AuthorV3(name: "Dexter")=0
                        expectAuthorInstanceDestroyed.fulfill()
                    }))
                }))
                
                
            }
            
            author.writeClosure?()
        }
        /// RefCount: AuthorV3(name: "Dexter")=1
        XCTAssertTrue(AuthorV3.instanceCount == 1)
        
        wait(for: [expectAuthorInstanceExists], timeout: 10)
        XCTAssertTrue(AuthorV3.instanceCount == 1)
        wait(for: [expectAuthorInstanceDestroyed], timeout: 10)
        XCTAssertTrue(AuthorV3.instanceCount == 0)
        
        /// What happens here?
        ///
        /// - `author` is holding `AuthorV3(name: "Dexter")` instance strongly
        /// - `weak author` is holding the `AuthorV3(name: "Dexter")` instance weakly
        /// - `strongAuthor` is holding the `AuthorV3(name: "Dexter")` instance strongly
        ///
        /// With that, shouldn't the closure owns the instance by now?
        /// YES
        ///
        /// - if the variable is a struct, it will copy the value
        /// - if the variable is a class, it will copy the reference
    }
}


