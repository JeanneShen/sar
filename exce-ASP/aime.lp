aime("Gérard",("Joueur du Grenier";"Les pois cassés")).
aime("Julie",("Les pois cassés";"Star Wars 9: les siths fantôme contre-retournent l'espoir")).
aime("Marlène",("Les chansons des années 20";"Symballium volume 4";"les roses vertes")).
aime("Michel",("La grande musique (dans le sens de la longueur)";"Star Wars 9: les siths fantôme contre-retournent l'espoir")).
aime("Dominique",("La grande musique (dans le sens de la longueur)";"les roses vertes";"Les poids cassés";"Symballium volume 4")).

{people(P):aime(P,_)}.
{emis(E):aime(_,E)}.
:- not aime(P,E); people(P); emis(E). % 要求E是P喜欢的节目
emis(E) :- aime(P,E): people(P); aime(_,E).
:- 2>{people(_)}. %人数大于2
:- 1>{emis(_)}. %节目大于1
#show people/1.
#show emis/1.