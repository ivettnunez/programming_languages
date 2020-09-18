/*LDFS*/

mov(3,8).
mov(3,4).
mov(3,9).
mov(3,6).
mov(4,5).
mov(4,7).
mov(4,'Salida').
mov(7,8).
mov(7,'Salida').
mov(8,9).

/* Search fro an Item in a list */
findItem(Item, [Item|_]).

findItem(Item, [_|Tail]):-
  findItem(Item, Tail).

/*Set an element into List*/
set_element(Item, List, [Item|List]).

/*Get the path (list) in the inverse order*/
invert(List, Res):-
	invert(List, [], Res).
invert([], Res, Res).
invert([Head|Tail], Z, Res):-
	set_element(Head, Z, L),
	invert(Tail, L, Res).

/*Base case: It already reached the goal*/
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


/* Starting point */
ldfs(Start, Goal, Level, Res):-
  Level > 0,
  helper_ldfs([], Start, Goal, Level, Temp),
  invert(Temp, Res).
