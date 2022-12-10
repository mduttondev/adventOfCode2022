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

        for col, number in enumerate(row): # Check left and right
            if col == 0 or col == len(row) - 1:
                continue
            left = row[:col]
            right = row[col+1:]
            vis_left = all(i < number for i in left)
            vis_right = all(i < number for i in right)
            vis = vis_left or vis_right

            above = []
            below = []
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
            vis = False

    return vis_trees


if __name__ == '__main__':
    matrix = create_matrix('./input.txt')
    # matrix = create_matrix('./demo.txt')
    edge_trees = grid_edges(matrix)
    interior_trees = interior_visible_trees(matrix)

    print(f"{edge_trees + interior_trees} Trees Visible")


