echo off
clf;
X = [-2:.125:2]';
Y = [-1:.125:3]';

[x,y] = meshgrid(X',Y');
func = 100.*(y-x.*x).^2+(1-x).^2;
levels = exp(2:30); % plot level in high equal to exp(2),exp(3),...,exp(30)
contour(X,Y,func,levels);
%contour(X,Y,func);
xlabel('x_1')
ylabel('x_2')
title('Minimization of Rosenbrock function')
drawnow;
hold on
plot(1,1,'o');
text(1,1,'Solution')
