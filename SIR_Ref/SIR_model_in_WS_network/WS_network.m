%====================================================
%Author: MarkoXu  704712641@qq.com
%Date: 2018-10-27
%Desc: generate a WS network with rewired probability p
%Reference: Collective dynamic of 'small-world' networks Fig. 1
%====================================================

%% ��������Ļ�������
N = 10000; %�����ģ
K = 5; %�ڵ㵥����ھ���ΪK
%p = 10.^(-4); %��������p
node_neighbors = cell(N, 1); %����ÿ���ڵ���ھ�

%% �����淶���磬��ÿ���ڵ�������K���ڵ�����
for i = 1 : N
    A = zeros(2*K, 1);
    for j = 1 : K
        if i+j <= N
            A(j) = i + j;
        else
            A(j) = i + j - N;
        end
        if i-j <= 0
            A(j+K) = i - j + N;
        else
            A(j+K) = i - j;
        end
    end
    node_neighbors{i,1} = A;
end

%% �淶�������б��Ը���p�������
for i = 1 : N
    for j = 1 : 2*K
        p_link = unifrnd(0,1); %����һ����������
        tempt = node_neighbors{i}(1);%��ȡ��ǰ����Ҫ�Ͽ��Ľڵ�
        if isnan(tempt)
            node_neighbors{i}(1)=[];
            continue;
        end
        %���������������ýڵ�ŵ��ھӵ����
        if p_link >= p
            node_neighbors{i}= [node_neighbors{i}(2:size(node_neighbors{i},1));tempt];
        end
        %����������Ѱ�������Ľڵ㣬�������ر����Ա�
        if p_link < p
            e = find(node_neighbors{tempt}==i);
            node_neighbors{i}(1) = [];
            node_neighbors{tempt}(e) = nan; %����ɾ������Ϊ��Ӱ��ڵ�ĳ�ջ˳��
            v_link = unidrnd(N); %ѡ��һ�������Ľڵ�
            while v_link==i||ismember(v_link,node_neighbors{i}) %��ֹ�ر߻����Ա�
                v_link = unidrnd(N);
            end
            node_neighbors{i} = [node_neighbors{i}; v_link]; %�������ڵ�����ھӱ���
            node_neighbors{v_link} = [node_neighbors{v_link}; i];
        end
    end
end
% ȥ���ھӱ��е�nan���ݣ���Ϊ��Щ����ʵ�Ѿ��Ͽ�
for i = 1 : N
    node_neighbors{i}(isnan(node_neighbors{i})) = [];
end


