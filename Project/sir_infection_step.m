function [z,ni] = sir_infection_step(A,x0,p)
%OUTPUT
%z - output vector - 系统的新状态,1为感染者,0为敏感者
%ni - "newly infected" - 新被感染的结点列表

%INPUT
%A - 邻接矩阵
%x0 - 被感染结点的描述数组,其中1代表被感染,0代表未感染
%p - 易感结点被感染的可能性
%r_tobe - "recovered to be" - 当前步即将被治愈的结点


[~,n] = size(A);

x0(x0>1) = 1; 

% 构建概率和新感染列表
PROB = zeros(1,n);
NEWINF = zeros(1,n);

%数值调整,超过1的调整为1,尽表示是否可能被感染,
AN = sum(A(x0==1,:),1);
AN(AN>1) = 1;
SUC1 = AN;

%从新易感人群中移出已感染者
SUC = SUC1 - x0;
SUC(SUC<0) = 0;

%计算每个结点相邻的被感染者数量
NEIGH = zeros(1,n);
for i = find(SUC==1)
    AN = and(A(:,i),x0');
    NEIGH(i) = sum(AN);
end


%计算每一个结点的被传染的概率,相邻的感染者与被感染概率成指数关系
if size(p,1)==1
    for i = 1:n
        PROB(i) = 1-(1-p)^NEIGH(i);
    end
else
    for i = 1:n
        PROB(i) = 1-(1-p(i))^NEIGH(i);
    end
end


%计算新的被感染结点
for i = 1:n
    format long
    r = rand;
    if r <= PROB(i)
        NEWINF(i) = 1;
    end
end
ni = NEWINF;
%构建新的包含总的被感染者的节点列表
z = NEWINF + x0;


end