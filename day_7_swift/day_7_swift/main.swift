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
let updateSpaceRequired = 30_000_000
let totalDiskSpace = 70_000_000

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
                let file = File(name: contentParts[1], size: Int(contentParts[0])!)
                currentLocation.files.append(file)
            }
        } else{
            fatalError("\(entry) not considered")
        }
    }

    return rootDir
}

func getDirectoriesUnderMaxSize(from directory: Directory, with sizeLimit: Int) -> Int {

    var accum = 0
    let currentDirSize = directory.getSize()

    if currentDirSize <= sizeLimit {
        accum += currentDirSize
    }

    for dir in directory.childDirectories {
        accum += getDirectoriesUnderMaxSize(from: dir, with: sizeLimit)
    }

    return accum
}

func findDeletableDirectories(from directory: Directory, with minSizeNeeded: Int) -> [Directory] {

    var directoriesLargeEnough = [Directory]()

    let currentDirSize = directory.getSize()

    if currentDirSize > minSizeNeeded {
        directoriesLargeEnough.append(directory)
    }

    for dir in directory.childDirectories {
        let largeEnough = findDeletableDirectories(from: dir, with: minSizeNeeded)
        directoriesLargeEnough.append(contentsOf: largeEnough)
    }

    let smallestOverMax = directoriesLargeEnough.sorted { $0.getSize() > $1.getSize() }

    return smallestOverMax
}



let fileTree = createFileSystem(from: lines)
let total = getDirectoriesUnderMaxSize(from: fileTree, with: maxFileSize)

let spaceNeeded = abs((totalDiskSpace - fileTree.getSize()) - updateSpaceRequired)
let deletableDirectoriesOfSize = findDeletableDirectories(from: fileTree, with: spaceNeeded).sorted {
    $0.getSize() < $1.getSize()
}


print(deletableDirectoriesOfSize.first!.getSize())
