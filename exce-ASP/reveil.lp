%Data
position(1,1).                position(3,1). position(4,1). position(5,1).
position(1,2). position(2,2). position(3,2). position(4,2).
position(1,3). position(2,3).                position(4,3). position(5,3).
position(1,4). position(2,4). position(3,4).                position(5,4).
position(1,5). position(2,5). position(3,5). position(4,5). position(5,5).

milestone(1,5). % deux points, doit arriver
milestone(5,1).
start(1,1).
goals((1,1);(5,5)).
block((1,4),(1,5)). % acces impossible de (1,4) a (1,5)

#const path_max=100.
edge((X,Y),(I,J)) :- position(X,Y); position(I,J); |X-I|=0..1; |Y-J|=0..1; |X-I|+|Y-J|=1..2; not block((X,Y),(I,J)).
edge(G,endgoal) :- goals(G).
path(1,(X,Y)) :- start(X,Y).
0{path(N+1,E):path(N,S), edge(S,E), S != endgoal}1 :- path(N,_); N < path_max.
pathlen(N):-path(N,_); not path(N+1,_).
:- path(N,E); pathlen(N); not E=endgoal.  % continuer le path quand n'attind pas qu goals et on peut continuer
:- not path(_,(X,Y)); milestone(X,Y). 
% ignorer path qui ne passe pas point obligatoirs

#minimize{N:pathlen(N)}.

#show.
#show path/2.


