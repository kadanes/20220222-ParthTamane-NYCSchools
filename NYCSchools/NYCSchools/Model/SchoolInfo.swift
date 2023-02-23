//
//  SchoolInfo.swift
//  NYCSchools
//
//  Created by Parth Tamane on 23/02/23.
//

import Foundation

struct SchoolInfo: Hashable {
    let dbn: String
    let school_name: String
    let phone_number: String
}

extension SchoolInfo: Codable {
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(SchoolInfo.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
}
