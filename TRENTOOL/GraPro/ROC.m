load('D:\GitHub\TE\TRENTOOL\GraPro\TE.mat');
load('D:\GitHub\TE\TRENTOOL\GraPro\TE_Rest.mat');
A = sum(TE,2)/3;
B = zeros(4,7);
roc = zeros(7,4);
B(:,:) = A(:,1,:);
B = B';
%B = abs(B');
%TE_Rest = abs(TE_Rest);
for i = 1:7
    for j = 1:4
        roc(i,j) = (B(i,j)-TE_Rest(i,1))/TE_Rest(i,1);
    end
end
roc = abs(roc);
figure
subplot(2,2,1);
plot(roc(:,1));
Roc = sum(roc)/7;
    