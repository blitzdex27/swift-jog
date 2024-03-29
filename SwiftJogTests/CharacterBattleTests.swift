//
//  CharacterBattleTests.swift
//  SwiftJogTests
//
//  Created by Dexter Ramos on 7/25/23.
//

import XCTest
@testable import SwiftJog

final class CharacterBattleTests: XCTestCase {

    let regexElf = "Elf"
    let regexGiant =  "Giant"
    let regexWizard = "Wizard"
    
    let kStats_Elf = (hp: 3, atk: 10)
    let kStats_Wizard = (hp: 5, atk: 5)
    let kStats_Giant = (hp: 10, atk: 3)
    
    var elf = GameCharacterFactory.make(ofType: .elf)
    var wizard = GameCharacterFactory.make(ofType: .wizard)
    var giant = GameCharacterFactory.make(ofType: .giant)
    
    public override func setUp() {
        elf = GameCharacterFactory.make(ofType: .elf)
        wizard = GameCharacterFactory.make(ofType: .wizard)
        giant = GameCharacterFactory.make(ofType: .giant)
    }
    
    
    
    func testElf() throws {
        let elf = Elf()

        XCTAssert(elf.name.contains(regexElf))
        XCTAssert(!elf.name.contains(regexGiant))
        XCTAssert(!elf.name.contains(regexWizard))
        
        XCTAssert(elf.hitPoints == kStats_Elf.hp)
        XCTAssert(elf.attackPoints == kStats_Elf.atk)
    }
    
    func testWizard() throws {
        let wizard = Wizard()
        
        XCTAssert(!wizard.name.contains(regexElf))
        XCTAssert(!wizard.name.contains(regexGiant))
        XCTAssert(wizard.name.contains(regexWizard))
        
        XCTAssert(wizard.hitPoints == kStats_Wizard.hp)
        XCTAssert(wizard.attackPoints == kStats_Wizard.atk)
    }
    
    func testGiant() throws {
        let giant = Giant()
        
        XCTAssert(!giant.name.contains(regexElf))
        XCTAssert(giant.name.contains(regexGiant))
        XCTAssert(!giant.name.contains(regexWizard))
        
        XCTAssert(giant.hitPoints == kStats_Giant.hp)
        XCTAssert(giant.attackPoints == kStats_Giant.atk)
    }
    
    func testGameFactory() throws {
        let elfFromFactory = GameCharacterFactory.make(ofType: .elf)
        XCTAssert(elfFromFactory.name.contains(regexElf))
        XCTAssert(!elfFromFactory.name.contains(regexGiant))
        XCTAssert(!elfFromFactory.name.contains(regexWizard))
        
        XCTAssert(elfFromFactory.hitPoints == kStats_Elf.hp)
        XCTAssert(elfFromFactory.attackPoints == kStats_Elf.atk)
        
        let wizardFromFactory = GameCharacterFactory.make(ofType: .wizard)
        XCTAssert(!wizardFromFactory.name.contains(regexElf))
        XCTAssert(!wizardFromFactory.name.contains(regexGiant))
        XCTAssert(wizardFromFactory.name.contains(regexWizard))
        
        XCTAssert(wizardFromFactory.hitPoints == kStats_Wizard.hp)
        XCTAssert(wizardFromFactory.attackPoints == kStats_Wizard.atk)
        
        
        let giantFromFactory = GameCharacterFactory.make(ofType: .giant)
        XCTAssert(!giantFromFactory.name.contains(regexElf))
        XCTAssert(giantFromFactory.name.contains(regexGiant))
        XCTAssert(!giantFromFactory.name.contains(regexWizard))
        
        XCTAssert(giantFromFactory.hitPoints == kStats_Giant.hp)
        XCTAssert(giantFromFactory.attackPoints == kStats_Giant.atk)
    }
    
    func testStrikeElf() throws {
        let elf2 = GameCharacterFactory.make(ofType: .elf)
        
        XCTAssert(elf.strike(character: elf2) == true)
        XCTAssert(elf.strike(character: wizard) == true)
        XCTAssert(elf.strike(character: giant) == true)
    }
    
    func testStrikeWizard() throws {
        let wizard2 = GameCharacterFactory.make(ofType: .wizard)
        
        XCTAssert(wizard.strike(character: wizard2) == true)
        XCTAssert(wizard.strike(character: elf) == true)
        XCTAssert(wizard.strike(character: giant) == false)
    }
    
    func testStrikeGiant() throws {
        let giant2 = GameCharacterFactory.make(ofType: .giant)
        
        XCTAssert(giant.strike(character: giant2) == false)
        XCTAssert(giant.strike(character: elf) == true)
        XCTAssert(giant.strike(character: wizard) == false)
    }

}
