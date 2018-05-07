function r=objective( x,y)    
%parameter: x(1) : A
%      x(2) : w
%      x(3) : phi
    t=linspace(0,10,21)'; 
	r= y - x(1)*sin( x(2)*t + x(3) );    
end

 
