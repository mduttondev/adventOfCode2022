#!/usr/bin/swift

/*
     [V] [G]             [H]
 [Z] [H] [Z]         [T] [S]
 [P] [D] [F]         [B] [V] [Q]
 [B] [M] [V] [N]     [F] [D] [N]
 [Q] [Q] [D] [F]     [Z] [Z] [P] [M]
 [M] [Z] [R] [D] [Q] [V] [T] [F] [R]
 [D] [L] [H] [G] [F] [Q] [M] [G] [W]
 [N] [C] [Q] [H] [N] [D] [Q] [M] [B]
 1   2   3   4   5   6   7   8   9
 */

import Foundation

var containerStack = [
    [],
    ["N", "D", "M", "Q", "B", "P", "Z"],
    ["C", "L", "Z", "Q", "M", "D", "H", "V"],
    ["Q", "H", "R", "D", "V", "F", "Z", "G"],
    ["H", "G", "D", "F", "N"],
    ["N", "F", "Q"],
    ["D", "Q", "V", "Z", "F", "B", "T"],
    ["Q", "M", "T", "Z", "D", "V", "S", "H"],
    ["M", "G", "F", "P", "N", "Q"],
    ["B", "W", "R", "M"],
]

var containerStackP2 = [
    [],
    ["N", "D", "M", "Q", "B", "P", "Z"],
    ["C", "L", "Z", "Q", "M", "D", "H", "V"],
    ["Q", "H", "R", "D", "V", "F", "Z", "G"],
    ["H", "G", "D", "F", "N"],
    ["N", "F", "Q"],
    ["D", "Q", "V", "Z", "F", "B", "T"],
    ["Q", "M", "T", "Z", "D", "V", "S", "H"],
    ["M", "G", "F", "P", "N", "Q"],
    ["B", "W", "R", "M"],
]

let pwd = FileManager.default.currentDirectoryPath
let fileContent = try! String(contentsOfFile: pwd + "/day_5_input.txt").split(separator: "\n")
let lines = fileContent.map{String($0)}

let nonNumericalChars = CharacterSet(charactersIn: "123456789").inverted

var instructions = [[Int]]()

for line in lines {
    let instruction = line.split(separator: " ").filter({ Int($0) != nil }).map({ Int($0)! })
    let iterations = instruction[0]
    let fromColumn = instruction[1]
    let toColumn = instruction[2]

    instructions.append([iterations, fromColumn, toColumn])

    for _ in 1...iterations {
        let crate = containerStack[fromColumn].last!
        let _ = containerStack[fromColumn].popLast()
        containerStack[toColumn].append(crate)
    }

}

var output = [String]()
for stack in containerStack {
    if let last = stack.last {
        output.append(last)
    }
}

print("Output: \(output.joined())")


func print(array: [[String]]) {
    for (index, item) in array.enumerated() {
        print("\(index): \(item)")
    }
    print("")
}





// Part 2
for instruction in instructions {
    let crateCount = instruction[0]
    let fromColumn = instruction[1]
    let toColumn = instruction[2]

    let crates = Array(containerStackP2[fromColumn].suffix(crateCount))
    containerStackP2[fromColumn].removeLast(crateCount)
    containerStackP2[toColumn].append(contentsOf: crates)

}

var outputP2 = [String]()
for stack in containerStackP2 {
    if let last = stack.last {
        outputP2.append(last)
    }
}

print("Output: \(outputP2.joined())")


