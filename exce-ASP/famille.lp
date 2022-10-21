% list des personne
human(roger;cunegonde;marise;michel;yolande;dominique;gerard;richard;christine).
% 9 places
place(1..9).
% relation des place:voisin(next)->proche,on face
next(X,X+1):- place(X); place(X+1).
next(1,9).
face(2,9;3,8;4,7;5,6).

proche(X,Y) :- next(X,Y).
proche(X,Y) :- face(Y,X).

rangee(2,3;3,4;4,5).
rangee(6,7;7,8;8,9).
rangee(X,Y) :- rangee(Y,X).
rangee(X,Z) :- rangee(X,Y); rangee(Y,Z).

next(X,Y):-next(Y,X).
face(X,Y):-face(Y,X).

cheminee(5;6).
cuisine(1;10).

0{place(N,H):human(H)}1 :- place(N).
1{place(N,H):place(N)}1 :- human(H).

% contraine
:- pas_copain(H1,H2); place(X,H1); place(Y,H2); next(X,Y). % pas copain, ne sont pas next.
:- copain(H1,H2); place(X,H1); place(Y,H2); not next(X,Y).

1{place((6;9;2;5),christine)}1.
1{place((6;9;5;2),dominique)}1.

copain(gerard,(michel;richard)).
pas_copain(dominique,christine).
pas_copain(christine,(yolande;michel)).

:- place(X,christine); place(Y,dominique); not rangee(X,Y).  % ils ne sont pas rangee.
:- place(X,yolande); place(Y,richard); not next(X,Y).       % "not"?

soeur(marise;cunegonde;roger).
:- place(X,marise); place(Y,Fs):soeur(FS); next(X,Y).

:- place(X,marise); not cuisine(X).
:- place(X,cunegonde); not cuisine(X).
#show place/2.
