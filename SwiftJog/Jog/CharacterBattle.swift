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

