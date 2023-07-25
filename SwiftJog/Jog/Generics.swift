//
//  Generics.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 7/25/23.
//

import Foundation

func getSumOf<T: Numeric>(_ num1: T, _ num2: T) -> T {
    return num1 + num2
}

protocol Shape {}

struct Rectangle: Shape {
    let width: Int
    let length: Int
}

struct Square: Shape {
    let width: Int
}

struct ShapeStorage<T: Shape> {
    var container: [T] = []
    
    mutating func push(shape: T) {
        container.append(shape)
    }
}
