

% Виробники товарів
% manufacturer(manufacturer_name,country)
manufacturer("Farmak","Ukraine").
manufacturer("Darnitsya","Ukraine").
manufacturer("Bayer","Germany").
manufacturer("JOHNSON AND JOHNSON","USA").

% Товари
% goods(id_goods,name,last_date,price,receipt,temperature,photosensitivity,manufacturer_name)
goods(1111,"Spasmalgon",date( 23, 3, 2023), 233, false, 20, true,"Farmak").
goods(1112,"Analgin", date( 23, 3, 2022), 255, true, 21, true,"Darnitsya").
goods(1113,"Farmazevt",date( 23, 3, 2025), 100, false, 20, false,"Farmak"). 
goods(1114,"Sonid",date( 23, 3, 2026), 99, true, 22, true,"Farmak"). 
goods(1115,"Validol",date( 23, 3, 2025), 23, true, 23, false,"Bayer"). 
goods(1116,"Tsytramon",date( 23, 3, 2021), 69, true, 26, true,"Bayer"). 
goods(1117,"Checking",date( 23, 3, 2021), 69, true, 26, true,"Bayer"). 

% Чеки
% check(check_id, pharm_id, date_of_purchase,sum,cash)
check(123,666,date( 5, 5, 2020),233,true).
check(124,555,date( 6, 5, 2020),85,false).
check(125,444,date( 5, 4, 2019), 100 ,true).
check(126,666,date( 23, 3, 2020),133,false).
check(127,666,date( 5, 5, 2020),233,true).
check(128,555,date( 6, 5, 2020),122,false).
check(129,666,date( 5, 4, 2019), 500,true).
% чек, що містить усі препарати дорожчі за 200
check(120,444,date( 23, 3, 2020),133,false).
% чек, що містить усі препарати дорожчі за 98 
% та всі препарати дорожчі за 200
check(121,444,date( 23, 3, 2020),133,false).

% Покупка
% purchase(id_goods, check_id, sold_amount)
purchase(1111, 120, 4).
purchase(1112, 120, 2).
purchase(1113, 123, 3).
purchase(1114, 124, 1).
purchase(1115, 125, 1).
purchase(1116, 126, 2).
purchase(1113, 127, 4).
purchase(1115, 128, 5).
purchase(1112, 129, 2).
purchase(1114, 129, 1).
purchase(1111, 121, 4).
purchase(1112, 121, 2).
purchase(1113, 121, 4).
purchase(1114, 121, 2).

% Фармацевт
% pharmacist(tab_num,pib(last_name,first_name),position,education(),phone_number[])
% pib(last_name,first_name)
% education(average, bachelor , master)
pharmacist(666,pib("Kovalenko","Lydmila"),zaviduvach,education(average,bachelor,nill),["0630659875","0932569872"]).
pharmacist(555,pib("Gudimenko","Nataliya"),pharmacist,education(average,nill,nill),["0630123475"]).
pharmacist(444,pib("Babich","Valentina"),pharmacist,education(average,bachelor,nill),["0630659875","0932598765"]).

% Підвищення кваліфікації фармацевта
% qualification(category,date,tab_num)
qualification("second",date( 11, 2, 2017),666).
qualification("first",date( 30, 1, 2013),666).
qualification("high",date( 23, 3, 2021),666).
qualification("first",date( 5, 6, 2016),555).
qualification("second",date( 4, 5, 2020),555).
qualification("second",date( 13, 1, 2019),444).

%оператори

%свілочутливий товар 
% TEST
% ?- photosensitive 1111.
% true.
% ?- photosensitive 1113.
% false.

:- op(500, fx, photosensitive).
photosensitive(X):-
goods(X,_,_, _, _,_,true,_).


% фармацевт із вказаним рівнем освіти
% TEST
% ?- 666 has_edu_lvl bachelor.
% true.
% ?- 555 has_edu_lvl bachelor.
% false.

:- op(500, xfx, has_edu_lvl).
has_edu_lvl(X,E):-
pharmacist(X,_,_,education(E,_,_),_);
pharmacist(X,_,_,education(_,E,_),_);
pharmacist(X,_,_,education(_,_,E),_).

% чеки оплачені готівкою
% TEST
% ?- in_cash 123.
% true.
% ?- in_cash 123.
% false.

:- op(500, fx, in_cash).
in_cash(X):-
check(X,_,_,_,true).

% 1. Знайти товари, температура зберігання яких менша X
% query1(+температура,-результат).

% TEST
% ?- query1(23,R).
% R = "Spasmalgon" ;
% R = "Analgin" ;
% R = "Farmazevt" ;
% R = "Sonid"

query1(X,R) :- goods(_,R,_,_, _, T, _,_), T<X.

% 2. Знайти товари в яких термін придатності сплине через X1 
% або менше місяців від X2 місяця поточного року
% query2(+ кількість місяців через які сплине термін придатності 
%       + місяць поточного року ,- ID товару , - назва).

% TEST
% ?- query2(5,6,X,Y).
% X = 1116,
% Y = "Tsytramon" ;
% X = 1117,
% Y = "Checking".

query2(X1,X2,ID,Name):-
goods(ID,Name,date(_,M,Y),_,_,_,_,_),
Years is (Y-2021)*12,
Months is Years + M - X2,
Months =< X1.

% > 3. Знайти всі здобуті категорії фармацевта за табельним номером
% query3(+табельний номер,-результат).

% TEST
% ?- query3(666,R).
% R = "second" ;
% R = "first" ;
% R = "high".

query3(X,R) :- 
qualification(R,_,X).

% 4. Знайти сумарну вартість чеків, які були оплачені готівкою

% TEST
% query4(-результат).
% ?- query4(R).
% R = 1066.

query4(Sum):-
list_of_sums(L),
sum(L,Sum).

% список сум ченів, оплачених готівкою
list_of_sums(L):-
findall(X,check(_,_,_,X,true),L).

% сума елементів списку
sum([], 0).          
sum([X|Xs], Total) :-   
    sum(Xs, T),
    Total is X + T.

% 5. Знайти фармацевта, який продав ті товари, що і X
% query5(+імя,+прізище, -результат).

% TEST
% ?- query5("Lydmila","Kovalenko",R).
% R = [pib("Babich", "Valentina"), pib("Gudimenko", "Nataliya")].

query5(I,P,L) :- setof(R,query51(I,P,R),L).

query51(I,P,R) :- 
pharmacist(PN,pib(P,I),_,_,_),
check(Check_n,PN,_,_,_),
purchase(Qoods_id, Check_n, _),
purchase(Qoods_id, Check_n2, _),
check(Check_n2,PN2,_,_,_),
pharmacist(PN2,R,_,_,_),
PN \= PN2.


% 6. Знайти чеки в яких містять тільки укр товари (тільки ті) 
% чеки, які не містяь укр товари
% query6(-результат).

% TEST
% ?- query6(D).
% D = [120, 121, 123, 124, 127, 129].

query6(Result) :- 
setof((Codes),
onlyInGroupSet(Codes),Result).

foreignGoods(R) :- 
manufacturer(Manufacturer_name,S),S \= "Ukraine",
goods(Id_goods,_,_,_,_,_,_,Manufacturer_name),
purchase(Id_goods,R, _).

atLeastOneUkraine(R) :-  
manufacturer(Manufacturer_name,"Ukraine"),
goods(Id_goods,_,_,_,_,_,_,Manufacturer_name),
purchase(Id_goods,R, _).

onlyInGroupSet(Codes) :- 
atLeastOneUkraine(Codes),
not(foreignGoods(Codes)).


% 7. Знайти виробників, що вироблять усі ті та тільки ті препарати, що продаються за рецептом
% query7(-результат).

% TEST
% ?- query7(R).
% R = "Bayer" ;

query7(X) :- 
manufacturer(X,_),
not(producesNotAll(X)),
not(badManufacturer(X)).

% виробники, що виробляють препарати за рецептом
badManufacturer(X) :- 
goods(_,_,_,_,false,_,_,X).

% всі препарати, що продають за рецептом
allWithReceipt(R):-
goods(R,_,_,_,true,_,_,_).

% виробники, що виробляють не всі препарати, що продають за рецептом
producesNotAll(X):- 
manufacturer(X,_),
allWithReceipt(GC),
not(goods(GC,_,_,_,_,_,_,X)).

% 8. Знайти чеки, в яких містяться всі препарати вартістю більше Х
% query8(+вартість,-результат).

% TEST
% ?- query8(200,R).
% R = check(120, 444, date(23, 3, 2020), 133, false) ;
% R = check(121, 444, date(23, 3, 2020), 133, false).
% ?- query8(100,R).
% R = check(120, 444, date(23, 3, 2020), 133, false) .
% ?- query8(98,R).
% R = check(121, 444, date(23, 3, 2020), 133, false).

query8(X,check(CH_ID,A,B,C,D)):-
check(CH_ID,A,B,C,D),
not(badChecks(X,CH_ID)).

%чеки, що не містять якийсь із препаратів вартістю більше Х
badChecks(X,CH_ID):-
goods(ID,_,_,Price,_,_,_,_),
Price > X,
checkWithout(ID,CH_ID).

%чеки, що містять препарат Х
checkWith(X,CH_WITH):-
purchase(X,CH_WITH,_).

%чеки, що не містять препарат Х
checkWithout(X,CH_ID):-
check(CH_ID,_,_,_,_),
not(checkWith(X,CH_ID)).