/*Claudia Ivett Nunez Martinez A01700762
Login programming. Lab 1*/

/*Following facts are used for compatible predicate*/
hobby(juan,kaggle).
hobby(luis,hack).
hobby(elena,tennis).
hobby(midori,videogame).
hobby(simon,sail).
hobby(simon,kaggle).
hobby(laura,hack).
hobby(hans,videogame).

/*Predicate returns True if X and Y have the same Z value*/
compatible(X, Y):-
  hobby(X, Z),
  hobby(Y, Z).

/*TESTS
compatible(luis, laura).  RETURNS True because Luis and Laura like  hack
compatible(simon, hans).  RETURNS False because simon and hans did not share any hobby
compatible(midori, hans). RETURNS True because Midori and Hans like videgame
compatible(simon, juan). RETURNS False. because Simon and Juan like sail

Conclusion: Even that Simon has two hobbies, is the only person that likes sail so he cannot be compatible
with this hobbie with Z = sail the preducate will never return True. He is compaitible with Juan because of kaggle hobby
*/

/*Following facts are used for can_get_to predicate*/
road(placentia, ariminum).
road(ariminum, ancona).
road(ancona, roma).
road(genua, pisae).
road(pisae, roma).
road(brudisium, roma).
road(messana, capua).
road(capua, roma).
road(rhegium, messana).
road(catina, rhegium).
road(syracusae, catina).
road(lilibeum, messana).

/*Recursive predicate to check if there is a way to go from Origin to Destination.
Base case: I can arrive to the goal Destination with one step from the current Origin.
If the base case is false, I will look for a NewPlace where I can go from the current Origin and
check if by the NewPlace I can reach the goal Destination
*/
can_get_to(Origin, Destination):-
  road(Origin, Destination).

can_get_to(Origin, Destination):-
  road(Origin, NewPlace),
  can_get_to(NewPlace, Destination).


/*TESTS
can_get_to(lilibeum, capua).    TRUE becasue starting in lilibeum I can go then to messana and finally arrive to capua (goal Destination)
can_get_to(rhegium, roma).      TRUE because starting in rhegium I can go to messana, then got to capua, and capua to roma
can_get_to(pisae, roma).        TRUE because I can reach roma from pisae with only the base case execution
can_get_to(brudisium, pisae).   FALSE because from brudisium I can only go to roma

TESTS to demostrate that from every sity I can reach Rome
can_get_to(placentia, roma).
can_get_to(ariminum, roma).
can_get_to(ancona, roma).
can_get_to(genua, roma).
can_get_to(pisae, roma).
can_get_to(brudisium, roma).
can_get_to(messana, roma).
can_get_to(capua, roma).
can_get_to(rhegium, roma).
can_get_to(catina, roma).
can_get_to(syracusae, roma).
can_get_to(lilibeum, roma)
*/

/*Preducate that returns true if Val1 is lesser than Val2*/
comp(Val1, Val2):-
  Val1 < Val2.

/*Preducate to return the minimal value between three numbers.
It uses comp predicate as a helper predicate to compare each pair in the group of three values*/
min(A, B, C, Z):-
  comp(A, B),
  comp(A, C),
  Z is A.

min(A, B, C, Z):-
  comp(B, A),
  comp(B, C),
  Z is B.

min(A, B, C, Z):-
  comp(C, A),
  comp(C, B),
  Z is C.


/*TESTS
min(4, 3, 1, M).      M=1
min(4, 8, 6, M).      M=4
min(7, 5, 11, M).     M=5
min(2, -105, 14, M).  M=-105
min(9, 9, 9, M).   False because it did not match with any condition due that three values are the same number
*/

/*Predicate to get mayor and minor value between two input numbers. Used in gdc predicate */
maxim(A, B, Y, W):-
  A > B,
  Y is A,
  W is B.

maxim(A, B, Y, W):-
  B > A,
  Y is B,
  W is A.

/*Predicate to get the greatest common divisor between A and B using Euclidean algorithm
learned from: https://www.youtube.com/watch?v=AJn843kplDw */
gcd(A, B, Z):-
  A =:= 0,
  Z is B.

gcd(A, B, Z):-
  maxim(A, B, Mayor, Menor),
  NewVar is Mayor mod Menor,
  gcd(NewVar, Menor, Z).

/*TESTS
gcd(12, 30, Z)  RETURNS 6
gcd(216, 594, Z)  RETURNS 54
gcd(7, 876543, Z) RETURNS 1
*/
