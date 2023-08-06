//
//  Strideable.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 8/6/23.
//

import Foundation

struct Student {
    static var students = [Student]()
    
    let name: String
    let id: Int

    
    init(name: String) {
        self.name = name
        self.id = Self.students.count + 1
        Self.students.append(self)
    }

}

extension Student: Equatable, Comparable {
    static func < (lhs: Student, rhs: Student) -> Bool {
        return lhs.id < rhs.id
    }
    
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Student: Strideable {
    typealias Stride = Int
    
    func distance(to other: Student) -> Int {
        other.id - self.id
    }
    
    func advanced(by n: Int) -> Student {
        print("\(n)")
        let id = self.id + n
        
        let student = Self.students.filter { p in
            p.id == id
        }
        return student[0]
    }
}
