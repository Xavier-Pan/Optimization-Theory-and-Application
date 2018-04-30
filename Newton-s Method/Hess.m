function H = Hess(xcurr)
%==== calculating Hessian matrix ======
H = zeros(length(xcurr),length(xcurr));
H(1,2) = 20;
H(1,4) = -120*(xcurr(1) - xcurr(4))^2;
H(2,3) = -24*(xcurr(2) - 2*xcurr(3))^2;
H(3,4) = -10;
H = H' + H % symmetric
H(1,1) = 2+120*(xcurr(1)-xcurr(4) )^2;
H(2,2) = 200+12*(xcurr(2) - 2*xcurr(3) );
H(3,3) = 10+48*(xcurr(2) - 2*xcurr(3))^2;
H(4,4) = 10+120*(xcurr(1) - xcurr(4))^2;

end