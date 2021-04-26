% ?- task_1([-1,-12,3,14,-5,7],R).
% R=[0,1,4]

task_1(List,Rx) :- 
task_1_assist(0,List,R), 
delete(R,-1,Rx).

task_1_assist(_, [], []) :- !.

task_1_assist(N,[FirstEl|List],[FR|R]) :- 
FirstEl < 0, 
N1 is N+1, 
FR is N, 
task_1_assist(N1, List, R); 
FirstEl >= 0, 
N1 is N+1, 
FR is -1, 
task_1_assist(N1, List, R),!.

% ?- task_2(2,[-1,2,3,2,14,-5,2,7,2],R).
% R = [-1, "change_done", 3, "change_done", 14, -5, "change_done", 7, "change_done"]

task_2(El, List, R) :- 
task_2(El, "change_done", List, R).

task_2(_, _, [], []).

task_2(El, Replace, [El|L1], [Replace|L2]) :- 
task_2(El, Replace, L1, L2).

task_2(El, Replace, [FE|L1], [FE|L2]) :- 
FE \= El, 
task_2(El, Replace, L1, L2).

% ?- task_3([4,13,17,29,32,49,50],R).
% R = ["IV", "XIII", "XVII", "XXIX", "XXXII", "XLIX", "L"].

task_3([],[]) :- !.

task_3([FE|List],[RStr|RList]) :- 
toRoman(FE,R), 
toString(R,RStr), 
task_3(List,RList).

toRoman(X,[FE|List]):- 
X = 50, FE = "L", Y=X-50, toRoman(Y,List),!.
toRoman(X,[FE|List]):- 
X >= 40, FE = "XL", Y=X-40, toRoman(Y,List),!.
toRoman(X,[FE|List]):- 
X > 9, FE = "X", Y=X-10, toRoman(Y,List),!.
toRoman(X,[FE|[]]):- 
X =:= 9, FE = "IX",!.
toRoman(X,[FE|List]):- 
X > 4, FE = "V", Y=X-5, toRoman(Y,List),!.
toRoman(X,[FE|[]]):- 
X =:= 4, FE = "IV",!.
toRoman(X,[FE|List]):- 
X >= 1, FE = "I",  Y=X-1, toRoman(Y,List),!.
toRoman(X,[]):- 
X =:= 0, !.
toRoman(X,[FE|List]):- 
X < 0, FE = "-", Y=(-X), toRoman(Y,List),!.

% перетворення списку в рядок
toString(List,X):- atomics_to_string(List,X).

% ?- task_4([-1,-12,3,14,-5,7],R).
% R = [7, -1, -12, 3, 14, -5]
task_4(List, [FE|Res]) :- 
append(Res, [FE], List).

% ?- task_5([[1,2,3],[4,5,6]],[-1,2,0],R).
% R = [3, 6].
% ?- task_5([[1,1,1],[-1,0,2],[-3,1,0]],[1,2,-3],R).
% R = [0, -7, -1].
task_5([],_,[]) :- !.

task_5([FM|Matrix],Vector,[FR|Res]) :- 
multVectors(FM,Vector,0,FR),
task_5(Matrix,Vector,Res).

% ?- multVectors([-1,0,2],[-3,1,1],0,R).
% R=5
multVectors([],[],Sum,Res) :- 
Res = Sum, !.

multVectors([FV1|V1],[FV2|V2],Sum,Res) :- 
Sum1 is Sum + (FV1 * FV2), 
multVectors(V1,V2,Sum1,Res),!.