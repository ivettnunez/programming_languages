/*LDFS*/
/*KB*/
/*
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
mov(1,11).
mov(11,21).
mov(21,31).
mov(31,41).
*/
mov(11,1).
mov(21,11).
mov(31,21).
mov(41,31).
mov(23,13).
mov(33,23).
mov(43,33).
mov(53,43).
mov(63,53).
mov(73,63).
mov(14,4).
mov(75,65).
mov(85,75).
mov(95,85).
mov(16,6).
mov(26,16).
mov(36,35).
mov(46,36).
mov(58,48).
mov(68,69).
mov(79,69).
mov(13,14).
mov(26,27).
mov(27,28).
mov(28,29).
mov(31,32).
mov(32,33).
mov(35,36).
mov(40,41).
mov(46,47).
mov(47,48).
mov(63,64).
mov(64,65).
mov(65,66).
mov(66,67).
mov(67,68).
mov(68,58).
mov(70,71).
mov(71,72).
mov(72,73).
mov(95,96).
mov(96,97).
mov(14,13).
mov(27,26).
mov(28,27).
mov(29,28).
mov(32,31).
mov(33,32).
mov(36,26).
mov(41,40).
mov(47,46).
mov(48,47).
mov(64,63).
mov(65,64).
mov(66,65).
mov(67,66).
mov(68,67).
mov(69,68).
mov(71,70).
mov(72,71).
mov(73,72).
mov(96,95).
mov(97,96).
mov(1,99).
mov(4,99).
mov(6,99).



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
