use_module(library(readln)).

:- dynamic
	visitado/1.

vuelo(new_york, chicago, 1000).
vuelo(chicago, denver, 1000).
vuelo(new_york, toronto, 800).
vuelo(new_york, denver, 1900).
vuelo(toronto, calgary, 1500).
vuelo(toronto, los_angeles, 1800).
vuelo(toronto, chicago, 500).
vuelo(denver, urbana, 1000).
vuelo(denver, houston, 1500).
vuelo(denver, los_angeles, 1000).
vuelo(houston, los_angeles, 1500).

encontrar_ruta:- /* not the minimum distance */
	write('from: '),
	readln(A),
	write('to: '), readln(B),
	ruta(A,B,D),
	write(D), nl,
	displayruta.
		
/* find route */
ruta(A,B,C):-
	es_vuelo(A,B,C).

/* ver si hay conexion entre dos ciudades */
es_vuelo(T,T2,D):-
	vuelo(T,T2,D),
	anadir_a_ruta(T).

es_vuelo(T,T2,D):-
	vuelo(T,X,D2),
	dif(X,T2),
	anadir_a_ruta(T),
	es_vuelo(X,T2,D3),
	D=integer(D2)+integer(D3).

es_vuelo(T,_,D):-
	/* Informar de un punto sin salida para mostrar como progresa la busqueda */
	write(T),
	nl, D=0, fail.

/* Add to list of visited cities */
anadir_a_ruta(T):-
	not(visitado(T)),
	assert(visitado(T)),!.

anadir_a_ruta(_).

purgar:-
	retractall(visitado(_)).

displayruta:-
	write('The route is: '), nl,
	visitado(A),
	write(A), nl,
	fail,!.




