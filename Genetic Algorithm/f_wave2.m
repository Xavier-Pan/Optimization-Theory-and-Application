function y=f_wave2(x)
y=3+x(1)^2+x(2)^2+x(3)^2-cos(2*pi*x(1))-cos(2*pi*x(2))-cos(2*pi*x(3));
y=-y;% for minimize
%{
figure(4)
x = linspace(-5,5);
y = linspace(-5,5);
[xx, yy] = meshgrid(x, y);
    zz= -exp(0.2*sqrt((xx-1).^2 + (yy-1).^2) + (cos(2*xx) + sin(2*xx)) );
    surf(xx, yy, zz);   
xlabel('x')
ylabel('y')
%}
