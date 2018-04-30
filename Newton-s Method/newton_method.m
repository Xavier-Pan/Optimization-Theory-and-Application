function [x,N] = newton_method(grad,Hess,xnew,options)
%options deside 
if size(xnew,1) == 1
    xnew = xnew'; % transfer to column 
end
    
if nargin ~=4 % which maens options is null
    options = [];
    if nargin~=3 % the input at least need gradient,Hessian matrix and start point,if not, it is wrong!
        disp('Wrong number of arguments.');
        return;
    end
end

if length(options) >= 14
    if options(14)==0
        options(14) = 1000*length(xnew);
    end
else
	options(14) = 1000*length(xnew);
end

if length(options) < 18
    options(18) = 0.002; % optional step size
end

%clc
format compact;% show result in the same line
format short e;% show result in float point and no more 5 digit (e.g. 2.1423e+000)

options = foptions(options);
print = options(1);
epsilon_x = options(2);
epsilon_g = options(3);
max_iter = options(14);

%ros_cnt;% for Rosenbrok's function
if length(xnew) == 2
    plot(xnew(1),xnew(2),'o')
    text(xnew(1),xnew(2),'Start Point')
end
%====================================================
for k= 1:max_iter
    xcurr = xnew;
    g_curr = feval(grad,xcurr);
    F_curr = feval(Hess,xcurr);
    d_curr = -inv(F_curr)*g_curr; % current direction
    if norm(g_curr) <= epsilon_g
        disp('Terminating: Norm of gradient less than');
        disp(epsilon_g);
        k = k -1;break;
    end % if
    if options(7) == 0
        alpha = secant(grad,xcurr,d_curr);
    else
        alpha = options(18);
    end %if
    xnew = xcurr + alpha*d_curr;
    if print
        disp('Iteration number k=')
        disp(k); % print iteration index k
        disp('alpha=');
        disp(alpha); % print alpha
        disp('Gradient=');
        disp(g_curr);%print gradient
        disp('New point=');
        disp(xnew'); % print new point
    end %if
    
    if norm(xnew-xcurr) <= epsilon_x*norm(xcurr)
        disp('Terminating: Norm of difference between iterates less than');
        disp(epsilon_x);
        break;
    end

   %pltpts(xnew,xcurr);% for exercise 8.26
    if k== max_iter
        disp('Terminating with maximum number of iterations');
    end
end%for
        
if nargout >= 1
    x=xnew;
    if nargout == 2
        N = k;
    end
else
    disp('Final point=');
    disp(xnew');
    disp('Number of iterations =');
    disp(k);
end %if

end %func
%OPTIONS=zeros(18,1), OPTIONS(1)= 1 , OPTIONS(2)= 10^-4, OPTIONS(3)= 10^-6, OPTIONS(14)= 1000, 
%newton_method('grad','Hess',[3 -1 0 1]',OPTIONS)