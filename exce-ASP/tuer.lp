ppl(alto;dumm;khaj;orqu).
1{guilt(X):ppl(X)}1.
right(alto):-guilt(dumm).
right(dumm):-guilt(khaj).
right(orqu):-not guilt(orqu).
right(khaj):- not guilt(khaj).
3{right(X):ppl(X)}3.
#show guilt/1.