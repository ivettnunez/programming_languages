/*ANY POSITIVE*/
any_positive([]):-
  1 < 0.
any_positive([Head|Tail]):-
  number(Head),
  Head > 0;
  any_positive(Tail).


/* TESTS
any_positive([]).             RETURNS False
any_positive([a,b,c]).        RETURNS False because there are not any number to check
any_positive([-1, -2, -3, 4]) RETURNS True
any_positive([-1, -2, -3])    RETURNS False
*/



/*Helper predicate v1.0 to get the section of the list starting from the element Limit*/
count(N, N, List, List).

count(N, Limit, [Head|Tail], Result):-
  NewN is N+1,
  count(NewN, Limit, Tail, Result).

/*Helper predicate v2.0 to substitute all elements with the value of N starting from the element number 9*/
count2(N,N,[],[]).

count2(N, N, [Head|Tail], [9|Result]):-
  count2(N, N, Tail, Result).

count2(N, Limit, [Head|Tail], [Head|Result]):-
  NewN is N+1,
  count2(NewN, Limit, Tail, Result).

/*Helper predicate v3.0 to replace all items of a list with Val in a list starting from the Limit value*/
/*empezamos a recorrer hasta que llegamos a N igual al index y detenemos el acumulador para saber que a partir de ahi siempre de modificara el valor*/
count3(Val, N, N, [], []).

count3(Val, N, N, [Head|Tail], [Val|Result]):-
  count3(Val, N, N, Tail, Result).

count3(Val, N, Limit, [Head|Tail], [Head|Result]):-
  NewN is N+1,
  count3(Val, NewN, Limit, Tail, Result).


/* SUBSTITUTE */
substitute(Index, Val, List, Result):-
  count3(Val, 1, Index, List, Result).

/*TESTS
substitute(3,9,[1,2,3,4,5], Res) RETURNS [1,2,9,9,9]
substitute(4,10,[1,2,3,4,5], Res) RETURNS [1,2,3,10,10]
substitute(7,10,[1,2,3,4,5], Res) RETURNS False because index is out of range
substitute(-5,-3,[1,2,3,4,5], Res) RETURNS [1,2,3,4,-3]
substitute(-10,3,[1,2,3,4,5], Res) RETURNS False because index is not valid
*/

/* Search function is a helper predicate to Eliminate duplicates and to Intersecr predicates*/
findItem(Item, [Item|Tail]).

findItem(Item, [Something|Tail]):-
  findItem(Item, Tail).


/* ELIMINATE DUPLICATES */

/*List end*/
eliminate_duplicates([], []).

/*Do not add because finded*/
/* REMINDER/Aprendizaje: EL ORDEN ES IMPORTANTE!!!! */
eliminate_duplicates([Head|Tail], Result):-
  eliminate_duplicates(Tail, Result),
  findItem(Head, Result).

/*Add becasue not finded*/
eliminate_duplicates([Head|Tail], [Head|Result]):-
  eliminate_duplicates(Tail, Result).

/*TESTS
eliminate_duplicates([a,a,b,b,c,c,d,d],Result).    RETURNS [a,b,c,d] because a, b, c and d are duplicated elements in the list
eliminate_duplicates([a,a,a,a],Result).            RETURNS [a] because all elements in the list are tha character a
eliminate_duplicates([a,,b,c,d],Result)            RETURNS [a,b,c,d] the same input list because there are no any item duplicated
*/


/*INTERSECT*/
intersect([], Something, []).

intersect([Head1|Tail1], List2, [Head1|Result]):-
  findItem(Head1, List2),
  intersect(Tail1, List2, Result).

intersect([Head1|Tail1], List2, Result):-
  intersect(Tail1, List2, Result).

/*TESTS
intersect([a,b,c,d],[c,d,e,f],Result). RETURNS [c,d] because those are the common items in two lists
intersect([a,b,c],[a,b,c],Result). RETURNS [a,b,c] because both lists have the same items
intersect([a,b,c],[,d,e,f],Result).    RETURNS [] because there are not any common item between two lists
*/




/* INVERT */

invert(List, X):-
  invert_help(List, [], X).

/*Predicate that use an auxiliar list to build the original list in the inverse order*/
invert_help([], X, X).
invert_help([Head|Tail], Aux, X):-
  invert_help(Tail, [Head|Aux], X).

/* This was my firts attemp for invert predicate
invert([X], X).

invert([Head|Tail], [X|Head]):-
  invert(Tail, X).*/

/*TESTS
 invert([11,12,13,14,15,16,17,18,19,20,21], Res) RETURNS [21,20,19,18,17,16,15,14,13,12,11]
 invert([x,y,z,a,b,c], Res).                     RETURNS [c,b,a,z,y,x]
 invert([c,b,a,z,y,x], Res).                     RETURNS [x,y,z,a,b,c]
 invert([], Res).                                RETURNS [] because there are not elements to invert
*/


/*LESS THAN*/

less_than(N, [], []).

/* With this function I learn that with the "return" is implicit in the call */
less_than(N, [Head|Tail], [Head|Result]):-
  number(Head),
  N>Head,
  less_than(N, Tail, Result).

less_than(N, [Something|Tail], Result):-
  number(Head),
  less_than(N, Tail, Result).

/*TESTS
less_than(10, [2,4,6,12,14,16,10]) RETURNS [2,4,6]
less_than(10, [12,14,16]) RETURNS []
less_than(7, [a,b,c]) RETURNS False because the predicate validates that it the input value is a number
less_than(10, [12,2,14,4,16,6]) RETURNS [2,4,6]
*/



/*MORE THAN*/

more_than(N, [], []).

more_than(N, [Head|Tail], [Head|Result]):-
  number(Head),
  N<Head,
  more_than(N, Tail, Result).

more_than(N, [Something|Tail], Result):-
  number(Head),
  more_than(N, Tail, Result).

/*TESTS
more_than(10, [2,4,6,12,14,16], Res) RETURNS [12,14,16]
more_than(10, [2,4,6], Res) RETURNS []
more_than(5, [x,y,z]) RETURNS False because the predicate validates that it the input value is a number
more_than(10, [12,2,14,4,16,6], Res) RETURNS [12,14,16]
*/


/*ROTATE*/
/*If possitive rotation
rotate(List, R, X):-
  R > 0,
  new R. */

/*If negative rotation
rotate(List, R, X):-*/

/*
rotate([Head|Tail], X, Result):-
  X > 0,
  NewX is X-1,
  append(Tail, [Head], AuxList),
  rotate(AuxList, newX, Result).

rotate(List, X, Result):-
  X < 0,
  NewX is -X,
  rotate(Result, NewX, List).
  */

/*Helper predicates to parse list and set the Element into the final list when in the Rotate Predicate we know its position*/
count4(List,X):-
  count4(List, 0, X).

count4([], X, X).

count4([H|T], Curr, E):-
  NewCur is Curr+1,
  count4(T, NewCur, E).

getItem(List, Index, Element):-
  getItem(List, Index, 0, Element).

getItem([H|T], Current, Current, H).

getItem([H|T], Index, Current, Element):-
  dif(Index, Current),
  Current1 is Current+1,
  getItem(T, Index, Current1, Element).

set_first(Item, List, [Item|List]).

/**/
rotate(List, Pivot, X):-
  count4(List, Md),
  rotate(List, Pivot, 0, Md, X).

rotate(Md, W, Current, Current, []).

rotate(List, Pivot, Current, Md, X):-
  Acc is Pivot + Current,
  Item is Acc mod Md,
  getItem(List, Item, Z),
  Current1 is Current+1,
  rotate(List, Pivot, Current1, Md, Res),
  set_first(Z, Res, X).

/*TESTS
rotate([1,6,5,2,7], 3, Res). RETURNS Res = [2, 7, 1, 6, 5]
rotate([1,6,5,2,7], -3, Res). RETURNS Res = [5, 2, 7, 1, 6]
*/


/* BIDIRECTIONAL MAP */

/*Following facts are used for can_get_to predicate*/
road(placentia, ariminum).
road(ariminum, ancona).
road(ancona, roma).
road(genua,placentia).
road(genua, pisae).
road(pisae, roma).
road(capua, roma).
road(brundisium,capua).
road(messana, capua).
road(capua, roma).
road(rhegium, messana).
road(catina, rhegium).
road(syracusae, catina).
road(lilibeum, messana).

can_go(Origin, Dest):-
  road(Origin,Dest);
  road(Dest,Origin).

path(Origin,Dest,[Origin,Dest]):-
  can_go(Origin,Dest).

path(Origin,Dest,[Origin|Path]):-
  can_go(Origin,Mid),
  path(Mid,Dest,Path).

/*TESTS
 path(placentia,roma, Path). RETURNS Path = [placentia, ariminum, ancona, roma]
 path(genua,roma, Path).     RETURNS Path = [genua, placentia, ariminum, ancona, roma]
*/
