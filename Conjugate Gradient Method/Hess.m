function H = Hess(x)
%==== calculating Hessian matrix ======
H = zeros(length(x),length(x));
switch length(x)
    case 4
        H(1,2) = 20;
        H(1,4) = -120*(x(1) - x(4))^2;
        H(2,3) = -24*(x(2) - 2*x(3))^2;
        H(3,4) = -10;
        H = H' + H % symmetric
        H(1,1) = 2+120*(x(1)-x(4) )^2;
        H(2,2) = 200+12*(x(2) - 2*x(3) );
        H(3,3) = 10+48*(x(2) - 2*x(3))^2;
        H(4,4) = 10+120*(x(1) - x(4))^2;
    case 2
        H(1,1) = 1200*x(1)^2 - 400*x(2) + 2;
        H(1,2) = -400*x(1);
        H(2,1) = -400*x(1);
        H(2,2) = 200;
end% switch

end