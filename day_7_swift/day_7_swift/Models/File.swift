//
//  File.swift
//  day_7_swift
//
//  Created by Matthew Dutton on 12/8/22.
//

import Foundation

struct File: Entity {
    let type = EntityType.file
    let name: String
    let size: Double
}

extension File: Hashable {
    static func == (lhs: File, rhs: File) -> Bool {
        return lhs.name == rhs.name && lhs.size == rhs.size
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(name)
        hasher.combine(size)
    }
}
