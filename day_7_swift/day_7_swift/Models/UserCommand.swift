//
//  Command.swift
//  day_7_swift
//
//  Created by Matthew Dutton on 12/8/22.
//

import Foundation

enum UserCommand {
    case upOneLevel
    case changeDirectory(dirName: String)
    case list

    init?(from value: String) {
        let parts = value.split(separator: " ").map{ String($0) }
        guard parts.first == "$" else { return nil }

        if parts[1] == "ls" {
            self = UserCommand.list
        } else if parts.count == 3 && parts[1] == "cd" && parts[2] == ".." {
            self = .upOneLevel
        } else if parts.count == 3 && parts[1] == "cd" {
            self = .changeDirectory(dirName: parts[2])
        } else {
            fatalError("Case Not Considered")
        }
    }
}
