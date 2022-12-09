//
//  main.swift
//  day_7_swift
//
//  Created by Matthew Dutton on 12/8/22.
//

import Foundation

let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let bundleURL = URL(fileURLWithPath: "Inputs.bundle", relativeTo: currentDirectoryURL)
let bundle = Bundle(url: bundleURL)
//let inputFileUrl = bundle!.url(forResource: "demo", withExtension: "txt")!
let inputFileUrl = bundle!.url(forResource: "input", withExtension: "txt")!

let fileContent = try! String(contentsOfFile: inputFileUrl.relativePath).split(separator: "\n")
let lines = fileContent.map{String($0)}

let maxFileSize = 100_000

func createFileSystem(from input: [String]) -> Directory {
    let rootDir = Directory(name: "/", parent: nil)

    var currentLocation = rootDir

    var listingContents = false

    for entry in input {

        if entry.hasPrefix("$") {
            listingContents = false

            guard let command = UserCommand(from: entry) else { fatalError("Could not parse command: \(entry)") }

            switch command {
            case .upOneLevel:
                guard let parent = currentLocation.parent else { fatalError("Traversed to a point with no parent") }
                currentLocation = parent
            case .changeDirectory(let dirName):
                if dirName == rootDir.name { continue }
                currentLocation = currentLocation.childDirectories.first(where: { $0.name == dirName} )!
            case .list:
                listingContents = true
            }
        } else if listingContents {
            let contentParts = entry.split(separator: " ").map { String($0) }
            if contentParts.first == "dir" {
                let dir = Directory(name: contentParts[1], parent: currentLocation)
                currentLocation.childDirectories.append(dir)
            } else {
                let file = File(name: contentParts[1], size: Double(contentParts[0])!)
                currentLocation.files.append(file)
            }
        } else{
            fatalError("\(entry) not considered")
        }
    }

    return rootDir
}

func getDirectoriesUnderMaxSize(from directory: Directory, with sizeLimit: Double) -> Double {

    var accum: Double = 0
    let currentDirSize = directory.getSize()

    if currentDirSize <= sizeLimit {
        accum += currentDirSize
    }

    for dir in directory.childDirectories {
        accum += getDirectoriesUnderMaxSize(from: dir, with: sizeLimit)
    }

    return accum
}



let fileTree = createFileSystem(from: lines)
let total = getDirectoriesUnderMaxSize(from: fileTree, with: Double(maxFileSize))
print(total)

