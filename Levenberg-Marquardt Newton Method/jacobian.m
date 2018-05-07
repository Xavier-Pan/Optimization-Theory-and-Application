function jcb=jacobian(para)    
%para: paramter(1) : A
%      paramter(2) : w
%      paramter(3) : phi
	jcb=zeros(21,3);
    t = linspace(0,10,21);
    for i=1:length(t)
        jcb(i,1) = -sin(para(2)*t(i)+para(3));
        jcb(i,2) = -t(i)*para(1)*cos(para(2)*t(i)+para(3));
        jcb(i,3) = -para(1)*cos(para(2)*t(i)+para(3));              
    end%for
end

 
