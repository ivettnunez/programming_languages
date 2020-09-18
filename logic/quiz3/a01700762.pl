/*Knowledge base*/
len(70, agrt).
len(80, oids).
len(110, kjce).
len(120, trsdc).
len(250, sgkfp).

title([a,g,r,t], theBestVideo).
title([o,i,d], theShortestSong).
title([k,j,c,e], funnyVideo).
title([t,r,s,d,c], anotherVideo).
title([s,g,k,f,p], myTeavelToJapan).

channel([a,g,r,t], [c,h,o,k,f,r]).
channel([o,i,d], [c,h,o,k,f,r]).
channel([k,j,c,e], [c,h,o,k,f,r]).
channel([t,r,s,d,c], [c,h,e,d,r,t]).
channel([s,g,k,f,p], [c,h,e,d,r,t]).

/*Invert*/
invert(List, X):-
  invert_help(List, [], X).

invert_help([], X, X).
invert_help([H|T], Aux, X):-
  invert_help(T, [H|Aux], X).

/*Search*/
search(Item, [Item|Tail]).

search(Item, [Something|Tail]):-
  search(Item, Tail).

/*Difference*/
diff([], Something, []).

diff([Head1|Tail1], List2, [Head1|Result]):-
  search(Head1, List2),
  diff(Tail1, List2, Result).

diff([Head1|Tail1], List2, Result):-
  diff(Tail1, List2, Result).


new_id(Name, New):-
    title(OldId, Name),
	channel(OldId, ChannId),
    invert(OldId, Inv),
    diff(OldId, ChannId, Diff),
    merge(Inv, Diff, New).

/*TEST
new_id(theBestVideo, Res). RETURNS Res = [r, t, r, g, a]
*/



/*Not enough time for the second predicate*/

/*
fn([],[]).

fn([Name|Tail], [Name|Result]):-
    title(Name, Id),
    len(L, Id),
    L > 100,
    fn(Tail, Result).

fn([Something|Tail], Result):-
    fn(Tail, Result).

*/
