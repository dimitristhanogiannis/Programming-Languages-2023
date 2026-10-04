% Define the winner predicate
winner(Board) :-
    ( already_won(Board)
    ; can_win_in_one_move(Board)
    ).

% Check if "x" has already won
already_won(Board) :-
    win_condition(Board, x).

% Check if "x" can win in one move
can_win_in_one_move(Board) :-
    findall(NewBoard, make_move(Board, NewBoard), PossibleMoves),
    member(NewBoard, PossibleMoves),
    win_condition(NewBoard, x).

% Win condition checks if "x" forms a complete line
win_condition(Board, Player) :-
    ( row_win(Board, Player)
    ; column_win(Board, Player)
    ; diagonal_win(Board, Player)
    ).

% Check rows for win condition
row_win([Row|_], Player) :- all_same(Row, Player).
row_win([_|Rows], Player) :- row_win(Rows, Player).

% Check columns for win condition
column_win(Board, Player) :-
    transpose(Board, TransposedBoard),
    row_win(TransposedBoard, Player).

% Check diagonals for win condition
diagonal_win(Board, Player) :-
    diagonal1(Board, Diagonal1),
    all_same(Diagonal1, Player).
diagonal_win(Board, Player) :-
    diagonal2(Board, Diagonal2),
    all_same(Diagonal2, Player).

% Check if all elements in a list are the same
all_same([Player, Player, Player], Player).

% Transpose a matrix (convert rows to columns)
transpose([[A, B, C], [D, E, F], [G, H, I]], [[A, D, G], [B, E, H], [C, F, I]]).

% Extract the first diagonal
diagonal1([[A, _, _], [_, B, _], [_, _, C]], [A, B, C]).

% Extract the second diagonal
diagonal2([[_, _, A], [_, B, _], [C, _, _]], [A, B, C]).

% Make a move and create a new board configuration
make_move(Board, NewBoard) :-
    replace(Board, NewBoard, 1).

% Replace an element in the board with "x" if it is empty ("b")
replace([Row|Rows], [NewRow|Rows], ColIndex) :-
    replace_in_row(Row, NewRow, ColIndex).
replace([Row|Rows], [Row|NewRows], ColIndex) :-
    replace(Rows, NewRows, ColIndex).

% Replace an element in the row with "x" if it is empty ("b")
replace_in_row([b|Cols], [x|Cols], 1).
replace_in_row([Col|Cols], [Col|NewCols], ColIndex) :-
    ColIndex > 1,
    NewColIndex is ColIndex - 1,
    replace_in_row(Cols, NewCols, NewColIndex).
