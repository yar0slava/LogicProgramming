div_mod(Num, Divider, Result, Remainder) :-
        Num >= 0, Divider > 0, div_mod1(Num, Divider, 0, Result, Remainder).

div_mod1(Num, Divider, Result, Result, Remainder) :-
        Num < Divider, Remainder = Num, !.

div_mod1(Num, Divider, Result0, Result, Remainder) :-
    Num1 is Num - Divider, Result1 is Result0 + 1, 
    div_mod1(Num1, Divider, Result1, Result, Remainder).


pow(_,Grade,Result) :- Grade=0, Result=1,!.

pow(Num,Grade,Result):-  G is Grade-1,
                        pow(Num, G, Result1), 
                        Result is Num*Result1.

sqrt(Num, Res) :- Num >=0, Res>=0, sqrt1(Num,Res,Num).

sqrt1(Num,Res,Res1) :- Mul is Res1*Res1, (Mul - Num) < 0, !.

sqrt1(Num,Res,Res1) :- 
                 Div = Num/Res1,
                 Sum = Res1 + Div,
                 Res2 is Sum/2,
                 sqrt1(Num, Res, Res2).