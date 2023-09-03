//
//  ProtocolOrientedProgramming.swift
//  SwiftJogTests
//
//  Created by Dexter Ramos on 9/2/23.
//

import XCTest
@testable import SwiftJog

final class ProtocolOrientedProgramming: XCTestCase {

    func testSimple() {
        var carFactory = GenericFactory<Car>()
        
        carFactory.productionLines.append(GenericProductionLine<Car>())
        carFactory.productionLines.append(GenericProductionLine<Car>())
        
        carFactory.increaseProductionLines()
        carFactory.increaseProductionLines()
        carFactory.increaseProductionLines(increment: 5)
        
        let carProducts = carFactory.produce()

        XCTAssertTrue(carProducts.count == 9)
        
        var warehouse = GenericWarehouse<Car>()
        warehouse.store(products: carProducts)
        XCTAssertTrue(warehouse.storage.count == 9)
    }
    
    /// type erasure hide unimportant details about conrete type but still communicate the type's functionality a protocol
    func testTypeErasure() {

        let anyPets = [AnyPet(Dog()), AnyPet(Cat())]
        
        let anyPets2 = [Dog().eraseToAnyPet(), Cat().eraseToAnyPet()]
    }
    
    /// Using protocols, define a robot that makes vehicle toys.
    /// - Each robot can assemble a different number of pieces per minute. For example, Robot-A can assemble ten pieces per minute, while Robot-B can assemble five.
    /// - Each robot type is only able to build a single type of toy.
    /// - Each toy type has a price value.
    /// - Each toy type has a different number of pieces. You tell the robot how long it should operate, and it will provide the finished toys.
    /// - Add a method to tell the robot how many toys to build. It will build them and say how much time it needed.
    func testRobotVehicleBuilder() {

        // robot a
        
        let robotA = GenericVehicleToyBuilderRobot<CarToy>(assemblySpeed: 3)

        let setAcarToys = robotA.build(duration: 15)
        
        let robotAExpectedCount = 15 * 3 / CarToy.pieceCount
        XCTAssertTrue(setAcarToys.count == robotAExpectedCount)
        
        let setBcarToys = robotA.build(count: 40)
        XCTAssertTrue(setBcarToys.count == 40)
        
        // robot b
        
        let robotB = GenericVehicleToyBuilderRobot<TruckToy>(assemblySpeed: 6)
        
        let setATruckToys = robotB.build(duration: 30)
        
        let robotBExpectedCount = 30 * 6 / TruckToy.pieceCount
        XCTAssertTrue(setATruckToys.count == robotBExpectedCount)
        
        let setBTruckToys = robotB.build(count: 100)
        XCTAssertTrue(setBTruckToys.count == 100)
        
    } /// Reference: Swift Apprentice (raywenderlich.com) chapter 28 Advanced Protocols & Generics, page 532
}
