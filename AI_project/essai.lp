% Facts
node(V1;V2;V3).    % different node in PKN, input/transfert/output.
etage(C1;C2;C3).   % stage de cell in TE_early/medium/last.
pert(E,V,S,C).     % E:index of cell; V:role in PKN; S:0/1, valeur binaire; C: stage of cell.


% Generator
k{selgene(V):pert(E,V,S,C)}k.                                                   % tout les set avec k genes.
% ?????????????
% there, V means genes or node in PKN (V1,V2,V3).Je pense il y a beaucoup de V, mais avant seulement V1,V2,V3 sont declarer.
aff(E,V,S,C) :- selgene(V), pert(E,V,S,C).                                      % choisir tous les atoms de pert/4 avec genes de selgene/1.
egale(I,J,V) :- aff(I,V,S1,C1), aff(J,V,S2,C2), C1 < C2, S1==S2.                % egale/3: cell I is in stage avant cell J,avec meme valeur pour gene V.
countegale(I,J,M) :- M={egale(I,J,_)}, aff(I,_,_,C1),aff(J,_,_,C2), C1 < C2.    % M: number of genes de same valeur in cell I et cell J.
affinite(I,J) :- countegale(I,J,k), aff(I,_,_,C1),aff(J,_,_,C2), C1 < C2.       % pair of 2 cell I/J who have k genes de same valeur.
#maximize{1,I:affinite(I,_)}.                                                   % choose the set of k gene qui have maximum affinite/2 pair of cells .
#show selgene/1.
#show affinite/2.


% problem: determiner k
% essai 1
num(2..100)  % essai valeur de k a partir de k, maximum adapted ?
k{selgene(V):pert(E,V,S,C)}k :- num(k).
% ...
affinite(I,J,k).
#maximize{1,I:affinite(I,_,k)}.
% 花费时间太长，不一定要是最准确的，最优值附近就行。

% essai 2
% utilise Python, utilise loop for essayer different k et noter maximum, puis choisir le meilleur k.
% for loop for, on peut utiliser different methode pour accelerer. accelerer partie ASP ???
% 可以试试！！！！！

% ou on eaasi un grand echelle et determiner k par dimunier echelle. En theorie, k correspond de point ou la courbe dimunie le plus vite.

% problem: Je ne suis pas encore clair comment passer de cellule dataframe au atome, comme pert/4.
% on obtient d'abords des tuples correspondant? et apres utiliser directement in ASP ? Je pense it is plus vite <- moins de changement between Python et ASP

% ou on lit valeur S de chaque cellule in df, et touver E,V,C corespondant, puis atome ?


% solution

% lire patrix et ecrir dans un fiche sous forme atome voulais. et puis donner directement ce fiche dans clingo.