family(family_member(tomm, fox, date( 7, may, 1950), works(bbc,15200)),
              family_member(ann, fox, date( 9, may, 1966), unemployed),
              [family_member(pat, fox, date( 5, may, 1973), unemployed),
              family_member(jull, fox, date( 5, may, 1973), unemployed)]).


husband(X) :-                          
family(X,_,_).

wife(X) :-                         
family(_,X,_).

child(X) :-                    
family(_,_,Children),
belongs(X,Children).

belongs(X,[X|L]).

belongs(X,[Y|L]) :-
belongs(X,L).

exist(Family_member) :-
husband(Family_member);
wife(Family_member);
child(Family_member).

birthday(family_member(_,_,Date, _ ),Date).

income(family_member(_,_,_,works(_,S)),S).
income(family_member(_,_,_,unemployed),0).

overall_income([],0).
overall_income([person|list],sum):-
income(person,S),
overall_income(list,rest),
sum is S + rest.

% exist(family_member(Name,Surname,_,_)).

% 1
% child(X), birthday(X,date(_,_,1981)).

% 2
% wife(family_member(Name,Surname,_,unemployed)).

% 3
% exist(family_member(Name,Surname,date(_,_,Year),unemployed)),
% 2021 - Year < 60.

% 4
% exist(Family_member),
% birthday(Family_member,date(_,_,Year)),
% Year < 1961,
% income(Family_member,Income),
% Income < 10000.

% 5
% family(family_member(_,Surname,_,_),_,[_,_,_|_]).

% 6
% family(family_member(_,Surname,_,_),_,[]).

% 7
% child(family_member(Name,Surname,_,works(_,_))).

% 8
% family(family_member(_,Surname,_,unemployed),family_member(_,_,_,works(_,_)),_).

% 9
% family(family_member(_,_,date(_,_,Year1),_),family_member(_,_,date(_,_,Year2),_),Children),
% (Year2 - Year1 > 15;
% Year1 - Year2 > 15).