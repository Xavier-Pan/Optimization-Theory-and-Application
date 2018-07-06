function [idx]=hamming(W,X)
disp("hamming net..........")
trainSize = size(W,1); % train set ���ƥ�=�s��
vectorSize = size(W,2);% input vextor ������
testSize = size(X,2); % test set ���ƥ�
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
T=eye(trainSize,trainSize)-epsilon*(ones(trainSize,trainSize)-eye(trainSize,trainSize));%max net�ҥ�matrix
%{

Score = max(Score,0);% ���D���j��
while(true)
    Score = T*Score;
    Score = max(Score,0) % ���D���j��
    if sum(Score,1)==max(Score) % if�C��colum�u���@�ӭ�>0 =>����
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