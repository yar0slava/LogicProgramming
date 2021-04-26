

%tree example (empty one): nil.
%tree example: tree(tree(nil,b,nil), a, tree(tree(nil,d,nil), c, nil)).

%search BT (check if elem X is in a given tree).
%search(X, tree(_,X,_)):-!.
%search(X, tree(L,_,_)):- search(X,L).
%search(X, tree(_,_,R)):- search(X,R).

% 1. Послідовності вузлів при обході в глибину бінарного дерева праворуч.

% TEST
% ?- bt_task1(tree(tree(tree(nil,2,nil),3,nil), 4, tree(tree(nil,5,nil), 6, nil))).
% 2 3 4 5 6 
% true.

% ?- bt_task1(nil).
% true.

bt_task1(nil):-!.
bt_task1(tree(L,N,R)):-
	bt_task1(L),
	write(N),
	write(' '),
	bt_task1(R). %write('->'),bt_task1(R).

% 2. Визначення кількості листків бінарного дерева.

% TEST
% ?- bt_task2(tree(tree(tree(nil,2,nil),3,nil), 4, tree(tree(nil,5,nil), 6, nil)),R).
% R = 6.

% ?- bt_task2(tree(tree(nil,1,nil), 2, nil),R).
% R = 3.

% ?- bt_task2(nil,R).
% R = 1.

bt_task2(nil, RES) :- RES is 1,!.
bt_task2(tree(L,_,R),RES) :- 
	bt_task2(L,RES1), 
	bt_task2(R,RES2), 
	RES is RES1 + RES2.

% 3. Визначення висоту бінарного дерева.

% TEST
% ?- bt_task3(tree(tree(tree(nil,2,nil),3,nil), 4, tree(tree(nil,5,nil), 6, nil)),R).
% R = 3.

% ?- bt_task3(tree(tree(nil,1,nil), 2, nil),R).
% R = 2.

% ?- bt_task3(nil,R).
% R = 0.

bt_task3(nil, RES) :- RES is 0,!.
bt_task3(tree(L,_,R), RES) :- 
	bt_task3(L,RES1), 
	bt_task3(R,RES2), 
	RES is (1 + max(RES1,RES2)). %RESX is RES - 1.

% 4. Визначення кількість вузлів у бінарному дереві.

% TEST
% ?- bt_task4(tree(tree(tree(nil,2,nil),3,nil), 4, tree(tree(nil,5,nil), 6, nil)),R).
% R = 5.

% ?- bt_task4(tree(tree(nil,1,nil), 2, nil),R).
% R = 2.

% ?- bt_task4(nil,R).
% R = 0.

bt_task4(nil, RES) :- RES is 0,!.
bt_task4(tree(L,_,R), RES) :- 
	bt_task4(L, RES1), 
	bt_task4(R, RES2), 
	RES is (1 + RES1 + RES2).

% 5. Обходу 2-3-дерева.

% TEST
% ?- t23_task1(l(1)).
% 1 
% true.

% ?- t23_task1(v2(l(2),3,l(4))).
% 2 4 
% true.

% ?- t23_task1(v3(l(2),3,l(4),5,l(6))).
% 2 4 6 
% true.

% ?- t23_task1(v2(v2(l(1),2,l(3)),4,v2(l(5),6,l(7)))).
% 1 3 5 7 
% true.

t23_task1(nil):- !.
t23_task1(l(V)):- 
	write(V), 
	write(' '),!.
t23_task1(v2(T1,_,T2)):- 
	t23_task1(T1), 
	t23_task1(T2).
t23_task1(v3(T1,_,T2,_,T3)):- 
	t23_task1(T1), 
	t23_task1(T2), 
	t23_task1(T3).

% 6. Пошуку заданого елемента в 2-3-дереві.

% TEST
% ?- t23_task2(1,v2(l(2),3,l(4))).
% false.

% ?- t23_task2(4,v3(l(2),3,l(4),5,l(6))).
% true .

% ?- t23_task2(1,v3(l(2),3,l(4),5,l(6))).
% false.

t23_task2(X, l(X)) :- !.

t23_task2(X, v2(_,X,_)):- !.
t23_task2(X, v2(T1,_,_)) :- t23_task2(X,T1).
t23_task2(X, v2(_,_,T2)) :- t23_task2(X,T2).

t23_task2(X, v3(_,X,_,_,_)):- !.
t23_task2(X, v3(_,_,_,X,_)):- !.
t23_task2(X, v3(T1,_,_,_,_)):- t23_task2(X,T1).
t23_task2(X, v3(_,_,T2,_,_)):- t23_task2(X,T2).
t23_task2(X, v3(_,_,_,_,T3)):- t23_task2(X,T3).

% 7. Чи є об''єкт бінарним деревом.

% TEST
% ?- is_bt(tree(tree(tree(nil,2,nil),3,nil), 4, tree(tree(nil,5,nil), 1, nil))).
% false.

% ?- is_bt(tree(tree(tree(nil,2,nil),3,nil), 4, tree(tree(nil,5,nil), 6, nil))).
% true .

% ?- is_bt(tree(tree(nil,2,nil),3,nil)).
% true .

% ?- is_bt(tree(tree(nil,4,nil),3,nil)).
% false.

is_bt(nil):-!.
is_bt(tree(L,N,R)):-
	is_bt(L), 
	N \= nil, 
	is_bt(R), 
	ordered_bt(L,N,R).

ordered_bt(nil,_,nil):- !.
ordered_bt(nil,N,tree(L2,N2,R2)):- 
	N2>=N,
	ordered_bt(L2,N2,R2).
ordered_bt(tree(L1,N1,R1),N,nil):- 
	N>=N1,
	ordered_bt(L1,N1,R1).
ordered_bt(tree(L1,N1,R1),N,tree(L2,N2,R2)):- 
	N>=N1,
	N2>=N,
	ordered_bt(L1,N1,R1),
	ordered_bt(L2,N2,R2).

% 8. Чи є об''єкт 2-3 деревом.

% TEST

is_23t(l(_)):- !.

is_23t(v2(T1,_,T2)):- 
	is_23t(T1), 
	is_23t(T2).
is_23t(v3(T1,_,T2,_,T3)):- 
	is_23t(T1), 
	is_23t(T2), 
	is_23t(T3).