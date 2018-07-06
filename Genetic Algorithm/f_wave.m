function y=f_wave(x)
    y=21.5+x(1)*sin(4*pi*x(1) ) + x(2)*sin( 20*pi*x(2) );
    y=-y;
end
%{
figure(2)
x = linspace(-3.5,12.1,300);
y = linspace(4.1,5.8,300);
[xx, yy] = meshgrid(x, y);
zz=21.5 + xx.*sin(4*pi*xx ) + yy.*sin( 20*pi*yy );
%contourf(x,y,zz,50)
surf(xx, yy, zz);   
xlabel('x')
ylabel('y')
 saveas(gcf, ['cover.png'], 'png');
%}
