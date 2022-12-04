import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Main {
    public static void main(String[] args) {
        ArrayList<String> input = new ArrayList<String>();
        try {
            String currentDir = System.getProperty("user.dir");
            File file = new File(currentDir + "/src/day_4_input.txt");
            Scanner reader = new Scanner(file);
            while (reader.hasNextLine()) {
                input.add(reader.nextLine());
            }
            reader.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        int fullyEnclosed = 0;
        int overlappingRanges = 0;

        for (String entry: input) {
            // Part 1
            String[] parts = entry.split(",");

            String[] leading = parts[0].split("-");
            Integer lowerBoundPart1 = Integer.parseInt(leading[0]);
            Integer upperBoundPart1 = Integer.parseInt(leading[1]);

            String[] trailing = parts[1].split("-");
            Integer lowerBoundPart2 = Integer.parseInt(trailing[0]);
            Integer upperBoundPart2 = Integer.parseInt(trailing[1]);

            Set<Integer> set1 = IntStream.rangeClosed(lowerBoundPart1, upperBoundPart1).boxed().collect
                    (Collectors.toSet());
            Set<Integer> set2 = IntStream.rangeClosed(lowerBoundPart2, upperBoundPart2).boxed().collect
                    (Collectors.toSet());

            if (set1.containsAll(set2) || set2.containsAll(set1)) {
                fullyEnclosed++;
            }

            // Part 2
            set1.retainAll(set2);
            if (!set1.isEmpty()) {
                overlappingRanges++;
            }

        }
        System.out.println(fullyEnclosed + " ranges are fully enclosed in the other");
        System.out.println(overlappingRanges + " ranges are at least partially overlapped");
    }
}