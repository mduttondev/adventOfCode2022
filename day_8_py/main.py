#!/usr/bin/env python3

def create_matrix(path):
    grid = []
    with open(path) as file:
        lines = file.readlines()

        for line in lines:
            arr = list(line.strip())
            int_array = list(map(int, arr))
            grid.append(int_array)

    return grid


def grid_edges(grid) -> int:
    height = len(grid)
    width = len(grid[0])
    return (height * 2) + (width * 2) - 4


def interior_visible_trees(grid) -> int:
    vis_trees = 0
    vis = False
    for idx, row in enumerate(grid):
        if idx == 0 or idx == len(grid) - 1:
            continue

        # Check left and right
        for col, number in enumerate(row):
            vis = False
            if col == 0 or col == len(row) - 1:
                continue
            left = row[:col]
            right = row[col+1:]
            vis_left = all(i < number for i in left)
            vis_right = all(i < number for i in right)
            vis = vis_left or vis_right

            above = []
            below = []
            # Check above and below
            for i, group in enumerate(grid):
                if i == idx:
                    continue
                if i < idx:
                    above.append(group[col])
                if i > idx:
                    below.append(group[col])
            vis_above = all(i < number for i in above)
            vis_below = all(i < number for i in below)
            vis = vis or vis_above or vis_below

            if vis:
                vis_trees += 1

    return vis_trees

def visible_distance(num, arr, reverse) -> int:
    vis = 0
    if reverse:
        for e in reversed(arr):
            if e >= num:
                vis += 1
                break
            vis += 1
    else:
        for e in arr:
            if e >= num:
                vis += 1
                break
            vis += 1

    return vis

def location_score(grid) -> int:
    high_vis_score = 0

    for idx, row in enumerate(grid):
        for col, number in enumerate(row):
            left = row[:col]
            right = row[col+1:]
            vis_left = visible_distance(number, left, True)
            vis_right = visible_distance(number, right, False)

            above = []
            below = []
            for i, group in enumerate(grid):
                if i == idx:
                    continue
                if i < idx:
                    above.append(group[col])
                if i > idx:
                    below.append(group[col])
            vis_up = visible_distance(number, above, True)
            vis_down = visible_distance(number, below, False)

            score = vis_left * vis_right * vis_up * vis_down

            if score > high_vis_score:
                high_vis_score = score

    return high_vis_score


if __name__ == '__main__':
    matrix = create_matrix('./input.txt')
    # matrix = create_matrix('./demo.txt')

    edge_trees = grid_edges(matrix)

    interior_trees = interior_visible_trees(matrix)

    high_location_score = location_score(matrix)

    print(f"{edge_trees + interior_trees} trees visible from the outside")
    print(f"{high_location_score} is the highest location score present")


