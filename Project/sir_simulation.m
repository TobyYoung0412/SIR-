function[inf,nisum,rec,infsum] = sir_simulation(A,parent_node,prob,r,num_of_steps)
%OUTPUT
%inf - 当前被感染的人数
%nisum - 新被感人的人数
%rec - 被治愈的人数
%infsum - 被感染的总人数


%INPUT
% num_of_steps - 最大仿真步数,如果在达到最大仿真步数之前,所有结点都被治愈将结束仿真.
% prob - 每个节点被传染的概率
% r - 治愈概率
% parent_node - 开始时刻被感染你的人数,parent_node为起始结点的ID,传染病将从其中结点进行传播
%example: parent_node = [1 5 7] 意味着传染将从 1 5 7 三个结点开始.

% 生成开始时全图的索引数组,其中x==1为被感染者,x==0为敏感人群.
num_of_nodes = size(A,1);
x = zeros(1,num_of_nodes);
x(parent_node) = 1;

all_prob = ones(num_of_nodes,1)*prob;

inf = [];
nisum = [];
r_sequence = [];

    for i = 1:num_of_steps 
        % 第一步进行初始化
        if i == 1
            z = x;
            ni = zeros(1,num_of_nodes);
            if rand<r;  ni(x==1) = 1; end
            recovered = ni';
            z_all(1,:) = z;
        else
            % 逐步模拟进行仿真
            % 获取新的总感染结点和新的被感染结点
            [z,ni] = sir_infection_step(A,z,all_prob);
            z_all(i,:) = z;
            % 获取治愈后的新的全部节点状态和新被治愈的结点
            [nA,nr] = sir_recovery_step(A,z_all(i-1,:),r);
            A = nA;
            % 统计总的被治愈的结点
            recovered = recovered + nr;
            recovered(recovered > 1)=1;
        end
        
        % 汇总当前时刻数据
        inf(i) = sum(z(z==1));
        nisum(i) = sum(ni(ni==1));
        rec(i) = sum(recovered(recovered==1));
        infsum(i) = sum(z(z==1));
        inf(i) = inf(i)-rec(i);
        
        % 感染者为0结束仿真
        if i > 1 && inf(i) == 0
            break
        end
    end
end


