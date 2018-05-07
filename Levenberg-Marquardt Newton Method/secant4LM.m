function alpha = secant4LM(Jacob,objective,y,xcurr,d)
% xcurr: current point
% d: direction
% g0: gradient of current alpha
% g1: gradient of previous plpha
% alpha0: previous plpha
% alpha1: current alpha
epsilen = 10^-5;
alpha0 = 0;
alpha1 = .001;
threshold = abs(feval(objective,xcurr,y)'*feval(Jacob,xcurr)*d)*epsilen; % feval evaluate 'grad.m' and pass argument: xcurr+alpha0*d
xnew = xcurr+alpha1*d;
g0 = feval(objective,xcurr,y)'*feval(Jacob,xcurr)*d;% phi'(alpha0)
g1 = feval(objective,xnew,y)'*feval(Jacob,xnew)*d;% phi'(alpha1)
disp("++++++++++++ g0")

while abs(g1)> threshold    
    alphaNew = alpha1 - (alpha1-alpha0)/((g1-g0)*g1);    % update rule
    alpha0 = alpha1;
    alpha1 = alphaNew
    %calculating new alpha
    %g0 = feval(grad,xcurr+alpha0*d)'*d;
    %g1 = feval(grad,xcurr+alpha1*d)'*d;   
    g0 = feval(objective,xcurr+alpha0*d,y)'*feval(Jacob,xcurr+alpha0*d)*d;% phi'(alpha0)
    g1 = feval(objective,xcurr+alpha1*d,y)'*feval(Jacob,xcurr+alpha1*d)*d;% phi'(alpha1)
end
alpha = alpha1;
