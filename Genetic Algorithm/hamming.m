function [idx]=hamming(W,X)
disp("hamming net..........")
trainSize = size(W,1); % train set 的數目=群數
vectorSize = size(W,2);% input vextor 的長度
testSize = size(X,2); % test set 的數目
epsilon = 1/(trainSize+1);
%{
if epsilon<=0 || epsilon > 1/trainSize
    disp("[hammingNet] epsilon <=0 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    return
end
%}
%===== phase 1: score net =============================
Score = (W*X + vectorSize)./2;
%===== phase 2: MAX net ===============================
T=eye(trainSize,trainSize)-epsilon*(ones(trainSize,trainSize)-eye(trainSize,trainSize));%max net所用matrix
%{

Score = max(Score,0);% 抑制非極大值
while(true)
    Score = T*Score;
    Score = max(Score,0) % 抑制非極大值
    if sum(Score,1)==max(Score) % if每個colum只有一個值>0 =>結束
        break
    end    
end
%}
%====================================
[ignore,idx]=max(Score);
idx=idx';
end
%{
W= [ 1 -1 -1 -1 ; -1 -1 -1 1];
X=[ 1  1 -1 -1 ; 1 -1 -1 -1 ; -1 -1 -1  1 ; -1 -1  1  1 ];
%}