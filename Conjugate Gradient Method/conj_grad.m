function [x,N]=conj_grad(grad,xnew,options)
% conjugate gradient algorithm
close
if size(xnew,1) == 1
    xnew = xnew'; % transfer to column 
end
    
if nargin ~= 3 % which maens options is null
    options = [];
    if nargin~= 2 % the input at least need gradient and start point,if not, it is wrong!
        disp('Wrong number of arguments.');
        return;
    end
end

if length(options) >= 14
    if options(14)== 0
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


if length(xnew) == 2
    ros_cnt;% for Rosenbrok's function
    plot(xnew(1),xnew(2),'o')
    text(xnew(1),xnew(2),'Start Point')
end
%=========== main algo  =========================================
g_curr = feval(grad,xnew);
d = -g_curr;
reset_cnt = 0;
for k=1:max_iter
    xcurr = xnew;    
    alpha = secant(grad,xcurr,d);
    %alpha = -(d'*g_curr)/(d'*Q*d);
    xnew = xcurr + alpha*d;% update x   
    %===== show information =====================
    if print
        disp('Iteration number k =')
        disp(k); % print iteration index k    
        disp('alpha=');
        disp(alpha);
        disp('Gradient=');
        disp(g_curr); % print gradient   
        disp('New point=');
        disp(xnew); % print new point
    end

    if norm(xnew-xcurr) <= epsilon_x*norm(xcurr)
        disp('Terminating: Norm of difference between iterates less than');
        disp(epsilon_x);
        break;
    end
    %=== update =================================
    
    g_old = g_curr;
    g_curr = feval(grad,xnew);   
    %============================================
    if norm(g_curr) <= epsilon_g
        disp('Terminating:Norm of gradient less than');
        disp(epsilon_g);
        k=k-1;
        break;
    end
    
    reset_cnt = reset_cnt + 1;
    if reset_cnt == 3*length(xnew)
        d=-g_curr;
        reset_cnt =0;
    else
        if options(5) == 0 % Powell
            beta = max(0,(g_curr'*(g_curr-g_old))/(g_old'*g_old));
        elseif options(5) == 1% Fletcher-Reeves
            beta = (g_curr'*g_curr)/(g_old'*g_old);
        elseif options(5) == 2% Polak Ribiere
            beta = (g_curr'*(g_curr-g_old))/(g_old'*g_old);
        else
            beta = (g_curr'*(g_curr-g_old))/(d'*(g_curr-g_old));
        end % if
        d = -g_curr + beta*d;
    end
    
    %==== plot contour =====================================
    if length(xnew)==2
        pltpts(xnew,xcurr);% for exercise 8.26
        % show f(x) and number of iteration in figure
        f= 100*(xnew(2)-xnew(1)^2)^2 + (1-xnew(1))^2;
        s = strcat('Minimization of Rosenbrock function k=',num2str(k),' f(x)=',num2str(f));
        title(s)
    end
     %===== show information =====================
     if print
         disp('New beta=');
         disp(beta);
         disp('New d=');
         disp(d);
     end
    if k== max_iter
        disp('Terminating with maximum number of iterations');
    end
end%for

disp('assign x = xnew')
if nargout >=1
    x =xnew;
    
    if nargout == 2
        N=k;
    end
else
    disp('Final point=');
    disp(xnew');
    disp('Number of iterations =');
    disp(k);
end %if

end %func

%OPTIONS=zeros(18,1); OPTIONS(1)= 1 , OPTIONS(2)= 10^-6, OPTIONS(3)= 10^-6, OPTIONS(14)= 1000
%conj_grad('grad',[-2,2]',OPTIONS)

