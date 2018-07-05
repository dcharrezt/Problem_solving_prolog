#!/usr/bin/swipl -f -q

writenlist([]):-
    nl.

writenlist([H|T]):-
    write(H),
    write(' '),
    writenlist(T).

reverse_writenllist([]).

reverse_writenllist([H|T]):-
    reverse_writenllist(T),
    write(H),
    nl.  

member(X,[X|_]).

member(X,[_|T]):-
    member(X,T).

opposite(e,w).

opposite(w,e).

unsafe(state(X, Y, Y, _)) :-
    opposite(X,Y).

unsafe(state(X, _, Y, Y)) :-
    opposite(X,Y).

move(state(X, X, G, C), state(Y, Y, G, C)):- 
    opposite(X,Y),
    not(unsafe(state(Y, Y, G, C))),
    writenlist(['Try farmer takes wolf ', Y, Y, G, C]). 

move(state(X, W, X, C), state(Y, W, Y, C)):- 
    opposite(X,Y),
    not(unsafe(state(Y, W, Y, C))),
    writenlist(['Try farmer takes goat ', Y, W, Y, C]). 

move(state(X, W, G, X), state(Y, W, G, Y)):- 
    opposite(X, Y),
    not(unsafe(state(Y, W, G, Y))),
    writenlist(['Try farmer takes cabbage ', Y, W, G, Y]). 

move(state(X, W, G, C), state(Y, W, G, C)):- 
    opposite(X, Y),
    not(unsafe(state(Y,W,G,C))),
    writenlist(['Try farmer takes self ', Y, W, G, C]). 

move(state(F, W, G, C), state(F, W, G, C)):- 
    writenlist(['    Bactrack from: ', F, W, G, C]),
    fail. 

path(Goal, Goal, List):-
    write('Solution Path is: '),
    nl,
    reverse_writenllist(List).

path(State, Goal, List):-
    move(State, NextState),
    not(member(NextState, List)),
    path(NextState, Goal, [NextState|List]),
    !.

:-  
    path(state(e,e,e,e), state(w,w,w,w),[state(e,e,e,e)]),
    halt(0).
