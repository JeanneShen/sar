val(1..9). %9行9列
border(1;4;7).
% 每格放一个值
1{s(R,L,V):val(V)}1 :- val(R);val(L).
% 每个值在行/列中只出现一次
1{s(R,L,V):val(R)}1 :- val(V);val(L).
1{s(R,L,V):val(L)}1 :- val(R);val(V).
1{s(R,L,V):val(R),val(L),R1<=R,R<=(R1+2),L1<=L,L<=(L1+2)}1 :- val(V); border(R1); border(L1).
#show s/3.