% lector(kl,pib(surname,name,last_name),birth_date,level,kp,rate,work_place).
lector(1,pib("Глибовець","Андрій","Миколайович"),"12.02.1974","к.ф.н.",1,10000,"НаУКМА",1).
lector(2,pib("Глибовець","Микола","Миколайович"),"12.02.1952","д.ф-м.н.",1,9500,"НаУКМА",1).
lector(3,pib("Тригуб","Олександр","Семенович"),"12.02.1964","к.ф.н.",2,8700,"НаУКМА",1).
lector(4,pib("Бублик","Володимир","Васильович"),"12.02.1949","д.ф-м.н.",1,11500,"НаУКМА",2).
lector(5,pib("Лебідь","Вікторія","Олександрівна"),"12.02.1984","",2,7700,"НаУКМА",1).
lector(6,pib("Тимошкевич","Лариса","Михайлівна"),"12.02.1979","",1,8500,"НаУКМА",2).

% rozklad(kl,day,class,room).
rozklad(1,"пн",2,"22А").
rozklad(1,"пт",2,"22А").
rozklad(1,"вт",2,"25").
rozklad(2,"пт",1,"21А").
rozklad(3,"ср",3,"21А").
rozklad(3,"вт",1,"25").
rozklad(4,"пт",2,"23А").
rozklad(5,"чт",4,"22А").
rozklad(6,"вт",3,"25").
rozklad(6,"пт",2,"22А").

% posada(kp,name).
posada(1,"викладач").
posada(2,"асистент").

% facultet(kf,name,kl). kl-dekan
facultet(1,"ФІ",1).
facultet(2,"ФЕН",6).

% 6.В яких аудиторіях викладає певний викладач?
% ?- task_1(pib("Тимошкевич","Лариса","Михайлівна"),R).
task_1(X,L):-
setof(R,assist_1(X,R),L).

assist_1(PIB,R):-
lector(KL,PIB,_,_,_,_,_,_),rozklad(KL,_,_,R).


% 8.Для кожного наукового ступеня, включаючи його відсутність, визначити середню ставку викладачів.
% ?- task_2(R).
task_2(R):-
setof((X,Y),assist_2(X,Y),R).

assist_2(X,Y):-
lector(_,_,_,X,_,_,_,_),
rates(X,R),
mean(R,A),
Y is A.

% ставки усіх лекторів із ступенем L
rate(L,R):-
lector(_,_,_,L,_,R,_,_).

rates(L,R):-
findall(X,rate(L,X),R).

% сума
sum([], 0).          
sum([X|Xs], Total) :-   
    sum(Xs, T),
    Total is X + T.

% середнє арифметичне
mean(X, Avg) :-
sum(X, Total),
length(X, N),
Avg is Total / N.

% 3.Які викладачі (прізвище, ступінь, посада) читать в тих самих аудиторіях (хоча б в одній), що і певний викладач?
%  ?- task_3(pib("Глибовець","Андрій","Миколайович"),C).
%  ?- task_3(pib("Тимошкевич","Лариса","Михайлівна"),C).
task_3(L,Res) :- 
setof((Srn,Lvl,Psd),at_least_one(L,Srn,Lvl,Psd),Res).

% аудиторії в яких викладає L
rooms(L,R) :- 
lector(CL,L,_,_, _,_,_,_),
rozklad(CL,_,_,R).

% викладачі що викладають хоча б в одній аудиторії в якій викладає L
at_least_one(L,Srn,Lvl,Psd) :-  
lector(CodeL,L,_,_,_,_,_,_),
rooms(L,R),
rozklad(Code,_,_,R),
Code \= CodeL,
lector(Code,pib(Srn,_,_),_,Lvl,CodeP,_,_,_),
posada(CodeP,Psd).

%   Які викладачі (прізвище, факультет) читать в усіх тих аудиторіях, що і певний викладач
%  ?- task_4(pib("Глибовець","Микола","Миколайович"),C).
%  ?- task_4(pib("Глибовець","Андрій","Миколайович"),C).
task_4(L,Res) :- 
findall((Srn,F),all(L,Srn,F),Res).


all(L,Srn,F) :- 
lector(CodeL,L,_,_,_,_,_,_),
lector(Code,Srn,_,_,_,_,_,KF),
not(bad_lector(L,Code)),
CodeL \= Code,
facultet(KF,F,_).

bad_lector(L,Code) :- 
lector(_,L,_,_,_,_,_,_),
rooms(L,R),
lector(Code,_,_,_,_,_,_,_),
not(rozklad(Code,_,_,R)).

