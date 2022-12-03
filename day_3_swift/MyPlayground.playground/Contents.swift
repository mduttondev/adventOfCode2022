import Foundation

let fileURL = Bundle.main.url(forResource: "day_3_input", withExtension: ".txt")

let fileContent = try! String(contentsOfFile: fileURL!.relativePath, encoding: .utf8).split(separator: "\n")

let lines = fileContent.map{String($0)}

var pointsArray = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").map({String($0)})

var items = [String]()

for line in lines {
    let half = line.index(line.startIndex, offsetBy: line.count/2)
    let pouch1 = Set(line[line.startIndex..<half].map{String($0)})
    let pouch2 = Set(line[half..<line.endIndex].map{String($0)})

    let intersection = pouch1.intersection(pouch2)

    items.append(intersection.first!)
}

var accumulator = 0

for item in items {
    let points =  (pointsArray.firstIndex(of: item) ?? 0) + 1
    accumulator += points
}

print("Part 1: \(accumulator)")
accumulator = 0

var badges = [String]()

let allGroups = stride(from: 0, to: lines.count, by: 3).map {
    Array(lines[$0 ..< Swift.min($0 + 3, lines.count)])
}

for group in allGroups {
    let elf1 = Set(group[0].map{String($0)})
    let elf2 = Set(group[1].map{String($0)})
    let elf3 = Set(group[2].map{String($0)})

    let unique = elf1.intersection(elf2).intersection(elf3)
    badges.append(unique.first!)
}

for badge in badges {
    let points =  (pointsArray.firstIndex(of: badge) ?? 0) + 1
    accumulator += points
}
print("Part 2: \(accumulator)")

