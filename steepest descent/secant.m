function alpha = secant(grad,xcurr,d)
% xcurr: current point
% d: direction
% g0: gradient of current alpha
% g1: gradient of previous plpha
% alpha0: previous plpha
% alpha1: current alpha
close
epsilen = 10^-5;
alpha0 = 0;
alpha1 = .001;
threshold = abs(feval(grad,xcurr+alpha0*d)'*d)*epsilen; % feval evaluate 'grad.m' and pass argument: xcurr+alpha0*d
g0 = feval('grad',xcurr+alpha0*d)'*d;% phi'(alpha0)
g1 = feval('grad',xcurr+alpha1*d)'*d;% phi'(alpha1)

%%%%%%%%%%% plot function for test %%%%%%%%%%%%
%{
xx = linspace( 0,.01);
yy = zeros(size(xx));
for i=1:length(xx)
    zz = xcurr+xx(i)*d;
    %yy(i) = (zz(1)-4)^4+(zz(2)-3)^2+4*(zz(3)+5)^4; 
    yy(i) = 100*(zz(2)-zz(1) )^2 + ( 1- zz(1) )^2 ; 
end
drawnow
plot(xx,yy)
%}
%%%%%%%%%%% plot for test %%%%%%%%%%%%


while abs(g1)> threshold    
    alphaNew = alpha1 - (alpha1-alpha0)/(g1-g0)*g1;    % update rule
    alpha0 = alpha1;
    alpha1 = alphaNew;
    %calculating new alpha
    g0 = feval('grad',xcurr+alpha0*d)'*d;
    g1 = feval('grad',xcurr+alpha1*d)'*d;   
end

alpha = alphaNew;
