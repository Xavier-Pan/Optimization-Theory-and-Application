function x=numari_grad(f, x )    
    h = 10^-3;
	x = (feval(f,x+h) - feval(f,x-h) )/(2*h);
end

 
