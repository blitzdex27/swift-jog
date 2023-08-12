//
//  ErrorHandlingTests.swift
//  SwiftJogTests
//
//  Created by Dexter Ramos on 8/12/23.
//

import XCTest
@testable import SwiftJog

final class ErrorHandlingTests: XCTestCase {

    func testSimpleErrorHandling() {
        
        let appleStorage = AppleStorage()
        
        do {
            try appleStorage.store("apple")
            try appleStorage.store("banana")
        } catch AppleStorageError.notAnApple {
            print("Only apples are allowed to be stored in AppleStorage")
            return
        } catch {
            print("Unexpected error")
            XCTFail()
        }
        XCTFail()

    }
    
    func testErrorWithAssociativeData() {
        let bananaStorage = BananaStorage()
        
        do {
            try bananaStorage.store("banana")
            try bananaStorage.store("apple")
        } catch BananaStorageError.notABanana(let receivedThingy) {
            print("'\(receivedThingy)' cannot be stored in BananaStorage")
            return
        } catch {
            print("Unexpected error")
            XCTFail()
        }
        XCTFail()
    }
    
    func testErrorWithParameter() {
        let mangoStorage = MangoStorage()
        
        do {
            precondition(mangoStorage.isEmpty)
            if let mango = try mangoStorage.latestMango {
                print("Wow a \(mango), thanks!")
            }
        } catch MangoStorageError.noMangoAvailable {
            print("No mango available in the storage")
            return
        } catch {
            print("Unexpected error")
            XCTFail()
        }
        XCTFail()
    }
    
    func testErrorWithRethrows() {
        let mangoStorage = MangoStorage()

        
        do {
            precondition(mangoStorage.isEmpty)

            try mangoStorage.peelAMango(using: "teeth") { peeledMango in
                guard !peeledMango.hasPrefix("bitten") else {
                    throw MangoStorageError.dirtyMango(reason: "bitten")
                }
                print("Thanks for the '\(peeledMango)'!")
            }
        } catch MangoStorageError.dirtyMango(let reason) {
            print("The mango is dirty! Reason: '\(reason)'")
            return
        } catch {
            print("Unexpected error")
            XCTFail()
        }
        XCTFail()
    }
}
