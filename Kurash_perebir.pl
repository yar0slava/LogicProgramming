
% ?- init. 
% ?- task_1(X).
% ?- task_2(X).
% ?- task_3(X).
% ?- task_4(X).
% ?- task_5(X).

init :- init(9).
init(-1) :- !.
init(X) :- asserta(d(X)), X1 is X-1, init(X1).

task_1(X) :- 
d(X1), X1 > 0, 
d(X2), 
d(X3),
X1 mod 2 =\= 0,
X2 mod 2 =\= 0,
X3 mod 2 =\= 0,
(100 * X1 + 10 * X2 + X3) mod (10 * X1 + X3) =:= 0,
X is 100 * X1 + 10 * X2 + X3.

task_2(X) :- 
d(X1), X1 > 0, 
d(X2),
X is (1000 * X1 + 100 * X1 + 10 * X2 + X2),
round(sqrt(X)) ** 2 =:= X.

task_3 :- 
d(X1), 
d(X2), 
d(X3), 
d(X4),
N is (1000 * X1 + 100 * X2 + 10 * X3 + X4),
N =< 1998,
N mod 6 =\= 0,
N mod 10 =\= 0,
N mod 15 =\= 0.

task_3(Amount) :- 
aggregate_all(count, task_3, Amount).

task_4(A) :- 
task_4(A, 1).

task_4(A, N):- 
X is N * N,
X1  is (N + 1) ** 2,
X2  is (N + 2) ** 2,
X3  is (N + 3) ** 2,
X4  is (N + 4) ** 2,
X5  is (N + 5) ** 2,
X6  is (N + 6) ** 2,
X7  is (N + 7) ** 2,
X8  is (N + 8) ** 2,
X9  is (N + 9) ** 2,
X10 is (N + 10) ** 2,
SUM is X + X1 + X2 + X3 + X4 + X5 + X6 + X7 + X8 + X9 + X10,
EXP is round(sqrt(SUM)),
(SUM =:= EXP * EXP -> A is N ; NEXT is N + 1, task_4(A, NEXT)).

task_5(RES) :- 
task_5(1, 9, 9, 8, 0, RES).

task_5(X1, X2, X3, X4, C, RES) :- 
(X1 * 1000 + X2 * 100 + X3 * 10 + X4) =:= 1998, 
C > 0 -> RES is C ;  C1 is C + 1,
NEXT_X is (X1 + X2 + X3 + X4) mod 10,
task_5(X2, X3, X4, NEXT_X, C1, RES).
