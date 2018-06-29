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
	X<>T2,
	anadir_a_ruta( T ),
	es_vuelo( X, T2, D3),
	D=D2+D3.

/* hacer primero en anchura */
es_vuelo( T, _, D ):-
	write( "Punto sin salida en ", T ),
