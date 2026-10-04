% Check if N can be represented in base B with identical digits
all_same_digits(N, B) :-
    B > 1,
    MaxDigit is B - 1,
    between(1, MaxDigit, D),
    check_digits(N, B, D).

% Recursively check if all digits are identical in base B
check_digits(0, _, _).
check_digits(N, B, D) :-
    N > 0,
    R is N mod B,
    R =:= D,
    N1 is N // B,
    check_digits(N1, B, D).

% Find the minimum base for N using optimized approach
minbase(N, MinBase) :-
    N > 0,
    minbase_helper(N, 2, MinBase).

% Helper predicate to find the minimum base starting from Base
minbase_helper(N, Base, Base) :-
    all_same_digits(N, Base).
minbase_helper(N, Base, MinBase) :-
    Base * Base > N,  % Stop checking when Base exceeds sqrt(N)
    MinBase = N + 1.
minbase_helper(N, Base, MinBase) :-
    all_same_digits(N, Base),
    MinBase = Base.
minbase_helper(N, Base, MinBase) :-
    NextBase is Base + 1,
    minbase_helper(N, NextBase, MinBase).

% Process a list of numbers to find the minimum base for each
minbases([], []).
minbases([N|Ns], [B|Bs]) :-
    minbase(N, B),
    minbases(Ns, Bs).

% Main predicate to handle input and output
main :-
    read_line_to_string(user_input, Line),
    split_string(Line, " ", "", Numbers),
    maplist(number_string, NumberList, Numbers),
    minbases(NumberList, Bases),
    maplist(print_base, Bases).

% Print each base on a new line
print_base(Base) :-
    format('~d~n', [Base]).
