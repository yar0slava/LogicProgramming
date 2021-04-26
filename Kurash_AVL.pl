% AVL tree - tree(tree(nil,3,nil), 5, tree(tree(nil,5,nil),8,nil)).

% Обхід AVL-дерева.

% ?- task_1(tree(tree(tree(nil,2,nil),3,tree(tree(nil,5,nil),7, nil)), 11, tree(nil, 13, tree(nil, 15, nil)))).
% 2 3 5 7 11 13 15 
% true.

task_1(nil) :- !.

task_1(tree(Left,Value,Right)) :- 
task_1(Left), 
write(Value), 
write(' '), 
task_1(Right).


% Пошук заданого елемента в AVL-дереві

% ?- task_2(tree(tree(tree(nil,2,nil),3,tree(tree(nil,5,nil),7, nil)), 11, tree(nil, 13, tree(nil, 15, nil))),13).
% Element found: 13
% true ;

% ?- task_2(tree(tree(tree(nil,2,nil),3,tree(tree(nil,5,nil),7, nil)), 11, tree(nil, 13, tree(nil, 15, nil))),1).
% false.

task_2(tree(_,Value,_),Value):- 
write('Element found: '), 
write(Value).

task_2(tree(Left,_,_),Value):- 
task_2(Left,Value).
task_2(tree(_,_,Right),Value):- 
task_2(Right,Value).


% Перевірки чи є заданий об''єкт AVL-деревом
% task_3(tree(tree(nil,3,nil), 5, tree(tree(nil,6,nil),8,nil))).
% true.
% task_3(tree(tree(nil,2,nil),5,tree(tree(nil,4,tree(nil,8,nil)),6,tree(nil,5,nil)))).
% false.

task_3(Tree):-
task_3_assist(Tree,_).

task_3_assist(nil,0).

task_3_assist(tree(Left,_,Right),Height):-
task_3_assist(Left,HeightLeft), 
task_3_assist(Right,HeightRight),
(HeightLeft is HeightRight;
	HeightLeft is HeightRight+1;
	HeightLeft is HeightRight-1),
heightCorrect(HeightLeft,HeightRight,Height).

heightCorrect(HeightLeft,HeightRight,Height):- 
HeightLeft > HeightRight,!, 
Height is HeightLeft+1; 
Height is HeightRight+1.

% Видалення заданого вузла з AVL-дерева
% task_4(tree(tree(tree(nil,1,nil),2,nil),3,tree(nil,5,tree(nil,6,nil))),5,R).

% ?- task_4(tree(tree(tree(nil,2,nil),3,tree(tree(nil,5,nil),7, nil)), 11, tree(nil, 13, tree(nil, 15, nil))),13,R).
% R = tree(tree(tree(nil, 2, nil), 3, tree(tree(nil, 5, nil), 7, nil)), 11, tree(nil, 15, nil)) .

% ?- task_4(tree(tree(tree(nil,2,nil),3,tree(tree(nil,5,nil),7, nil)), 11, tree(nil, 13, tree(nil, 15, nil))),17,R).
% false.


task_4(tree(nil,Elem,Right),Elem,Right).
task_4(tree(Left,Elem,_),Elem,Left).

task_4(tree(Left,Elem,Right),Elem,tree(Left,Val,Right1)):- 
cut_left(Right,Val,Right1).

task_4(tree(Left,Value,Right),Elem,tree(Left1,Value,Right)):- 
Value>Elem, 
task_4(Left,Elem,Left1).

task_4(tree(Left,Value,Right),Elem,tree(Left,Value,Right1)):- 
Elem>Value, 
task_4(Right,Elem,Right1). 

cut_left(tree(nil,Elem,Right),Elem,Right).

cut_left(tree(Left,Value,_),Elem,tree(Left1,Value,_)):- 
cut_left(Left,Elem,Left1).
