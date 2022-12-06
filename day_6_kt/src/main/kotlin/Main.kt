import java.io.File.separator

fun main(args: Array<String>) {
    val fileContent = {}::class.java.getResource("day_6_input.txt").readText()
//    val fileContent = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"

    val characters = mutableListOf<String>()

//    // Part 1
    for ( (index, c) in fileContent.iterator().withIndex()) {
        val character = c.toString()

        // Add first 4
        if (characters.count() < 4) {
            characters.add(character)
            continue
        }

        val charSet = characters.toSet()
        if (charSet.count() == 4) {
            print("Packet Marker after: $index\n")
            print("$characters\n")
            break
        }

        characters.removeAt(0)
        characters.add(character)
    }

    // Part 2
    characters.clear()
    for ( (index, c) in fileContent.iterator().withIndex()) {
        val character = c.toString()

        // Add first 4
        if (characters.count() < 14) {
            characters.add(character)
            continue
        }

        val charSet = characters.toSet()
        if (charSet.count() == 14) {
            print("Message Marker after: $index\n")
            print("$characters\n")
            break
        }

        characters.removeAt(0)
        characters.add(character)
    }
}

