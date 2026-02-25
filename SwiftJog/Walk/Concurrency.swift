//
//  Concurrency.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 9/4/23.
//

import Foundation

struct Countdown: Sequence {
    let count: Int
    
    func makeIterator() -> CountdownIterator {
        .init(count: count)
    }
}

struct CountdownIterator: IteratorProtocol {
    
    var count: Int
    
    
    typealias Element = Int
    
    mutating func next() -> Int? {
        print("xx-> \(count)")
        guard count >= 0 else {
            return nil
        }
        let count = self.count
        self.count -= 1
        return count
    }
}

func orderFood(_ food: String) async -> String {
    print("Ordering \(food) initiated...")
    try? await Task.sleep(for: .seconds(3))
    print("Ordered food, \(food), arrived!")
    return food
}

struct FoodOrders: AsyncSequence {
    typealias AsyncIterator = FoodOrdersIterator
    
    typealias Element = String
    
    let foodOrders: [String]
    
    func makeAsyncIterator() -> FoodOrdersIterator {
        FoodOrdersIterator(foodOrders: foodOrders)
    }
}

struct FoodOrdersIterator: AsyncIteratorProtocol {
    let foodOrders: [String]
    var index: Int = 0
    
    mutating func next() async -> String? {
        if foodOrders.indices.contains(index) {
            let arrivedFood = await orderFood(foodOrders[index])
            index += 1
            return arrivedFood
        }
        return nil
    }
}
