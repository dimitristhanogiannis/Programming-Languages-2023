hanoi(0, _, _, _) :- !.

hanoi(Disks, Source, Target, Middle) :-
    Disks > 0,
    Disks1 is Disks - 1, 
    hanoi(Disks1, Source, Middle, Target), 
    format('Move disk from ~w to ~w~n', [Source, Target]),
    hanoi(Disks1, Middle, Target, Source). 