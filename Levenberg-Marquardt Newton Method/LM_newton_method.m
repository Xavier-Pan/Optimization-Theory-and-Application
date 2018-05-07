function [x,N] = LM_newton_method(xnew,options)
close
%options design 
if size(xnew,1) == 1
    xnew = xnew'; % transfer to column 
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

clc
format compact;% show result in the same line
format short e;% show result in float point and no more 5 digit (e.g. 2.1423e+000)


options = foptions(options);
print = options(1);
max_iter = options(14);

if length(xnew) == 2
    ros_cnt;% for Rosenbrok's function
    plot(xnew(1),xnew(2),'o')
    text(xnew(1),xnew(2),'Start Point')
end
%====== initial =======================================
t = linspace(0,10,21)';
y= 2.01*sin(.992*t+.541);
tau = 10^-3;
J = feval('jacobian',xnew);
A = J'*J;
mu = tau*max(diag(A));

epsilon1 = 10^-8;
epsilon2 = 10^-18;
v = 2; %fator to increasing mu
%========= main algo ===========================================
I_mat = eye(length(xnew));% identity matrix
k=0;
xcurr = xnew;
J = feval('jacobian',xcurr);
g_curr = J'*feval('objective',xcurr,y);
%inv(F_curr)
found = max(abs(g_curr)) <= epsilon1;
[V, D]= eig(J'*J);
mu=min(diag(D))+10^-8;
while k<max_iter && ~found
    k=k+1;
    %======== solving Fd=g =========
    F_curr = J'*J + mu*I_mat; 
    d_curr = -pinv(F_curr)*g_curr; % current direction
    %====stop criterion  ===========
    
     if norm(d_curr) <= epsilon2*(norm(xcurr) + epsilon2)
        disp('Terminating: Norm of direction less than');
        disp(epsilon2*(norm(xcurr) + epsilon2));   
        k = k -1; % don't count this time
        break
     else
        %===  line serach  ==========
        if options(7) == 0       
            disp(options)
            disp("using secant @@@@@@@@@@@@@@@@@@@@@@")
            alpha = secant4LM('jacobian','objective',y,xcurr,d_curr);
        else
            alpha = 1;
        end %if
        %============================
        xnew = xcurr + alpha*d_curr;
        J = feval('jacobian',xnew);
        [V, D]= eig(J'*J);
        mu=abs(min(diag(D)))+10^-8;
        xcurr = xnew;        
        g_curr = J'*feval('objective',xcurr,y);
        found = max(abs(g_curr)) <= epsilon1; % stop criterion  
        if found
            break;
        end
        %{
        r_curr = feval('objective',xcurr,y);
        Loss_curr = norm(r_curr)/2
        Loss_new =  norm(feval('objective',xnew,y))/2
        Taylor_Loss = Loss_curr+d_curr'*J'*r_curr + norm(J*d_curr)/2
        q = (Loss_curr - Loss_new)/(Loss_curr-Taylor_Loss+10^-20) % q:= ( F(x)-F(x_new) ) / ( L(0) - L(d_lm) )
       
        if q>0
            xcurr = xnew;
            J = feval('jacobian',xcurr);
            g_curr = J'*feval('objective',xcurr,y);
            found = max(abs(g_curr)) <= epsilon1; % stop criterion         
            mu = mu*max(1/3, 1-(2*q-1)^3)
            v=2;                    
            disp(" com in !!!!!!!!!!!!!!!!!")
        else
            mu=mu*v
            v = v*2;
        end%if
        %}
     end
    %===============================
    
   
    if print
        disp('Iteration number k=')
        disp(k); % print iteration index k        
        disp('New point=');
        disp(xnew'); % print new point
    end %if    

   %pltpts(xnew,xcurr);% for exercise 8.26
    if k== max_iter
        disp('Terminating with maximum number of iterations');
    end
end%for
if max(abs(g_curr))<= epsilon1% means gradient approx. zero
        disp('Terminating: Norm of gradient less than');
        disp(epsilon1);
      
end % if        
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

hold on;
plot(t,y,'o-');
plot(t,xnew(1)*sin(xnew(2)*t+xnew(3)));
end %func
%OPTIONS=zeros(18,1); OPTIONS(1)= 1 ; OPTIONS(2)= 10^-4; OPTIONS(3)= 10^-6; OPTIONS(14)= 1000; OPTIONS(18)= 1; 
%OPTIONS(7)= 1; x = LM_newton_method([1 1 1]',OPTIONS)