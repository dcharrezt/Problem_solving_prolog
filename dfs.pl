/* ver si hay conexion entre dos ciudades */
es_vuelo( T, T2, D):-
	vuelo( T, T2, D),
	anadir_a_ruta( T ).

es_vuelo( T, T2, D):-
	vuelo( T, X, D2),
	X<>T2,
	anadir_a_ruta( T ),
	es_vuelo( X, T2, D3),
	D=D2+D3.

es_vuelo( T, _, D ):-
	/* Informar de un punto sin salida para mostrar como progresa la busqueda */
	write( "Punto sin salida en ", T ),
	n1, D=0, fail.
