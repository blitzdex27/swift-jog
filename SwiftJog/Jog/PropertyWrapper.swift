//
//  PropertyWrapper.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 9/2/23.
//

import Foundation

@propertyWrapper
struct ZeroToOne {
    var value: Int
    
    init(wrappedValue: Int) {
        value = wrappedValue
    }
    
    var wrappedValue: Int {
        get {
            return max(0, min(1, value))
        }
        set {
            value = newValue
        }
    }
}

@propertyWrapper
struct ZeroToTwo<T> where T: Numeric, T: Comparable {
    var value: T
    
    init(wrappedValue: T) {
        value = wrappedValue
    }
    
    var wrappedValue: T {
        get {
            return max(0, min(2, value))
        }
        set {
            value = newValue
        }
    }
    
}

@propertyWrapper
struct ZeroToX {
    var value: Int
    var max: Int
    
    init(wrappedValue: Int, max: Int) {
        value = wrappedValue
        self.max = max
    }
    
    var wrappedValue: Int {
        get {
            Swift.max(0, min(max, value))
        }
        set {
            value = newValue
        }
    }
    
}

@propertyWrapper
struct ZeroToThree {
    var value: Int
    
    init(wrappedValue: Int) {
        value = wrappedValue
    }
    
    var wrappedValue: Int {
        get {
            Swift.max(0, min(3, value))
        }
        set {
            value = newValue
        }
    }
    
    var projectedValue: Int {
        get { value }
    }
}

@propertyWrapper
struct ZeroToY {
    var value: Int
    var modifiers: (min: Int, max: Int)
    
    init(wrappedValue: Int, max: Int) {
        value = wrappedValue
        modifiers = (0, max)
    }
    
    var wrappedValue: Int {
        get {
            Swift.max(modifiers.min, min(modifiers.max, value))
        }
        set {
            value = newValue
        }
    }
    
    var projectedValue: (min: Int, max: Int) {
        get {
            return modifiers
        }
        set {
            modifiers = newValue
        }
    }
    
}

@propertyWrapper
struct ValidatedDate {
    var storage: Date? = nil
    var formatter = DateFormatter()
    
    init(wrappedValue: String, format: String = "yyyy-mm-dd") {
        formatter.dateFormat = format
        storage = formatter.date(from: wrappedValue)
    }
    
    var wrappedValue: String {
        get {
            if let date = storage {
                return formatter.string(from: date)
            } else {
                return "Invalid date"
            }
        }
        set {
            storage = formatter.date(from: newValue)
        }
    }
    
    var projectedValue: DateFormatter {
        get {
            return formatter
        }
        set {
            formatter = newValue
        }
    }
}
