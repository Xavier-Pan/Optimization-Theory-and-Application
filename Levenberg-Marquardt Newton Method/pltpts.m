function out=pltpts(xnew,xcurr) 
    % Plots Two points and connects them via red line   
    plot([xcurr(1),xnew(1)],[xcurr(2),xnew(2)], 'r - ' ,xnew(1),xnew(2), ... 
        'bo' ,xcurr(1),xcurr(2), 'ro');
    drawnow; % Draws current graph now 
    hold on
    out = [];
    