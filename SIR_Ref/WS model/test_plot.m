clear,clc,close all
% % load A.txt
% N=100;
% m=6;
% p=0.3;
% % A = small_world_WS_new(N, m, p);
% A = small_world_NW(N, m, p);
% t=linspace(0,2*pi,N+1);
% x=sin(t)*10;
% y=cos(t)*10;
% figure
% set(gcf,'color','w')
% plot(x,y,'o','markerfacecolor','k'),hold on
% for i=1:N
%     for j=1:N
%         if (A(i,j)==1)
%         fp1=plot([x(i),x(j)],[y(i),y(j)],'r-'); hold on
%         set(fp1,'linesmoothing','on')
%         end
%     end
% end
% axis([-10.5,10.5,-10.5,10.5])
% axis square
% axis off
% sum(sum(A))


h2 = WattsStrogatz(10,2,0.7);
% m1=sparse(h2)
ans1 = adjacency(h2);
ans2 = full(ans1);
plot(graph(ans2),'NodeColor','k','EdgeAlpha',0.1);
title('Watts-Strogatz Graph with $N = 500$ nodes, $K = 25$, and $\beta = 0.15$', ...
    'Interpreter','latex')
