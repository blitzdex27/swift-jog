//
//  Strideable.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 8/6/23.
//

import Foundation

typealias StudentClosedRange<Bound> = ClosedRange<Bound> where Bound: Strideable, Bound.Stride == Int
typealias StudentRange<Bound> = Range<Bound> where Bound: Strideable, Bound.Stride == Int

enum StudentClassification {
    case junior
    case senior
}
struct Student {
    private static var students = [Student]()
    
    let id: Int
    let name: String
    let classification: StudentClassification
    
    
    init(name: String, classification: StudentClassification) {
        self.id = Self.students.count + 1
        self.name = name
        self.classification = classification
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
        let id = self.id + n
        
        let student = Self.students.filter { p in
            p.id == id
        }
        return student[0]
    }
}
