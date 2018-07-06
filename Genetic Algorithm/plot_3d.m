function plot_3d(fun)
    %clf
    if strcmp(fun,'f_wave')
        x = linspace(2,12.1,100);
        y = linspace(4.1,5.8,100);
        [xx, yy] = meshgrid(x, y);
        %zz= -exp(0.2*sqrt((xx-1).^2 + (yy-1).^2) + (cos(2*xx) + sin(2*xx)) );
        zz=21.5 + xx.*sin(4*pi*xx ) + yy.*sin( 20*pi*yy );
        
        %surf(xx, yy, zz);   
        contourf(x,y,zz,50)
        xlabel('x')
        ylabel('y')
        hold on;
    end

end
