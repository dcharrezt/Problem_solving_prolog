use_module(library(readln)).

database
	vuelo(string,string, integer)
	visitado(string)
predicates
	ruta(string, string, integer)
	es_vuelo(string, string, integer)
	displayruta
	purgar
	encontar_ruta
	add_a_ruta(string)
	encontrar_mas_grande(string,string)
goal
	assert(vuelo(nueva_york,chicago,1000)),
	assert(vuelo(chicago,denver,1000)),
	assert(vuelo(nueva_york,toronto,800)),
	assert(vuelo(nueva_york,denver,1900)),
	assert(vuelo(toronto,calgary,1500)),
	assert(vuelo(toronto,los_angeles,1800)),
	assert(vuelo(toronto,chicago,500)),
	assert(vuelo(denver,urbana,1000)),
	assert(vuelo(denver,houston,1500)),
	assert(vuelo(houston,los_angeles,1500)),
	assert(vuelo(denver,los_angeles,1000)),
	encontrar_ruta,nl,
	write("mas? "),not(purgar),
	readln(Q),
	Q=n.
cluases
	encontrar_ruta:-
    	write("desde: "),
    	readln(A),
    	write("a: "),readln(B),
    	ruta(A,B,D),
    	write("la distacia es: ",D),nl,
    	not(display).

    ruta(A,B,C):-
    	es_vuelo(A,B,C).

	ruta(_,_,C):-
    	write("no hay ruta o no"),
    	nl,
    	write("esta dentro de la distancia especificada"),nl,
    	D=0,purgar.

	es_vuelo(T,T2,D):-
        vuelo(T,T2,D),
        add_a_ruta(T).

    es_vuelo(T,T2,D):-
        findsmallest(T,X),
        add_a_ruta(T),
        vuelo(T,X,D2),
        es_vuelo(X,T2,D3),
        D=D2+D3.

    es_vuelo(T,T2,D):-
        vuelo(T,X,D2),
        X<>T2,
        add_a_ruta(T),
        es_vuelo(X,T2,D3),
        D=D2+D3.

    findsmallest(A,B):-
      vuelo(A,X,D2),
      vuelo(A,Y,D2),
      X<>Y,
      D>D2,
      B=Y.
	add_a_ruta(T):-
    	not(visitado(T)),
    	assert(visitado(T)),!.
	add_a_ruta(_).
	purgar:-
    	retract((visitado(_))),
    	fail,!.
	displayruta:-
    	write("la ruta es: "),nl,
    	visitado(A),
    	write(A),nl,
    	fail,!.
