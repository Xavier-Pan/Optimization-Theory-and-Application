function x=grad( x_curr )    
	switch length(x_curr)        
        case 2   % for exercise 8.26
            x=[-400*(x_curr(2)-x_curr(1)^2)*x_curr(1) - 2*(1-x_curr(1)), 200*( x_curr(2) - x_curr(1)^2 )]';
        case 3   % for example 8.1    
            x=[4*(x_curr(1)-4)^3,2*(x_curr(2)-3),16*(x_curr(3)+5)^3 ]';    
        case 4
            x=[2*(x_curr(1)+10*x_curr(2)) + 40*(x_curr(1) - x_curr(4))^3;
                2*(x_curr(1)+10*x_curr(2)) + 4*(x_curr(2) - 2*x_curr(3))^3;
                10*(x_curr(3) + x_curr(4)) - 8*(x_curr(2) - 2*x_curr(3))^3;
                -10*(x_curr(3) - x_curr(4)) - 40*(x_curr(1) - x_curr(4))^3 ];
        
    end
end

 
