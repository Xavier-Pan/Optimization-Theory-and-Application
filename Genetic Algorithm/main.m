%clc;clear all;close all;
clear
figure(1)
options(1)=1;
options(2)=1/100; %mutation probability
options(5)=-1; % selection method, -1:µ×­^¨î, 0:roulette-wheel ,1:tournament
options(14)=100;%number of generation
options(15)=1;%  0=GA   1=Hybrid
options(18)=.7;  %probability of crossover

pool_size = 100;
plotcontour = true; 
test = false;
fun = 'f_wave';
%======================================================
switch(fun)
    case 'f_wave'        
        x_range = [-3.5,12.1];
        y_range = [4.1,5.8];
        Domain = [x_range;y_range];
    case 'f_wave2'        
        x_range = [-5.12,5.12];
        y_range = x_range;
        z_range = x_range;
        Domain = [x_range;y_range;z_range];
    otherwise
        figure(3);
        title('the function name have not been define!');
end
%load popu_file.mat  %load population
if strcmp(fun,'f_wave')
    load population_100.mat  %load population
elseif strcmp(fun,'f_wave2')
    load population3D_100.mat  %load population for 3 dimension data
end
for j=1:1
    tic;   
    temp_y = 0;
    for i=1:1
        %=== GA =====================
        disp("GA...")
        [x,y,best_fitness_record]=gar(Domain ,pool_size,fun,options,population,plotcontour);
        temp_y = y;
        disp("GA solution:")
        disp(num2str(x));                
    end   
end

%figure(2)
str_title1 = strcat('best value: ',num2str(temp_y),'    position: ');
for i=1:size(population,2)
    str_title1 = strcat(str_title1,' , ', num2str(x(i)));
end
str_title2 = strcat('# of generation: ',num2str(options(14)),'   pool size: ',num2str(pool_size));
title({[str_title1];[str_title2]})

disp('best_fitness record:');
disp(best_fitness_record)
disp('GA Solution:');
disp(x);
disp('Objective function value:');
disp(y);
saveas(gcf, [fun,'.png'], 'png');