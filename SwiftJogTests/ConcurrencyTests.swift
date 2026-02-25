//
//  Concurrency.swift
//  SwiftJogTests
//
//  Created by Dexter Ramos on 9/4/23.
//

import XCTest
@testable import SwiftJog

final class Concurrency: XCTestCase {

    func testIterator() {
        
        let countdown = Countdown(count: 10)
        
        for count in countdown {
            print("xx-> count: \(count)")
        }
    }
    
    func testAsyncIterator() async {
        
        let foodOrders = FoodOrders(foodOrders: ["Burger", "Fries", "Spaghetti"])
        
        for await arrivedFood in foodOrders {
            print("Arrived food: \(arrivedFood)")
        }
    }
    
    func testTaskGroup() async {
        
        let strings = ["Burger", "Noodles", "Rice"]
        
        let someArrayOfStrings = await withTaskGroup(of: String.self, returning: [String].self, body: { taskGroup in
            
            for string in strings {
                taskGroup.addTask {
                    return await orderFood(string)
                }
            }
            
            var foods = [String]()
            for await food in taskGroup {
                foods.append(food)
            }
            
            
            
            return foods
        })
        
        print(someArrayOfStrings)
    }

}
