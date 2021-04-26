alphabetamax(s(R,L),Depth,_,_,Ret,_):-
        (isTerminal(L);Depth=0),!,
        getHeuristic(s(R,L),Ret).

        %,write(L), write(Ret),nl.

alphabetamax(State,Depth,Alpha,Beta,Ret,Next):-
        getChildren(State,Children),
        selectChildmax(Children,Depth,Alpha,Beta,Ret,_,Next).

alphabetamin(s(R,L),Depth,_,_,Ret,_):-
        (isTerminal(L);Depth=0),!,
        getHeuristic(s(R,L),Ret).

        %,write(L), write(Ret),nl.        

alphabetamin(State,Depth,Alpha,Beta,Ret,Next):-
        getChildren(State,Children),
        selectChildmin(Children,Depth,Alpha,Beta,Ret,_,Next).

min(A,B,A,VA,_,VA):-
        B>=A,!.
min(_,B,B,_,VB,VB).

max(A,B,A,VA,_,VA):-
        A>=B,!.
max(_,B,B,_,VB,VB).


selectChildmax(_,_,A,B,A,_,_):-
        B=<A,!.
%>

selectChildmax([],_,Alpha,_,Alpha,BestTillNow,BestTillNow).

selectChildmax([H|T],Depth,Alpha,Beta,Ret,BestTillNow,SelectChild):-
        NDepth is Depth -1,
        alphabetamin(H,NDepth,Alpha,Beta,NRet,_),
        max(Alpha,NRet,UpdetedAlpha,BestTillNow,H,NewBest),
        selectChildmax(T,Depth,UpdetedAlpha,Beta,Ret,NewBest,SelectChild).


selectChildmin(_,_,A,B,B,_,_):-
        B=<A,!.
%>

selectChildmin([],_,_,Beta,Beta,BestTillNow,BestTillNow).

selectChildmin([H|T],Depth,Alpha,Beta,Ret,BestTillNow,SelectChild):-
        NDepth is Depth -1,
        alphabetamax(H,NDepth,Alpha,Beta,NRet,_),

        min(Beta,NRet,UpdetedBeta,BestTillNow,H,NewBest),
        selectChildmin(T,Depth,Alpha,UpdetedBeta,Ret,NewBest,SelectChild).


isWinState(_,L,1,C,U,NewT,NewC,NewU):-
        allBoxes(L,Ret),
        Ret > U+C,
        NewU is Ret-C,
        NewT is 1,
        NewC is C,!.
isWinState(_,_,1,C,U,NewT,NewC,NewU):-
        NewU is U,
        NewT is 2,
        NewC is C.
isWinState(_,L,2,C,U,NewT,NewC,NewU):-
        allBoxes(L,Ret),
        Ret > U+C ,
        NewU is U,
        NewT is 2,
        NewC is Ret-U,!.
isWinState(_,_,2,C,U,NewT,NewC,NewU):-
        NewU is U,
        NewT is 1,
        NewC is C.


getChildren(s([T,C,U] ,L),Ch):-
        removeZero(L,NL),
        gett(NL , L, Ch,[T,C,U],_).

gett([],_,Ch,_,Children):-
        copynewlist(Children,Ch),!.
gett([H|Tail],L,Ch,[T,C,U],Children):-
       playIn(H,L,NewList),
       isWinState(H,NewList,T,C,U,NewT,NewC,NewU),
       addMember(s([NewT,NewC,NewU],NewList),Children,NewCh),
       gett(Tail,L,Ch,[T,C,U],NewCh).


playIn(X,[X|T],[0|T]).
playIn(X,[H|T],[H|NT]):-
        playIn(X,T,NT).

addMember(L,List,[L|List]).

removeZero([],[]).
removeZero([H|T],[H|NT]):-
 \+H=0,removeZero(T,NT).

removeZero([_|T],R):-
 removeZero(T,R).



%members(X,[X|_]).
%members(X,[_|T]):-
%        members(X,T).

% евристика
getHeuristic(s([_,C,U],L),H):-
        H is C-U.

%ismem(X,[X|_]):-!.
%ismem(X,[_|T]):-
%    ismem(X,T).
%notmem(X,R):-
%    not(ismem(R,X)).


count([],0).
count([_|T],R):-
        count(T,CT),
        R is CT + 1.

allBoxes(L,Boxes):-
 bagof(X, boxCount(L, X), R),
 count(R,Boxes),!.

allBoxes(L,Boxes):-
 Boxes is 0.


% варіанти вигляду поля, при якому сформовано квадрат і зараховується очко
boxCount([0,_,0,0,_,0,_,_,_,_,_,_],1).
boxCount([_,0,_,0,0,_,0,_,_,_,_,_],1).
boxCount([_,_,_,_,_,0,_,0,0,_,0,_],1).
boxCount([_,_,_,_,_,_,0,_,0,0,_,0],1).
boxCount([0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_,_,_,_,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0,_],1).
boxCount([_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,0,_,_,_,_,0,0,_,_,_,_,0],1).


% чи є поточний стан кінцевим(термінальним)
% тобто всі елементи списку рівні 0(всі палички розставлені)
isTerminal([]).
isTerminal([H|T]):-
        H is 0 ,
        isTerminal(T).


% getLetter(x,x,_).
% getLetter(o,o,_).
% getLetter(e,A,A).


% взяти елемент за індексом зі списку
getchar(1,[H|_],H):-!.

getchar(Indx,[H|T],Char):-
   NewIndx is Indx-1,
   getchar(NewIndx,T,Char).


output(12,L):-
         write('# '),getchar(1,L,C1),write(C1),write('  # '),getchar(2,L,C2),write(C2),write('  #'),nl,
         getchar(3,L,C3),write(C3),write('    '),getchar(4,L,C4),write(C4),write('    '),getchar(5,L,C5),write(C5),nl,
         write('# '),getchar(6,L,C6),write(C6),write('  # '),getchar(7,L,C7),write(C7),write('  #'),nl,
         getchar(8,L,C8),write(C8),write('    '),getchar(9,L,C9),write(C9),write('    '),getchar(10,L,C10),write(C10),nl
         ,write('# '),getchar(11,L,C11),write(C11),write(' # '),getchar(12,L,C12),write(C12),write(' #'),nl,!.

output(60,L):-
write('# '),getchar(1,L,C1),write(C1),write('  '),write('# '),getchar(2,L,C2),write(C2),write('  '),write('# '),getchar(3,L,C3),write(C3),write('  '),write('# '),getchar(4,L,C4),write(C4),write('  '),write('# '),getchar(5,L,C5),write(C5),write('  '),write('#'),nl,
getchar(6,L,C6),write(C6),write('    '),getchar(7,L,C7),write(C7),write('    '),getchar(8,L,C8),write(C8),write('    '),getchar(9,L,C9),write(C9),write('    '),getchar(10,L,C10),write(C10),write('   '),getchar(11,L,C11),write(C11),write('   '),nl,
write('# '),getchar(12,L,C12),write(C12),write(' '),write('# '),getchar(13,L,C13),write(C13),write(' '),write('# '),getchar(14,L,C14),write(C14),write(' '),write('# '),getchar(15,L,C15),write(C15),write(' '),write('# '),getchar(16,L,C16),write(C16),write(' '),write('#'),nl,
getchar(17,L,C17),write(C17),write('   '),getchar(18,L,C18),write(C18),write('   '),getchar(19,L,C19),write(C19),write('   '),getchar(20,L,C20),write(C20),write('   '),getchar(21,L,C21),write(C21),write('   '),getchar(22,L,C22),write(C22),write('   '),nl,
write('# '),getchar(23,L,C23),write(C23),write(' '),write('# '),getchar(24,L,C24),write(C24),write(' '),write('# '),getchar(25,L,C25),write(C25),write(' '),write('# '),getchar(26,L,C26),write(C26),write(' '),write('# '),getchar(27,L,C27),write(C27),write(' '),write('#'),nl,
getchar(28,L,C28),write(C28),write('   '),getchar(29,L,C29),write(C29),write('   '),getchar(30,L,C30),write(C30),write('   '),getchar(31,L,C31),write(C31),write('   '),getchar(32,L,C32),write(C32),write('   '),getchar(33,L,C33),write(C33),write('   '),nl,
write('# '),getchar(34,L,C34),write(C34),write(' '),write('# '),getchar(35,L,C35),write(C35),write(' '),write('# '),getchar(36,L,C36),write(C36),write(' '),write('# '),getchar(37,L,C37),write(C37),write(' '),write('# '),getchar(38,L,C38),write(C38),write(' '),write('#'),nl,
getchar(39,L,C39),write(C39),write('   '),getchar(40,L,C40),write(C40),write('   '),getchar(41,L,C41),write(C41),write('   '),getchar(42,L,C42),write(C42),write('   '),getchar(43,L,C43),write(C43),write('   '),getchar(44,L,C44),write(C44),write('   '),nl,
write('# '),getchar(45,L,C45),write(C45),write(' '),write('# '),getchar(46,L,C46),write(C46),write(' '),write('# '),getchar(47,L,C47),write(C47),write(' '),write('# '),getchar(48,L,C48),write(C48),write(' '),write('# '),getchar(49,L,C49),write(C49),write(' '),write('#'),nl,
getchar(50,L,C50),write(C50),write('   '),getchar(51,L,C51),write(C51),write('   '),getchar(52,L,C52),write(C52),write('   '),getchar(53,L,C53),write(C53),write('   '),getchar(54,L,C54),write(C54),write('   '),getchar(55,L,C55),write(C55),write('   '),nl,
write('# '),getchar(56,L,C56),write(C56),write(' '),write('# '),getchar(57,L,C57),write(C57),write(' '),write('# '),getchar(58,L,C58),write(C58),write(' '),write('# '),getchar(59,L,C59),write(C59),write(' '),write('# ' ),getchar(60,L,C60),write(C60),write(' '),write('#'),nl,!.


copynewlist([],_):-!.
copynewlist([H|T],[H|NT]):-
    copynewlist(T,NT).


%================================================


run(H,s([T,C,U],L)):-
        copynewlist(L,LL),
        isTerminal(LL),!,
        count(L,Cnt),
        output(Cnt,L),
        write('Score is '),
        write(C),write(' '),write(U),
        nl.

run(H,s([2,C,U],S)):-
        alphabetamax(s([2,C,U],S),H,-1000,1000,_,s(R,E)),
        run(H,s(R,E)).

run(H,s([1,C,U],S)):-
        count(S,Cnt),
        output(Cnt,S),nl,
        %write('Select the cell number you want to play in and write its number followed by .'),
        read(W),
        playIn(W,S,NewList),
        isWinState(W,NewList,1,C,U,NewT,NewC,NewU),
        run(H,s([NewT,NewC,NewU],NewList)).

% s([1,очки комп'ютера,очки користувача],[1,2,3,4,5,6,7,8,9,10,11,12])

run1(1):-
        run(1,s([1,0,0],[1,2,3,4,5,6,7,8,9,10,11,12])).
run1(2):-
        run(2,s([1,0,0],[1,2,3,4,5,6,7,8,9,10,11,12])).
run1(3):-
        run(3,s([1,0,0],[1,2,3,4,5,6,7,8,9,10,11,12])).
run2(1):-
        run(1,s([1,0,0],[1,2,3,4,5,6,7,8,9,10,
          11,12,13,14,15,16,17,18,19,20,
          21,22,23,24,25,26,27,28,29,30,
          31,32,33,34,35,36,37,38,39,40,
          41,42,43,44,45,46,47,48,49,50,
          51,52,53,54,55,56,57,58,59,60])).
run2(2):-
        run(2,s([1,0,0],[1,2,3,4,5,6,7,8,9,10,
          11,12,13,14,15,16,17,18,19,20,
          21,22,23,24,25,26,27,28,29,30,
          31,32,33,34,35,36,37,38,39,40,
          41,42,43,44,45,46,47,48,49,50,
          51,52,53,54,55,56,57,58,59,60])).
run2(3):-
        run(3,s([1,0,0],[1,2,3,4,5,6,7,8,9,10,
          11,12,13,14,15,16,17,18,19,20,
          21,22,23,24,25,26,27,28,29,30,
          31,32,33,34,35,36,37,38,39,40,
          41,42,43,44,45,46,47,48,49,50,
          51,52,53,54,55,56,57,58,59,60])).

solve(1,H):-
  run1(H).
solve(2,H):-
  run2(H).

run:-
   write('1. 2x2 Game'),nl,
   write('2. 5x5 Game'),nl,
   read(C),
   write('1. Easy'),nl,
   write('2. Medium'),nl,
   write('3. Hard'),nl,
   read(H),
   solve(C,H).


/*
# 1  # 2  #
3    4    5
# 6  # 7  #
8    9    10
# 11 # 12 #
*/
/*
# 1  # 2  # 3  # 4  # 5  #
6    7    8    9    10   11   
# 12 # 13 # 14 # 15 # 16 #
17   18   19   20   21   22   
# 23 # 24 # 25 # 26 # 27 #
28   29   30   31   32   33   
# 34 # 35 # 36 # 37 # 38 #
39   40   41   42   43   44   
# 45 # 46 # 47 # 48 # 49 #
50   51   52   53   54   55   
# 56 # 57 # 58 # 59 # 60 #
*/