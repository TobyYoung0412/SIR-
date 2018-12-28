function [nA,nr] = sir_recovery_step(A,z,r)
%OUTPUT
%nA - 溢出了治愈结点的新的邻接矩阵
%nr - "newly recovered" - 该步被治愈者的结点列表

%INPUT
%A - 邻接矩阵
%z - 感染结点
%r - rate of recovery - 治愈概率

remove = times(z',rand(size(z,2),1));

% 确定被治愈者
remove(remove > 1-r) = 1;
remove(remove <= 1-r) = 0;

%对邻接矩阵进行调整
A(remove == 1,:) = 0;
A(:,remove == 1) = 0;
nA = A;
nr = remove;
end