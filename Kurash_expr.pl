% приклади запитів
% ?- differentiate(ctg(x^2+x),x,R).
% R =  (x^(2-1)*2+1)*2/(2* -sin(2*(x^2+x))+1) .
% ?- differentiate(cos(x*10),x,R).
% R = - (10*sin(x*10)) .
% ?- differentiate(-1*sin(-5*x),x,R).
% R = -1*(-5*cos(-5*x)) .
% ?- differentiate(tg(x^(-2)),x,R).
% R = x^(-2-1)* -2*2/(2*cos(2*x^ -2)+1) .
% ?- differentiate(ex(x^(-2)),x,R).
% R = x^(-2-1)* -2*ex(x^ -2) .


% функції суми, різниці, добутку, частки
func_sum(X, X, 0).
func_sum(Y, 0, Y).
func_sum(X+Y, X, Y).
func_sum(2*X, X, Y) :- 
X == Y.
func_sum(W, X, Y) :-
number(X), number(Y), W is X + Y.

func_substract(X, X, 0).
func_substract(-Y, 0, Y).
func_substract(X-Y, X, Y).
func_substract(0, X, Y) :- 
X == Y.
func_substract(W, X, Y) :-
number(X), number(Y), W is X - Y.

func_multiply(0, 0, _).
func_multiply(0, _, 0).
func_multiply(Y, 1, Y).
func_multiply(X, X, 1).
func_multiply(X*Y, X, Y).
func_multiply(Y, X, Y) :-
X == 1.
func_multiply(W, X, Y) :-
number(X), number(Y), W is X * Y.
	
func_divide(0, 0, N).
func_divide(X, X, 1).
func_divide(X/Y, X, Y).
func_divide(1, X, Y) :-
X == Y.
func_divide(W, X, Y) :-
number(X), number(Y), W is X / Y.

% похідні
% константа
differentiate(E, _, 0) :- 
number(E).

% однакові змінні
differentiate(E, B, 0) :- 
atom(E), E \== B.
	
% різні змінні
differentiate(E, B, 1) :- 
atom(E), E == B.

% похідна від суми функцій
differentiate(A1 + A2, B, W) :- 
differentiate(A1, B, Ad1),
differentiate(A2, B, Ad2),
func_sum(W, Ad1, Ad2).

% похідна від різниці функцій
differentiate(A1 - A2, B, W) :- 
differentiate(A1, B, Ad1),
differentiate(A2, B, Ad2),
func_substract(W, Ad1, Ad2).

% похідна від добутку функцій
differentiate(A1 * A2, B, W) :- 
differentiate(A1, B, Ad1),
differentiate(A2, B, Ad2),
func_multiply(L, Ad1, A2),
func_multiply(P, A1, Ad2),
func_sum(W, L, P).

% похідна від частки функцій
differentiate(A1 / A2, V, E) :- 
differentiate(A1, V, Ad1),
differentiate(A2, V, Ad2),
func_multiply(A, Ad1,A2),
func_multiply(B, A1,Ad2),
func_multiply(C, A2,A2),
func_substract(D, A, B),
func_divide(E, D,C).

% похідна функції від функції
% sin
differentiate(sin(A), V, M) :-
differentiate(A,V, Ad), 
func_multiply(M, Ad, cos(A)).

% cos
differentiate(cos(A), V, K) :-
differentiate(A,V, Ed),
func_multiply(M, Ed,sin(A)),
func_substract(K, 0, M).

% tg
differentiate(tg(E), V, F) :-
differentiate(E,V, Ed),
func_multiply(A, Ed, 2),
func_multiply(B, 2, E),
func_multiply(C, 2, cos(B)),
func_sum(D, C, 1),
func_divide(F, A, D).

% ctg
differentiate(ctg(E), V, F) :-
differentiate(E,V, Ed),
func_multiply(A, Ed, 2),
func_multiply(B, 2, E),
func_multiply(C, 2, -sin(B)),
func_sum(D, C, 1),
func_divide(F, A, D).

% e^x
differentiate(ex(E), V, F) :-
differentiate(E,V, Ed),
func_multiply(F, Ed, ex(E)).

% похідна функції, піднесеної до степеню, що рівний функції
differentiate(F^G, V, FF) :-
differentiate(F, V, Fd),
differentiate(G, V, Gd),
func_substract(AA, G, 1),
func_multiply(BB, G,Fd),
func_multiply(CC, Gd, F),
func_multiply(DD, CC, log(F)),
func_sum(EE, BB, DD),
func_multiply(FF, F^(AA), EE).

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


