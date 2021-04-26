film(tusk,kevinSmith,2012,annotation1).
film(jackAndJill,dennisDugan,2011,annotation2).
film(salt,phillipNoyce,2010,annotation3).
film(theTourist,florianHenckel,2010,annotation2).
film(crash,paulHaggis,2004,annotation3).
film(infamous,douglasMcGrath,2006,annotation3).
film(theWitch,robertEggers,2013,annotation3).
film(glass,paulHaggis,2019,annotation3).

actor(johnnyDepp, title, 1963, work_place).
actor(angelinaJolie, title2, 1975, work_place).
actor(sandraBullock, title, 1964, work_place2).
actor(anyaTaylorJoy, title3, 1996, work_place3).

played(tusk,johnnyDepp,guyLaPointe,episode).
played(jackAndJill,johnnyDepp,himself,main).
played(salt,angelinaJolie,evelynSalt,main).
played(theTourist,angelinaJolie,elise,main).
played(crash,sandraBullock,jeanCabot,episode).
played(infamous,sandraBullock,harperLee,episode).
played(theWitch,anyaTaylorJoy,tomasine,main).
played(glass,anyaTaylorJoy,caseyCooke,episode).

% films in which played actor X
%films_played_in(X,F):-
%played(F,X,_,_).

% actors who played main role in film X
%main_actor(X,A):-
%played(X,A,_,main).

% directors who worked with actors younger than
%dir_ever_worked(X,D):-
%film(F,D,Y1,_),
%played(F,A,_,_),
%actor(A, _, Y2, _),
%Y1-Y2 < X.

% directors who only worked with actors X or older than X years old
%dir_never_worked(X,D):-
%film(_,D,_,_),
%not(dir_ever_worked(X,D)).

% actors who played in films of director X
%actors_worked_with(X,A):-
%film(F,X,_,_),
%played(F,A,_,_).

% actors who have been playing in films since they were X years old or earlier
%actors_working_before(X,A):-
%played(F,A,_,_),
%actor(A, _, Y1, _),
%film(F,_,Y2,_),
%Y2 - Y1 =< X.
