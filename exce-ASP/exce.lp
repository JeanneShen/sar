% #const 定义常量
% #const num_const = 42.
% #const chr_const = "a".
% a(num_const).
% b(chr_const).
% p(X) :- X=num_const.


% 1{nb(1..100)}1.
% #maximize {N:nb(N)}.  % resultat est -100 ?
% #minimize {N:nb(N)}. 


%val(1;18;3;23;42).
%first(X) :- val(X); not val(Y):val(Y),Y < X.
%next(X,Y) :- val(X); val(Y); X < Y; not val(Z):val(Z),X < Z,Z < Y.
%sum(1,F,F) :- first(F).
%sum(N+1,W,T+W) :- sum(N,V,T); next(V,W).
%step(S) :- sum(S,_,_).
%sum(S):-sum(N,_,S); not sum(M,_,_):step(M),N < M.
%以上等价与 #sum
%sum(S):- S=#sum{V:val(V)}.
%#show sum/1.

%对不同的组求和
%val2(a,1;b,3;a,18;b,23;a,42;b,67;a,72).
%group(G):-val2(G,_).
%sum(G,S):- S=#sum{V:val2(G,V)};group(G).
% #show sum/2.
%注意 元组中元素的唯一性，
% %val3(1,10;2,10).
% total(S) :- S=#sum{V:val3(G,V)}.    %结果为10.{10,10}中的一个会被忽略
%total(S) :- S=#sum{V,G:val3(G,V)}.  % 区分两个10,结果位20(smm 不关心第二个参数，只考虑第一个)
%#show total/1.

val(1..5).
b(1;2).
c(1;2).
d(1).
s(X):- val(X); d(X): c(X), b(X).
t(X):- val(X); d(X): c(X) ; d(X).
#show s/1.
#show t/1.