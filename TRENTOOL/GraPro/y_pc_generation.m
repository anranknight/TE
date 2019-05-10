load('x_value.mat');
y_pc = 2*x;
figure
plot(x,'b');
hold on;
plot(y_pc,'r');
xlim([0 500]);
legend('x','positive correlation');
title('原始数据&正相关线性变换');
save('y_pc.mat','y_pc');