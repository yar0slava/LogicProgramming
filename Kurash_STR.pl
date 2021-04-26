[played(film(tusk,kevinSmith,2012,annotation1),actor(johnnyDepp, title, 1963, work_place),guyLaPointe,episode),
played(film(jackAndJill,dennisDugan,2011,annotation2),actor(johnnyDepp, title, 1963, work_place),himself,main),
played(film(salt,phillipNoyce,2010,annotation3),actor(angelinaJolie, title2, 1975, work_place),evelynSalt,main),
played(film(theTourist,florianHenckel,2010,annotation2),actor(angelinaJolie, title2, 1975, work_place),elise,main),
played(film(crash,paulHaggis,2004,annotation3),actor(sandraBullock, title, 1964, work_place2),jeanCabot,episode),
played(film(infamous,douglasMcGrath,2006,annotation3),actor(sandraBullock, title, 1964, work_place2),harperLee,episode),
played(film(theWitch,robertEggers,2013,annotation3),actor(anyaTaylorJoy, title3, 1996, work_place3),tomasine,main),
played(film(glass,paulHaggis,2019,annotation3),actor(anyaTaylorJoy, title3, 1996, work_place3),caseyCooke,episode)].

% films in which played actor X
%films_played_in(X,F):-
%played(F,actor(X,_,_,_),_,_).

% actors who played main role in film X
%main_actor(X,A):-
%played(film(X,_,_,_),A,_,main).

% directors who worked with actors younger than
%dir_ever_worked(X,D):-
%played(film(_,D,Y1,_),actor(_, _, Y2, _),_,_),
%Y1-Y2 < X.

% directors who only worked with actors X or older than X years old
%dir_never_worked(X,D):-
%played(film(_,D,_,_),_,_,_),
%not(dir_ever_worked(X,D)).

% actors who played in films of director X
%actors_worked_with(X,A):-
%played(film(_,X,_,_),A,_,_).

% actors who have been playing in films since they were X years old or earlier
%actors_working_before(X,A):-
%played(film(_,_,Y2,_),actor(A, _, Y1, _),_,_),
%Y2 - Y1 =< X.
