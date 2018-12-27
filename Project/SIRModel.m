%即写上三个微分方程
function y=SIRModel(t,x,lambda,mu)
y=[-lambda*x(1)*x(2),lambda*x(1)*x(2)-mu*x(2),mu*x(2)]';
