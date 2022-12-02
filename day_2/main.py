# This is a sample Python script.

# Press ⌃R to execute it or replace it with your code.
# Press Double ⇧ to search everywhere for classes, files, tool windows, actions, and settings.

opp_rock = 'A'
opp_paper = 'B'
opp_scissors = 'C'

# Part 1
my_rock = 'X'
my_paper = 'Y'
my_scissors = 'Z'

# Part 2
my_loss = 'X'
my_draw = 'Y'
my_win = 'Z'

rock_points = 1
paper_points = 2
scissors_points = 3

loss_points = 0
draw_points = 3
win_points = 6

p1_outcomes = {
    opp_rock: {
        my_rock: rock_points + draw_points,
        my_paper: paper_points + win_points,
        my_scissors: scissors_points + loss_points
    },
    opp_paper: {
        my_rock: rock_points + loss_points,
        my_paper: paper_points + draw_points,
        my_scissors: scissors_points + win_points
    },
    opp_scissors: {
        my_rock: rock_points + win_points,
        my_paper: paper_points + loss_points,
        my_scissors: scissors_points + draw_points
    }
}

p2_outcomes = {
    opp_rock: {
        my_win: paper_points + win_points,
        my_loss: scissors_points + loss_points,
        my_draw: rock_points + draw_points
    },
    opp_paper: {
        my_win: scissors_points + win_points,
        my_loss: rock_points + loss_points,
        my_draw: paper_points + draw_points
    },
    opp_scissors: {
        my_win: rock_points + win_points,
        my_loss: paper_points + loss_points,
        my_draw: scissors_points + draw_points
    }
}


def read_file(path):
    points_total_p1 = 0
    points_total_p2 = 0

    with open(path) as file:
        lines = file.readlines()

    # P1
    for line in lines:
        them = line[0]
        me = line[2]

        round_points = p1_outcomes[them][me]
        points_total_p1 += round_points
    print('Part 1 Points: ' + str(points_total_p1))

    # P2
    for line in lines:
        opponent = line[0]
        outcome = line[2]

        round_points = p2_outcomes[opponent][outcome]
        points_total_p2 += round_points

    print('Part 2 Points: ' + str(points_total_p2))


if __name__ == '__main__':
    read_file('./day_2_input.txt')

