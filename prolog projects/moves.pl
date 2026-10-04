:- use_module(library(clpfd)).

% moves/2 predicate to find the sequence of moves
moves(File, Moves) :-
    open(File, read, Stream),
    read_grid(Stream, Grid),
    close(Stream),
    length(Grid, N),
    start_position(Pos),
    end_position(N, EndPos),
    dfs(Grid, Pos, EndPos, [Pos], Moves).

% Read the grid from the input file
read_grid(Stream, Grid) :-
    read_line_to_string(Stream, Line),
    number_string(N, Line),
    read_grid_lines(Stream, N, Grid).

% Read N lines of the grid
read_grid_lines(Stream, 0, []) :- !.
read_grid_lines(Stream, N, [Row|Rows]) :-
    read_line_to_string(Stream, Line),
    split_string(Line, " ", "", Strings),
    maplist(number_string, Row, Strings),
    N1 #= N - 1,
    read_grid_lines(Stream, N1, Rows).

% Starting position
start_position((1, 1)).

% Ending position
end_position(N, (N, N)).

% Define the possible movements and their effects on coordinates
move((X, Y), (X1, Y1), se) :- X1 #= X + 1, Y1 #= Y + 1.
move((X, Y), (X1, Y1), s) :- X1 #= X + 1, Y1 #= Y.
move((X, Y), (X1, Y1), sw) :- X1 #= X + 1, Y1 #= Y - 1.
move((X, Y), (X1, Y1), e) :- X1 #= X, Y1 #= Y + 1.
move((X, Y), (X1, Y1), w) :- X1 #= X, Y1 #= Y - 1.
move((X, Y), (X1, Y1), ne) :- X1 #= X - 1, Y1 #= Y + 1.
move((X, Y), (X1, Y1), n) :- X1 #= X - 1, Y1 #= Y.
move((X, Y), (X1, Y1), nw) :- X1 #= X - 1, Y1 #= Y - 1.

% Ensure the move is within grid bounds
in_bounds((X, Y), N) :- X > 0, Y > 0, X =< N, Y =< N.

% Depth-first search
dfs(Grid, Pos, End, Visited, Moves) :-
    (Pos = End -> Moves = []
    ; move(Pos, NextPos, Move),
      in_bounds(NextPos, N),
      \+ member(NextPos, Visited),
      cell_value(Grid, Pos, CurrentCars),
      cell_value(Grid, NextPos, NextCars),
      NextCars #< CurrentCars,
      dfs(Grid, NextPos, End, [NextPos|Visited], RestMoves),
      Moves = [Move|RestMoves]
    ).

% Get the value of the cell in the grid
cell_value(Grid, (X, Y), Value) :-
    nth1(X, Grid, Row),
    nth1(Y, Row, Value).
