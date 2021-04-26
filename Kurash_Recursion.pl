div_mod(Num, Div, Res, Rem) :-
    Num >= 0, Div > 0, 
    div_mod1(Num, Div, 0, Res, Rem).

div_mod1(Num, Div, Res, Res, Rem) :-
    Num < Div, Rem = Num, !.

div_mod1(Num, Div, Res0, Res, Rem) :-
    Num1 is Num - Div, Res1 is Res0 + 1, 
    div_mod1(Num1, Div, Res1, Res, Rem).


pow(_,N,Res) :- 
    N=0, 
    Res=1,!.

pow(Num,N,Res):-  
    G is N-1,
    pow(Num, G, Res1), 
    Res is Num*Res1.

powl(_,N,Res):- 
    N=0, 
    Res=1, !.

powl(Num,N,Res):- 
    N mod 2 =:= 1, 
    Num1 is Num*Num,
    N1 is N>>1,
    powl(Num1,N1,Res1),
    Res is Num*Res1, !.

powl(Num,N,Res):- 
    Num1 = Num*Num,
    N1 is N>>1,
    powl(Num1,N1,Res1),
    Res is Res1, !.

fibonacci(Num,F1,F2):- 
    Num=1,
    F1=1,
    F2=0.

fibonacci(Num,F1,F2):-
    Num > 0,
    Num1 is Num-1,
    fibonacci(Num1,F11,F21),
    F2 is F11,
    F1 is F11 + F21.

multiply(Num, Res):-
    multiply1(Num, Res).

multiply1(Num, Res):-
    (Num < 2 -> Res = [],
    0 is Num rem 2 -> Res = [X|Res1], 
    Num1 is Num div 2, 
    multiply1(Num1, Res1);
    multiply( Num, 2, Res)).
multiply(Num, X, Res):-( 
    Num < 2 -> Res = []; 
    X*X > Num -> Res = [Num]; 
    0 is Num rem X -> Res = [X|Res1], 
    Num1 is Num div X, 
    multiply( Num1, X, Res1);
    X1 is X+2, multiply( Num, X1, Res)).

sequence(Num,Res):-
    Num >= 1,
    factorial(Num,X),
    Last is 1/X,
    sequence1(Num,Res1,Last),
    Res is Res1.

sequence1(Num,Res,Last):-
    Num = 1, 
    Last = 1,
    Res = 1, !.

sequence1(Num,Res,Last):-
    Num > 1,
    Num1 is Num -1,
    Last1 is Last*Num,
    sequence1(Num1,Res1,Last1),
    Res is Res1 + Last.
    

factorial(Num, Res):- Num = 1, Res =1,!.

factorial(Num, Res):- 
    Num1 is Num -1,
    factorial(Num1,Res1),
    Res is Res1*Num.


nsd(0, N2, N2).
nsd(N1, 0, N1).

nsd(N1, N2, Res) :-  
    N1 >= N2, 
    M is N1 mod N2, 
    nsd(M, N2, Res), !.

nsd(N1, N2, Res) :-  
    N1 < N2, 
    M is N2 mod N1, 
    nsd(N1, M, Res).
