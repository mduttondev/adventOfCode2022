#!/usr/bin/env python3
from enum import Enum


class Direction(Enum):
    UP = 'U'
    DOWN = 'D'
    LEFT = 'L'
    RIGHT = 'R'


def read_file(path: str) -> list:
    with open(path) as file:
        content = file.readlines()
        stripped = []
        for line in content:
            stripped.append(line.strip())
        return stripped


def process_instructions(instructions: list) -> int:
    head = [0, 0]
    tail = [0, 0]

    tail_pos_visited = []

    for move in instructions:
        move_parts = move.split(" ")
        direction = Direction(move_parts[0])
        count = int(move_parts[1])

        for i in range(count):
            adjust_position(head, direction)
            if requires_tail_move(head, tail):
                tail = reposition_tail(head, tail)
            tail_pos_visited.append(f"{tail[0]}, {tail[1]}")

    unique = list(set(tail_pos_visited))
    print(len(unique))
    return len(unique)


def reposition_tail(head, tail) -> list:
    head_x = head[0]
    head_y = head[1]
    tail_x = tail[0]
    tail_y = tail[1]

    if head_y - tail_y > 0:  # Move Up
        tail_y = tail_y + 1
        if head_x - tail_x > 0:  # Move Right
            tail_x = tail_x + 1
        elif head_x - tail_x < 0:  # Move Left
            tail_x = tail_x - 1
        return [tail_x, tail_y]

    if head_y - tail_y < 0:  # Move Down
        tail_y = tail_y - 1
        if head_x - tail_x > 0:  # Move Right
            tail_x = tail_x + 1
        elif head_x - tail_x < 0:  # Move Left
            tail_x = tail_x - 1
        return [tail_x, tail_y]

    if head_x - tail_x < 0:  # Move Left
        tail_x = tail_x - 1
    elif head_x - tail_x > 0:  # Move Right
        tail_x = tail_x + 1

    return [tail_x, tail_y]

def requires_tail_move(head, tail) -> bool:
    head_x = head[0]
    head_y = head[1]
    tail_x = tail[0]
    tail_y = tail[1]

    if head == tail:
        return False
    if abs(head_y - tail_y) > 1:
        return True
    if abs(head_x - tail_x) > 1:
        return True

    return False


def adjust_position(pos: list, direction) -> list:
    idx = 1 if direction == Direction.UP or direction == Direction.DOWN else 0
    multiplier = -1 if direction == Direction.DOWN or direction == Direction.LEFT else 1
    val = pos[idx]
    val += 1 * multiplier
    pos[idx] = val


if __name__ == '__main__':
    commands = read_file('./input.txt')
    # commands = read_file('./demo.txt')
    visited2 = process_instructions(commands)
    print(commands)