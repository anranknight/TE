load('x_value.mat');
y_nc = -2*x;

figure
plot(x,'b');
hold on;
plot(y_nc,'r');
xlim([0 500]);
legend('x','positive correlation');
title('原始数据&负相关线性变换');
save('y_nc.mat','y_nc');