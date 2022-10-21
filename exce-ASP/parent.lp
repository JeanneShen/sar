% Facts
papa(jacques_dutronc,thomas_dutronc).  % J. Dutronc est le papa de T. Dutronc
papa(dark_vador,luke).  % Pareil pour dark vador et luke
papa(chronos,zeus).  % idem
papa(zurg,buzz).  % bref, vous avez compris
maman(metis,athena).  % pareil, mais pour les mamans
papa(zeus,athena).
papa(la_force,dark_vador).  % c'est ça ou les midichloriens :D
maman(shmi,dark_vador).
maman(padme,luke).
maman(jobal,padme).  % la famille Naberrie
papa(ruwee,padme).
maman(jobal,sola).  % Sola est la sœur de Padmé
papa(ruwee,sola).

% contraints
enfant(X,Y) :- papa(Y,X).
enfant(X,Y) :- maman(Y,X).
% #show enfant/2.

moi(X) :- papa(dark_vador,X).
moi(X) :- papa(zurg,X).
% #show moi/1.

papa(Y) :- papa(Y,_).
papapa(X) :- papa(Y,X); not papa(X).
% #show papapa/1.
1{meilleur_papa(P):papa(P))}1.
