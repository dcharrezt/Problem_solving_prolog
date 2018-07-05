/*el granjero, el pollo, la zorra y el grano*/
database
 orillaizquierda(symbol)
 orilladerecha(symbol)
 gposicion(symbol)
predicates
	mover(symbol)
	legal
	rio_atravezado
	rio
	navegar(symbol,symbol)
	disponer
	transportizquierda(symbol,integer,integer,integer)
	transportderecha(symbol,integer,integer,integer)
	checkgranjero
	movergranjero(integer)
goal
	assert(orilladerecha(pollo)),
	assert(orilladerecha(grano)),
	assert(orilladerecha(zorra)),
	rio_atravezado.
	
clauses
	/*llevar todo a la orilla izquierda*/
	rio_atravezado:-
		disponer,
		orilladerecha(X),
		mover(X),
		orillaizquierda(pollo),
		orillaizquierda(zorra),
		orillaizquierda(grano),
		cursor(20,8),
		write("todo en la orilla izquierda"),nl,nl.
	/*intentar un movimiento*/
	mover(X):-
		checkgranjero,
		assert(orillaizquierda(X)),
		retract(orilladerecha(X)),
		navegar(X,izquierda),
		legal,!.         /*ver si es una combinacion permitida*/
	mover(X):-
	/*Si esta clausula se ejecuta entonces el anterior mover creo una*/
	/*situacion inaceptable por lo tanto el granjero debe mover algo a su posicion anterior*/
		orillaizquierda(Y), Y<>X,
		retract(orillaizquierda(Y)),
		navegar(Y,derecha),
		assert(orilladerecha(Y)),!.

	mover(X):-
		retract(orillaizquierda(X)),
		navegar(X,derecha),
		assert(orilladerecha(X)).

	/* ver si over es una combinacion legal*/
	legal:-
		orillaizquierda(zorra),
		orillaizquierda(grano).

	legal:-
		orilladerecha(grano),
		orilladerecha(zorra).

/***********RUTINAS GRAFICAS*************/

	rio:- /*dibijar rio*/
		line(5000,12000,25000,12000,2),
		line(5000,18000,25000,18000,2).

	/*disponer para atravesar*/
	navegar(zorra,izquierda):-
		transportizquierda(zorra,9,25,5).
	navegar(pollo,izquierda):-
		transportizquierda(pollo,12,25,5).
	navegar(grano,izquierda):-
		transportizquierda(grano,15,25,5).
	navegar(zorra,derecha):-
		transportderecha(zorra,9,5,25).
	navegar(pollo,derecha):-
		transportderecha(pollo,12,5,25).
	navegar(grano,derecha):-
		transportderecha(grano,15,5,25).

	/*animar el cruce hacia la izquierda*/
	transportizquierda(T,X1,Y1,Y2):-
		Y1=Y2,
		cursor(X1,Y1),
		write("      "),
		cursor(X1,Y1),
		write(T),
		cursor(6,Y1),
		write("      "),
		cursor(6,Y1),
		write("granjero"),
		assert(gposicion(izquierda)),!.
	transportizquierda(T,X1,Y1,Y2):-
		cursor(X1,Y1),
		write("      "),
		cursor(X1,Y1),
		write(T),
		cursor(6,Y1),
		write("      "),
		cursor(6,Y1),
		write("granjero"),
		Z=Y1-1,rio,
		transportizquierda(T,X1,Z,Y2).

	/*animar el cruce hacia la derecha*/
	transportderecha(T,X1,Y1,Y2):-
		Y1=Y2,
		Temp=Y1-1,
		cursor(X1,Temp),
		write("      "),
		cursor(X1,Y1),
		write(T),
		cursor(6,Temp),
		write("      "),
		cursor(6,Y1),
		write("granjero"),
		retract(gposicion(izquierda)),!.
	transportderecha(T,X1,Y1,Y2):-
		Temp=Y1-1,
		cursor(X1,Temp),
		write("      "),
		cursor(X1,Y1),
		write(T),
		cursor(6,Temp),
		write("      "),
		cursor(6,Y1),
		write("granjero"),
		Z=Y1+1,rio,
		transportderecha(T,X1,Z,Y2).

	/*estado incial*/
	disponer:-
		graphics(1,1,0),
		rio,
		cursor(6,25), write("granjero"),
		cursor(9,25), write("zorra"),
		cursor(12,25), write("pollo"),
		cursor(15,25), write("grano"),
		cursor(0,4),
		write("granjero, zorra, pollo y grano").

	/*¿Necesitas mover el granjero?*/
	checkgranjero:-
		not(gposicion(izquierda)).
	checkgranjero:-
		movergranjero(5).

	/*mover granjero por si mismo*/
	movergranjero(Y):-
		Y=25,
		cursor(6,24),
		write("      "),
		cursor(6,25),
		write("granjero"),
		retract(gposicion(izquierda)),rio,!.
	movergranjero(Y):-
		Temp =Y-1,
		cursor(6,Temp),
		write("      "),
		cursor(6,Y),
		write("granjero"),
		Z=Y+1,rio,
		movergranjero(Z).
