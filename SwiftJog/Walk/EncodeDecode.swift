//
//  EncodeDecode.swift
//  SwiftJog
//
//  Created by Dexter Ramos on 8/8/23.
//

import Foundation

struct Employee: Codable {
    var name: String
    var department: String
    var profile: Profile?
}

struct Profile: Codable {
    var language: String
    
    enum CodingKeys: CodingKey {
        case language
    }
}

struct EmployeeV2: Codable {
    var name: String
    var department: String
    var profile: Profile?
    
    enum CodingKeys: String, CodingKey {
        case name = "first_name"
        case department
        case profile
    }
}

struct EmployeeV3 {
    var name: String
    var department: String
    var profile: Profile?
    
    enum CodingKeys: String, CodingKey {
        case name
        case department
        case profile
    }
}

extension EmployeeV3: Encodable {
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(name, forKey: .name)
        try values.encode(department, forKey: .department)
        try values.encodeIfPresent(profile?.language, forKey: .profile)
    }
}

extension EmployeeV3: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        department = try values.decode(String.self, forKey: .department)

        if let language = try values.decodeIfPresent(String.self, forKey: .profile) {
            
            profile = Profile(language: language)
        }
    }
}
