function x=grad( x_curr )    
    % for example 8.1    
    %x=[4*(x_curr(1)-4)^3,2*(x_curr(2)-3),16*(x_curr(3)+5)^3 ]';    
    % for exercise 8.26
    x=[-400*(x_curr(2)-x_curr(1)^2)*x_curr(1) - 2*(1-x_curr(1)), 200*( x_curr(2) - x_curr(1)^2 )]';
end