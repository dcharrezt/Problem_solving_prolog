:- use_module(library(readln)).
:- use_module(library(clpfd)).

database
	vuelo(string,string,integer)
	visitado(string)
predicates
	ruta(string,string,integer)
	es_vuelo(string,string,integer)
	displayruta
	purgar
	encontrar_ruta
	anadir_a_ruta(string)
goal
	assert(vuelo(new_york, chicago, 1000)),
	assert(vuelo(chicago, denver, 1000)),
	assert(vuelo(new_york, toronto, 800)),
	assert(vuelo(new_york, denver, 1900)),
	assert(vuelo(toronto, calgary, 1500)),
	assert(vuelo(toronto, los_angeles, 1800)),
	assert(vuelo(toronto, chicago, 500)),
	assert(vuelo(denver, urbana, 1000)),
	assert(vuelo(denver, houston, 1500)),
	assert(vuelo(denver, los_angeles, 1000)),
	assert(vuelo(houston, los_angeles, 1500)),
	encontrar_ruta, nl,
	write("More "),
	readln(Q),
	Q = n.

encontrar_ruta:- /* not the minimum distance */
	write("from: "),
	readln(A),
	write("to: "), readln(B),
	ruta(A,B,D),
	write("The distance is ", D), nl,
	not(displayruta).

/* find route */
ruta(A,B,C):-
	es_vuelo(A,B,C).

ruta(_,_,D):-
	write("There isnt a route"),
	nl,
	write("Is between the distance"), nl,
	D = 0, purgar.

es_vuelo( T, T2, D):-
	vuelo( T, T2, D),
	anadir_a_ruta( T ).

/* hacer primero en anchura */
es_vuelo( T, T2, D):-
	vuelo( T, X, D2),
	vuelo( X, T2, D3),
	anadir_a_ruta( T ),
	anadir_a_ruta( X ),
	es_vuelo( X, T2, D3),
	D=D2+D3.
	
es_vuelo( T, T2, D):-
	vuelo( T, X, D2),
	diff(X,T2),
	anadir_a_ruta( T ),
	es_vuelo( X, T2, D3),
	D=D2+D3.

/* hacer primero en anchura */
es_vuelo( T, _, D ):-
	write( "Punto sin salida en ", T ).
	
/* Add to list of visited cities */
anadir_a_ruta(T):-
	not(visitado(T)),
	assert(visitado(T)),!.

anadir_a_ruta(_).

purgar:-
	retract(visitado(_)),
	fail,!.

displayruta:-
	write("The route is: "), nl,
	visitado(A),
	write(A), nl,
	fail,!.
