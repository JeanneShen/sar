next(0,9).
next(4,(3;5)).
next(6,(3;13;5)).
next(7,(0;1;2;3;8;12;13)).
next(8,(9;11)).
next(10,(9;11)).
next(11,(10;12)).
sound(4,10).

next(X,Y):-next(Y,X).
sound(X,Level-1) :- sound(Y,Level); next(X,Y); Level>= 0.
max(X,L) :- sound(X,L); not sound(X,L2):L2>L,sound(X,L2).
#show.
#show max/2.