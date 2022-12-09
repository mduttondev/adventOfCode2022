//
//  Directory.swift
//  day_7_swift
//
//  Created by Matthew Dutton on 12/8/22.
//

import Foundation

class Directory: Entity {
    let type = EntityType.directory
    let name: String

    weak var parent: Directory?

    var files = [File]()
    var childDirectories = [Directory]()

    func getSize() -> Double {
        if childDirectories.isEmpty {
            return sizeForFiles
        }

        var childDirectoriesSize: Double = 0
        for childDirectory in childDirectories {
            childDirectoriesSize += childDirectory.getSize()
        }

        return childDirectoriesSize + sizeForFiles
    }

    private var sizeForFiles: Double {
        var size: Double = 0
        for file in files {
            size += file.size
        }
        return size
    }

    init(name: String, parent: Directory?, files: [File] = [File](), childDirectories: [Directory] = [Directory]()) {
        self.name = name
        self.files = files
        self.parent = parent
        self.childDirectories = childDirectories
    }
}

extension Directory: Hashable, Equatable {
    static func == (lhs: Directory, rhs: Directory) -> Bool {
        return lhs.name == rhs.name
        && lhs.files == rhs.files
        && lhs.childDirectories == rhs.childDirectories
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(name)
        hasher.combine(files)
        hasher.combine(parent)
        hasher.combine(childDirectories)
    }
}

extension Directory: CustomStringConvertible {
    var description: String {
        return "name: \(name), size: \(getSize())"
    }
}

