% Data
player(1,("cat";"dog";"bird";"elephant")).  % score: 12
player(2,("bird";"dog";"coyote")).  % score: 3
player(3,("dog";"mouse")).  % score: 2

unique(P,W):- 1{player(_,W)}1; player(P,W).  % 只有一个玩家找到了单词W
score(P,S):-S = #sum{@value(W): unique(P,W)}; player(P,_).

#script (python)
def value(word):
    return [1,1,2,3,5,11][min(len(word.string),8)-3]
#end. 

#show score/2.

% python 部分报错
