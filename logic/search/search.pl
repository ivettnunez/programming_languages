/* base case: current head is the item */
on(Item,[Item|Rest]).

/* keep finding */
on(Item, [Something|Tail]):-
  on(Item, Tail).

/*TESTS
  on(apples,  [pears, tomatoes, apples, grapes]).
*/



/*Append two lists*/

/*case when the first list is empty*/
append([], List2, List2).

append([Head|Tail], List2, [Head|Result]):-
  append(Tail, List2, Result).



/*TESTS
append([a,b,c],[one,two,three],Result).
*/
