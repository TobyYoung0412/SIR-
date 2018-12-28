function h = WattsStrogatz(N,K,beta)
% OUTPUT
% H = WattsStrogatz(N,K,beta)返回由N个节点，N*K条边，节点度数2*K构造，
% 以beta概率重连边得到的WS模型
% beta = 0为圆形，beta = 1为随机图

% INPUT
% N - 结点总数
% K - 每个节点的边数
% beta - 每条边的重连概率

% 连接每个节点和他后向K临近的节点，该步骤构造结果为圆形
s = repelem((1:N)',1,K); % 源节点矩阵
t = s + repmat(1:K,N,1); % K临近目标节点矩阵，并做调整
t = mod(t-1,N)+1;

% 以beta概率重新连接每个节点对应的目标节点
% 先确定需要重连的边
% 在确定新连接的边(保证不重复)
% 在生成的网路上进行操作
for source=1:N    
    switchEdge = rand(K, 1) < beta;
    
    newTargets = rand(N, 1);
    newTargets(source) = 0;
    newTargets(s(t==source)) = 0;
    newTargets(t(source, ~switchEdge)) = 0;
    
    [~, ind] = sort(newTargets, 'descend');
    t(source, switchEdge) = ind(1:nnz(switchEdge));
end

% 将生成的网络转化为满邻接矩阵
h = full(adjacency(graph(s,t)));
end