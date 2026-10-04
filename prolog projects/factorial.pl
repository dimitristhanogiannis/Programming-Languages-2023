factorial(0, 1).
factorial(N, F) :- N > 0 ,N1 is N - 1, factorial(N1, F1), F is F1 * N.

factorial1(N , F) :- N =:= 0 -> F = 1; N > 0, N1 is N - 1, factorial1(N1, F1), F is F1 * N.