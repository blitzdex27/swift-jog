//
//  CharacterBattle.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 7/25/23.
//

/*:
 Utilize something called a static factory method to create a game of Wizards vs. Elves vs. Giants.
 
 Add a file Characters.swift in the Sources folder of your playground.
 
 ## To begin:
 - Create an enum GameCharacterType that defines values for elf, giant and wizard.
 - Create a protocol GameCharacter that inherits from AnyObject and has properties name, hitPoints and attackPoints. Implement this protocol for every character type.
 - Create a struct GameCharacterFactory with a single static method `make(ofType: GameCharacterType) -> GameCharacter`.
 - Create a global function battle that pits two characters against each other — with the first character striking first! If a character reaches 0 hit points, they have lost.
 ## Hints:
 - The playground should not be able to see the concrete types that implement
 GameCharacter.
 - Elves have 3 hit points and 10 attack points. Wizards have 5 hit points and 5 attack
 points. Giants have 10 hit points and 3 attack points.
 - The playground should know none of the above!
 
 Reference: Swift Apprentice
 */

import Foundation

enum GameCharacterType {
    case elf
    case giant
    case wizard
}

protocol GameCharacter: AnyObject {
    var name: String { get }
    var hitPoints: Int { get set }
    var attackPoints: Int { get }
    
    func strike(character: GameCharacter) -> Bool
}

extension GameCharacter {
    func strike(character: GameCharacter) -> Bool {
        character.hitPoints -= self.attackPoints
        if character.hitPoints <= 0 {
            return true
        }
        return false
    }
}

struct GameCharacterFactory {
    static func make(ofType: GameCharacterType) -> GameCharacter {
        let characterType = ofType
        switch characterType {
        case .elf:
            return Elf()
        case .giant:
            return Giant()
        case .wizard:
            return Wizard()
        }
    }
}

class Elf: GameCharacter {
    var name: String = "Elf\(UUID().uuidString)"
    var hitPoints: Int = 3
    var attackPoints: Int = 10
}

class Giant: GameCharacter {
    var name: String = "Giant\(UUID().uuidString)"
    var hitPoints: Int = 10
    var attackPoints: Int = 3
}

class Wizard: GameCharacter {
    var name: String = "Wizard\(UUID().uuidString)"
    var hitPoints: Int = 5
    var attackPoints: Int = 5
}

func battle(_ character1: GameCharacter, vs character2: GameCharacter) {
    
    var striker1 = character1
    var striker2 = character2
    
    
    while true {
        let didWin = striker1.strike(character: striker2)
        
        if didWin == true {
            print("\(striker2.name) defeated!")
            break
        }
        
        // swap striker
        let temp = striker1
        striker1 = striker2
        striker2 = temp
    }
}


