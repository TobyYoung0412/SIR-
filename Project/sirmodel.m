% 建立SIR模型的三个常微分方程
function y=sirmodel(t,x,prob,r)
y=[-prob*x(1)*x(2),prob*x(1)*x(2)-r*x(2),r*x(2)]';
