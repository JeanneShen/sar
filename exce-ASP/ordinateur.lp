#const max_cost=800.

% Data
component(gpu,"A",330,10).
component(gpu,"B",200,7).
component(gpu,"embedded graphic chipset",0,4).
require(gpu,"embedded graphic chipset",cpu,"C").

component(cpu,"A",400,10).
component(cpu,"B",150,6).
component(cpu,"C",250,6).
require(cpu,"C",gpu,"embedded graphic chipset").

component(ram,"4Go",70,4).
component(ram,"8Go",130,7).
component(ram,"16Go",220,9).

component(hdd,"500Go",40,5).
component(hdd,"1To",50,7).
component(hdd,"2To",80,9).

component(ssd,"50Go",100,5).
component(ssd,"100Go",180,7).

component(motherboard,"full",140,8).
component(motherboard,"basic",70,5).
incompatible(motherboard,"basic",gpu,"embedded graphic chipset").
incompatible(motherboard,"basic",ram,"16Go").

component(cpufan,"big",100,8).
component(cpufan,"small",40,5).
require_one(cpufan,"small",cpu,("B";"C")).  % the small fan isn't enough for the CPU A

component(case,"big&quiet",150,7).
component(case,"big",120,5).
component(case,"small&quiet",100,7).
component(case,"small",70,5).

incompatible(case,("small";"small&quiet"),gpu,"A").
incompatible(case,("small";"small&quiet"),motherboard,"full").
incompatible(case,("small";"small&quiet"),cpufan,"big").

optional(ssd). % SSD not necessary

set_importance(gpu,10).  % 给不同组件设置权重
set_importance(motherboard,3).
set_importance(ssd,4).

% 不同的 bridge 不能兼容
incompatible(cpu,CPU,motherboard,MB) :- component(cpu,CPU) ; component(motherboard,MB) ;
                                       bridge(cpu,CPU,CPU_Bridge) ; bridge(motherboard,MB,MB_Bridge) ;
                                       MB_Bridge != CPU_Bridge.

% 提取不同的信息
component(O,Name):- component(O,Name,_,_).
price(O,Name,P):- component(O,Name,P,_).
rate(O,Name,R):- component(O,Name,_,R).

%判断必要性
minimal_quantity(O,1):- component(O) ; not optional(O).
minimal_quantity(O,0):- component(O) ; optional(O).

% 将未知的重要性都设为5
importance(O,5):- component(O) ; not set_importance(O,_).
importance(O,I):- component(O) ; set_importance(O,I).

require(C1,N1,C2,N2):- embeds(C1,N1,C2,N2).
require(C2,N2,C1,N1):- embeds(C1,N1,C2,N2).


% 模型
component(O):-component(O,_).
%在每个组件中选择一个
Q { use(O,X): component(O,X) } 1 :- component(O) ; minimal_quantity(O,Q).

% 组件的要求一定要满足配置
use(O2,N2):- use(O1,N1) ; require(O1,N1,O2,N2).
1 { use(O2,X): require_one(O1,N1,O2,X) } 1:- use(O1,N1) ; require_one(O1,N1,O2,_).

% 避免不兼容
:- incompatible(O1,N1,O2,N2) ; use(O1,N1) ; use(O2,N2).

% 对价格、rate和size求和
total_cost(T):- T=#sum{C,O: use(O,I), price(O,I,C)}.
total_rate(T):- T=#sum{R*I,O: use(O,C), rate(O,C,R), importance(O,I)}.
total_size(T):- T={use(_,_)}.
%满足预算
:- total_cost(T) ; T>max_cost.
% 满意度最大化
#maximize{S:total_rate(S)}.

#show.
#show use/2.
#show total_cost/1.
#show total_rate/1.
#show total_size/1.