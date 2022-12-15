#!/usr/bin/python3
import sys
from functools import cmp_to_key

file = sys.path[0] + "/input.txt"
# file = sys.path[0] + "/demo.txt"

infile = sys.argv[1] if len(sys.argv) > 1 else file
data = open(infile).read().strip()

def compare(p1, p2):
    if isinstance(p1, int) and isinstance(p2, int):
        if p1 < p2:
            return -1
        elif p1 == p2:
            return 0
        else:
            return 1
    elif isinstance(p1, list) and isinstance(p2, list):
        i = 0
        while i < len(p1) and i < len(p2):
            comparison = compare(p1[i], p2[i])
            if comparison == -1:
                return -1
            if comparison == 1:
                return 1
            i += 1
        if i == len(p1) and i < len(p2):
            return -1
        elif i == len(p2) and i < len(p1):
            return 1
        else:
            return 0
    elif isinstance(p1, int) and isinstance(p2, list):
        return compare([p1], p2)
    else:
        return compare(p1, [p2])

def read_file():
    count = 0
    packets = []

    for i, group in enumerate(data.split('\n\n')):
        p1, p2 = group.split('\n')
        p1 = eval(p1)
        p2 = eval(p2)

        packets.append(p1)
        packets.append(p2)

        if compare(p1, p2) == -1:
            count += 1 + i
    print(count)

    packets.append([[6]])
    packets.append([[2]])

    packets = sorted(packets, key=cmp_to_key(lambda p1, p2: compare(p1, p2)))
    part2 = 1
    for i, p in enumerate(packets):
        if p == [[2]] or p == [[6]]:
            part2 *= i + 1
    print(part2)


if __name__ == "__main__":
    read_file()



