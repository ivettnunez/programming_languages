/*Claudia Ivett Nunez Martinez   A01700762*/

/*Knowledge base used to learn DFS algorithm and to build LDFS algorithm*/
mov(3,8).
mov(3,4).
mov(3,9).
mov(3,6).
mov(4,5).
mov(4,7).
mov(4,11).
mov(7,8).
mov(7,10).
mov(8,9).

/*DFS*/
/*
member(X,[X|_]). %If head is X, true, el se False
member(X, [_|T]):- member(X,T).

empty_stack([]).

member_stack(E, S):- member(E,S).

stack(E, S, [E|S]).

go(Start, Goal, Limit) :-
	empty_stack(Empty_been_list),
	stack(Start, Empty_been_list, Been_list),
	path(Start, Goal, Been_list, Limit).

% path implements a depth first search in PROLOG

% Current state = goal, print out been list
path(Goal, Goal, Been_list, Limit) :-
  get_depth(Goal, CurrentD).
  Limit >= CurrentD,
	reverse_print_stack(Been_list).

path(State, Goal, Been_list, Limit) :-
	mov(State, Next),
	% not(unsafe(Next)),
	not(member_stack(Next, Been_list)),
	stack(Next, Been_list, New_been_list),
  get_depth(Next, CurrentD),
  Limit >= CurrentD,        % Tal vez aplica el cut operator
	path(Next, Goal, New_been_list), !. % Aqui ocurre backtracking porque es quien revisa si hay mov

reverse_print_stack(S) :-
	empty_stack(S).
reverse_print_stack(S) :-
	stack(E, Rest, S),
	reverse_print_stack(Rest),
	write(E), nl.*/


/* Search is a helper predicate to Eliminate duplicates and to Intersecr predicates*/
findItem(Item, [Item|Tail]).
findItem(Item, [Something|Tail]):-
  findItem(Item, Tail).

/*Return inverted path using helper predicate*/
ldfs(Start, Goal, Level, Res):-
  helper_ldfs([], Start, Goal, Level, Temp),
  invert(Temp, Res).

/*Set an element into List*/
set_element(Item, List, [Item|List]).

/*Invert predicate is used to get the path (list) in the inverse order*/
invert(List, Res):-
	invert(List, [], Res).
invert([], Res, Res).
invert([H|T], Z, Res):-
	set_element(H, Z, L),
	invert(T, L, Res).

/*LDFS*/

/*Base case: It already achieved the goal*/
helper_ldfs(Path, Start, Goal, _, [Goal|[Start|Path]]):-
  mov(Start,Goal).

/*Recursive predicate to check that the new level that will be expanded is valid
  Then check if there is a node to move from the Current node (Start at the first call) to another (at some point could be the Goal) and it has been not visited yet
	Finally do the recusrive call*/
helper_ldfs(Path, Start, Goal, Level, Res):-
  NewLevel is Level - 1,
  NewLevel > 0,
  mov(Start, X),
	not(findItem(X, Path)),
  helper_ldfs([Start|Path], X, Goal, NewLevel, Res).

/*TESTS
ldfs(3, 10, 5, Path).    RETURNS Path=[3,4,7,10]
ldfs(3, 10, 2, Path).    RETURNS False because the goal level is greater tha the input Level

ldfs(4, 9, 3, Path).    RETURNS Path=[4,7,8,9]

*/



/*QUICK SORT*/

/*Initial step*/
quick_sort(List,Sorted):-
	helper_qs(List,[],L), invert(L,Sorted).

helper_qs([], Aux, Aux).
helper_qs([H|T], Aux, Sorted):-
	pivot(H,T,L1,L2),
	helper_qs(L1,Aux,Sorted1),
	helper_qs(L2,[H|Sorted1],Sorted).

/*Select an element as pivot used to divide the list*/
pivot(H,[],[],[]).
pivot(H,[X|T],[X|L],G):-X=<H,pivot(H,T,L,G).
pivot(H,[X|T],L,[X|G]):-X>H,pivot(H,T,L,G).


/* TESTS
quick_sort([8,6,5,4], Res).       RETURNS [4,5,6,8]
quick_sort([45,76,100,2], Res).   RETURNS []2,45,76,100

*/
