load('x_value.mat');
y_pcd = 2*x;
y_pcd = circshift(y_pcd,1); %循环右移一位
figure
plot(x,'b');
hold on;
plot(y_pcd,'r');
xlim([0 500]);
legend('x','positive correlation with delay');
title('原始数据&正相关时延线性变换');
save('y_pcd.mat','y_pcd');