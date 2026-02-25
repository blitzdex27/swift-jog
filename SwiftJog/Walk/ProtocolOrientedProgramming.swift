//
//  ProtocolOrientedProgramming.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 9/2/23.
//

import Foundation

protocol Product {
    init()
}

protocol ProductionLine {
    associatedtype ProductType: Product
    
    func produce() -> ProductType
}

protocol Factory {
    associatedtype ProductType: Product
    
    func produce() -> [ProductType]
}

protocol Warehouse {
    associatedtype ProductType: Product
    
    var storage: [ProductType] { get set }
    
    mutating func store(products: [ProductType])
}

extension Warehouse {
    mutating func store(product: ProductType) {
        storage.append(product)
    }
}

struct GenericProductionLine<P: Product>: ProductionLine {

    func produce() -> P { .init() }
    
}

struct GenericFactory<P: Product>: Factory {

    
    var productionLines: [GenericProductionLine<P>] = []
    
    func produce() -> [P] {
        productionLines.map { $0.produce() }
    }
    
    mutating func increaseProductionLines(increment: Int = 1) {
        for _ in 0..<increment {
            productionLines.append(.init())
        }
    }
}

struct GenericWarehouse<P: Product>: Warehouse {
    var storage: [P] = []
    
    mutating func store(products: [P]) {
        storage.append(contentsOf: products)
    }
}

struct Car: Product {
    
    init() {
        print("Finished producing incredible 🚘.")
    }
    
}

// MARK: - Type erasure

protocol Pet {
    associatedtype Food
    func eat(_ food: Food)
}

extension Pet {
    func eraseToAnyPet() -> AnyPet<Food> {
        .init(self)
    }
}

enum PetFood { case dry, wet }

struct Cat: Pet {
    func eat(_ food: PetFood) {
        print("Eating cat food.")
    }
}

struct Dog: Pet {
    func eat(_ food: PetFood) {
        print("Eating dog food.")
    }
}


struct AnyPet<Food>: Pet {
    private let _eat: (_ food: Food) -> Void
    
    init<SomePet: Pet>(_ pet: SomePet) where SomePet.Food == Food {
        _eat = pet.eat(_:)
    }
    
    func eat(_ food: Food) {
        _eat(food)
    }
}
let anyPets = [AnyPet(Dog()), AnyPet(Cat())]

func makeValue() -> some FixedWidthInteger {
    return 42
}


// MARK: - Robot vehicle builder

protocol VehicleToy {
    var price: Double { get set }
    
    static var pieceCount: Int { get }
    
    init()
}

protocol VehicleToyBuilderRobot {
    
    associatedtype VehicleToyType: VehicleToy
    
    /// Pieces / minute
    var assemblySpeed: Double { get set }
    
    /// in minutes
    func build(duration: Double) -> [VehicleToyType]
    
    func build(count: Int) -> [VehicleToyType]
    
}

extension VehicleToyBuilderRobot {
    func build(duration: Double) -> [VehicleToyType] {
        let numberOfToys = Int(assemblySpeed * duration) / VehicleToyType.pieceCount

        var toys = [VehicleToyType]()
        for _ in 0..<numberOfToys {
            toys.append(.init())
        }
        return toys
    }
    
    func build(count: Int) -> [VehicleToyType] {
        let durationNeeded = Double(count * VehicleToyType.pieceCount) / assemblySpeed
        print("Duration to complete: \(durationNeeded) minutes")
        return build(duration: durationNeeded)
    }
}

struct CarToy: VehicleToy {
    var price: Double = 10
    static let pieceCount: Int = 5
}

struct TruckToy: VehicleToy {
    var price: Double = 20
    static let pieceCount: Int = 10
}

struct GenericVehicleToyBuilderRobot<ToyType: VehicleToy>: VehicleToyBuilderRobot {
    typealias VehicleToyType = ToyType
    
    var assemblySpeed: Double
    
}


// Challenge 2
struct TrainToy: VehicleToy {
    var price: Double = 100
    static let pieceCount: Int = 75
}

struct ToyTrainBuilderRobot: VehicleToyBuilderRobot {
    typealias VehicleToyType = TrainToy
    
    var assemblySpeed: Double = 500
    
}

func makeToyBuilderRobot() -> some VehicleToyBuilderRobot {
    return ToyTrainBuilderRobot()
}

// Challenge 3

struct MonsterTruckToy: VehicleToy {
    var price: Double = 100
    static let pieceCount: Int = 120
}

struct ToyMonsterBuilderRobot: VehicleToyBuilderRobot {
    typealias VehicleToyType = TrainToy
    
    var assemblySpeed: Double = 200
    
}
