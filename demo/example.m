clear;
%the network
A = full(adjacency(WattsStrogatz(100,5,0.1)));
% plot(graph(A),'NodeColor','k','EdgeAlpha',0.1);
% title('Watts-Strogatz Graph with $N = 500$ nodes, $K = 25$, and $\beta = 0.15$', ...
%     'Interpreter','latex')


%simulation parameters
num_of_steps = 2000; %maximum number of iterations. If all the nodes get recovered before that, the simulation will stop
prob = 0.8; %the probability that the node will be infected from already infected neighboring node
r = 0.3; %the recovery rate
parent_node = 1; %the ID of the node where infection starts. If parent_node is an array of IDs,
%the infection will start in all of the nodes listed in parent_node. For
%example: parent_node = [1 5 7] means the infection will start in nodes 1 5 and 7 
immunized = []; %the custom probability of virus transmission to certain nodes could be specified if needed.
%For custom transmission probabilities, the vector "immunized" should have the size of number of nodes where
%each entry is the customized probability of transmission to certain node. If left empty, the p is the same
%for all nodes. For example, if network has 5 nodes and we want to
%customize the probabilities of transmission, then immunized vector should
%have the following form: immunized = [0.5 0.5 0.7 0.5 0.9]

%Start of the simulation


[inf,nisum,rec,infsum] = sir_simulation(A,parent_node,prob,immunized,r,num_of_steps);

%Plotting the results of the simulation
figure
    subplot(4,1,1);
    plot(inf, 'b*:');
    ylabel('Infected nodes');
    grid on
    
    subplot(4,1,2);
    plot(infsum,'b*:');
    ylabel('Sum of infected nodes');
    grid on
    
    subplot(4,2,1);
    plot(nisum,'b*:');
    ylabel('Infected nodes at each time step');
    grid on
    
    subplot(4,2,2);
    plot(rec,'b*:');
    ylabel('Recovered nodes');
    grid on



