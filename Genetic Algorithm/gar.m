function [winner,bestfitness,best_record] = gar(Domain,N,fit_func,options,P,plo)
%function winner = GAR(Domain,N,fit_func)
%Function call: GAR(Domain,N,'f')
%Domain = search space; e.g., [-2,2;-3,3] for the space [-2,2]x[-3,3]
% (number of rows of Domain = dimension of search space)
% N = population size (must be an even number)
% f = name of fitness value function
%
%Options: .
%print = options(1);
%selection = options(5);
%max_iter=options(14);
%p_c options(18);
%p_m = p_c/100;
%
%Selection:
% options(5) 0 for roulette wheel, 1 for tournament

clf;
if nargin ~= 6  
        disp('Wrong number of arguments.');
        return; 
end

if length(options) >= 14
    if options(14)==0
        options (14)=3*N;
    end
else
    options (14)=3*N;
end
if length(options) < 18
    options(18)=0.75; %optional crossover rate
end

%format compact;
%format short e;
iteration = 0;
options = foptions(options);
print = options(1);
selection = options(5);
max_iter=options(14);
useHybrid = options(15)
p_c = options(18);
%p_m = p_c/100;
p_m = options(2);
n = size(Domain,1);
lowb = Domain(:,1)';
upb = Domain(: ,2)' ;
bestvaluesofar = 0;

if strcmp(fit_func,'f_wave') || strcmp(fit_func,'f_wave2')
    bestvaluesofar = -inf;
end
for i = 1:N %generate the first generation    
    %Initial evaluation
    fitness(i) = feval(fit_func,P(i,:));
end
%=============== %plot points ========================
if plo
    figure(100)
    %plot_3d(fit_func);   %畫背景
    if strcmp(fit_func,'f_wave')
        axis([Domain(1,:), Domain(2,:)])  
        plot(P(:,1),P(:,2),'r.', 'MarkerSize', 16);
    elseif strcmp(fit_func,'f_wave2')
        axis([Domain(1,:), Domain(2,:), Domain(2,:)])
        plot3(P(:,1),P(:,2),P(:,3),'r.', 'MarkerSize', 16);
    end
    
    saveas(gcf, ['p[0].png'], 'png');
end
%========================================
 
disp("max iter:")
disp(num2str(max_iter))
idx = ones(N,1);%紀錄各點所屬的群
count4excuteLM = 0;%紀錄是否達連續5世代最佳解沒更新,如果是 => 執行分群+LM
K = 1; %群數
K=floor(length(P)/20);%群數
reduce_range = false;
%======== 主程式 start ================================
for k = 1:max_iter
    count4excuteLM = count4excuteLM +1;
    iteration = k;
 %   K=floor(length(P)/20);%群數
    if K<3%至少保有兩群
        reduce_range=false;
    end
    %Selection
    fitness = fitness - min(fitness); % to keep the fitness positive
    if sum(fitness) == 0
        disp('Population has identical chromosomes -- STOP');
        disp('Number of iterations:');
        disp(k);
        for i = k:max_iter
            myupper(i)=myupper(i-1);
            average(i)=average(i-1);
            mylower(i)=mylower(i-1);
        end
        break;
    else
        fitness = fitness/sum(fitness);
    end
    %===轉輪盤 或 1對1競爭===========
    if selection == 0
    %roulette-wheel
        cum_fitness = cumsum(fitness);
        for i = 1:N
            tmp = find(cum_fitness-rand > 0);
            m(i) = tmp(1);
        end
    elseif selection == -1 %以分配的方式保留基因,因此最好的那幾個一定保留    
        i=1;
        gene_idx = 1;
        while(i<=N && gene_idx <= N)
            num4copy = round(fitness(gene_idx)*N)
            temp = i;
            while(i < temp + num4copy)
                m(i) = gene_idx;                
                i=i+1;
                if i>N 
                    disp("(*&^%$#")
                    break
                end
            end            
            gene_idx = gene_idx +1;
        end
    else
    %tournament
        for i = 1:N
            fighter1=ceil(rand*N);
            fighter2=ceil(rand*N);
                if fitness(fighter1) > fitness(fighter2)
                    m(i) = fighter1;
                else
                    m(i) = fighter2;
                end
         end
    end
    M = zeros(N,n);
    for i = 1:N
        M(i,:) = P(m(i),:);
    end
    disp("end selection............")
    %============================   
    if plo
        figure(100)    
         if strcmp(fit_func,'f_wave')
            axis([Domain(1,:), Domain(2,:)])  
            plot(P(:,1),P(:,2),'r.', 'MarkerSize', 16);
         elseif strcmp(fit_func,'f_wave2')
            axis([Domain(1,:), Domain(2,:), Domain(2,:)])
            plot3(P(:,1),P(:,2),P(:,3),'r.', 'MarkerSize', 16);
         end
    
        img_name = strcat('p[',num2str(k),'].png');
        saveas(gcf, [img_name], 'png');
    end
    
    %============================
    %Crossover
    Mnew = M;
    for m=1:K
        for i = 1:ceil(N/2)
            ind1 = ceil(rand*N);
            idx4cluster = idx(ind1); %individual_1 所屬的群編號            
            size4cluster = sum(idx==idx4cluster);
            ind2 = ceil(rand*size4cluster);
            parent1 = M(ind1,:);%random take 2 chromoso
            parent2 = M(idx==idx4cluster,:);
            parent2 = parent2(ind2);%只對同群的基因做交配
            if rand < p_c % 有p_c的probability會做交配
                a = rand;
                offspring1 = a*parent1+(1-a)*parent2+(rand(1,n)-0.5).*(upb-lowb)/10;%convex combination,unitform[-0.5,0.5]
                offspring2 = a*parent2+(1-a)*parent1+(rand(1,n)-0.5).*(upb-lowb)/10;
                %do projection
                    for j = 1:n
                        if offspring1(j)<lowb(j)
                            offspring1(j)=lowb(j);
                        elseif offspring1(j) > upb(j)
                            offspring1(j)=upb(j);
                        end

                        if offspring2(j)<lowb(j)
                            offspring2(j)=lowb(j);
                        elseif offspring2(j)>upb(j)
                            offspring2(j)=upb(j);
                        end

                    end
                    Mnew(ind1, :) = offspring1;%descendent
                    Mnew(ind2, :) = offspring2;
            end%if
        end%for
    end%for m=1:K
    %================================
    if plo       
        figure(100)    
        if strcmp(fit_func,'f_wave')
            axis([Domain(1,:), Domain(2,:)])  
            plot(P(:,1),P(:,2),'r.', 'MarkerSize', 16);
        elseif strcmp(fit_func,'f_wave2')
            axis([Domain(1,:), Domain(2,:), Domain(2,:)])
            plot3(P(:,1),P(:,2),P(:,3),'r.', 'MarkerSize', 16);
        end
        
        img_name = strcat('p[',num2str(k),']-cross.png');
        saveas(gcf, [img_name], 'png');
    end
    %================================
    %Mutation
    for i = 1:N
        if rand < p_m  % 有p_m的probability會做突變
            a = rand;
            w = lowb + rand(1,n).*(upb-lowb); %real number creep
            Mnew(i,:) = a*Mnew(i,:) + (1-a)*w;
        end
    end
    P = Mnew;
    %====== LM ===============
    if useHybrid && count4excuteLM >= 5
        disp("LM..................")
        options4LM = optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt',...
        'MaxFunctionEvaluations',500,'MaxIterations',30,'Display','none');
        for i=1:N
            x0=P(i,:);
            posit(i,:) = lsqnonlin(fit_func,x0,[],[],options4LM);
            result(i) = -feval(fit_func,posit(i,:));
        end        
        %====== k means and hamming net ===============
        %opts = statset('Display','final');  
        [idx,C] = kmeans(P,K,'Replicates',10,'MaxIter',100);        
        %====
        P=posit;
        %projection  
        for m=1:N
            for j = 1:n
                if P(m,j)<lowb(j)
                    P(m,j)=lowb(j);
                elseif P(m,j) > upb(j)
                    P(m,j)=upb(j);
                end
            end %for j=1:N
        end %for m=1:N
        %====
        C_B = float2bin(C,17)*2-1;%將群中心 編成bipolar表示法       
        P_B = float2bin(P,17)*2-1;%將LM後的N個點 編成bipolar表示法
        idx = hamming(C_B, P_B'); %對LM後的point分群,且是以LM前算出的群中心去分
        %====
        %計算各群cost 與distortion
        cluster_distortion = zeros(K,1);
        cost4cluster = zeros(K,1);
        for i=1:K
            size4cluster = sum(idx==i);
            cluster_i = P(idx==i,:);
            for j=1:size4cluster
                cost4cluster(i) = cost4cluster(i) + feval(fit_func,cluster_i(j,:));%計算cost           
            end
        end
        %選出fitness最小的
        [val,cluster4delete] = min(cost4cluster);
    end % if useLM
    %==========計算fitness ======================    
    for i = 1:N
        fitness(i) = feval(fit_func,P(i,:));
    end
    %=======delete one cluster who's avg cost is minimum ================
    %把最差的那些點換成目前為止最佳解附近的點
    if useHybrid && reduce_range && count4excuteLM >= 5   
        count4excuteLM=0;
        size4cluster = sum(idx==cluster4delete);
        vecLen = size(P(1,:),2);
        P(idx==cluster4delete,:) = bestsofar + rand(size4cluster,vecLen)-ones(1,vecLen)*(0.5);
        %projection  
        for m=1:N
            for j = 1:n
                if P(m,j)<lowb(j)
                    P(m,j)=lowb(j);
                elseif P(m,j) > upb(j)
                    P(m,j)=upb(j);
                end
            end %for j=1:N
        end %for m=1:N
    end
    
    %=======記錄此世代的平均值,最佳值,最差值 ================
    [bestvalue,best] = max(fitness);
    if bestvalue > bestvaluesofar
        count4excuteLM = 0;%歸零        
        bestsofar = P(best,:);% x_best
        bestvaluesofar = bestvalue;% f(x_bset)
    end
    myupper(k) = bestvalue;
    average(k) = mean(fitness);
    mylower(k) = min(fitness);
    %========== plot contour ======================
    %{
    if plo
          plot_3d(fit_func);
        plot(Mnew(:,1),Mnew(:,2),'k.', 'MarkerSize', 16);
        img_name = strcat('p[',num2str(k),']-muta.png');
        saveas(gcf, [img_name], 'png');
    end
    %}
    %========== show 結果 ====================================
    disp("")
    disp("iter:")
    disp(k)
    disp("optimal finiess:")
    disp(-bestvaluesofar)
    disp("optimal value:")
    disp(bestsofar)
    disp("========================")
    switch(k)
        case {110}        
            figure(k);
            title({[num2str(bestsofar)];[num2str(-bestvaluesofar)]});
    end
end %for

%======== show result =============
if k == max_iter
disp('Algorithm terminated after maximum number of iterations:');
disp(max_iter);
end
winner = bestsofar;
bestfitness = bestvaluesofar;
if strcmp(fit_func,'f_wave') || strcmp(fit_func,'f_wave2')
    bestfitness=-bestfitness;
    myupper = -myupper;
    average = -average;
    mylower = -mylower;
end
best_record = myupper;
if print
    figure(5)
    iter = [1:iteration]';
    plot(iter,myupper(1:iteration),'o:',iter,average(1:iteration),'x-',iter,mylower(1:iteration),'*--');
    legend('Best', 'Average', 'Worst','location','NortheastOutside');
    xlabel('Generations','Fontsize' ,14);
    ylabel('Objective Function Value','Fontsize',14);

    set(gca,'Fontsize',14);
    saveas(gcf, [fit_func,'.png'], 'png');
    hold off;
end

