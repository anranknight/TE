load('x_value.mat');
y_square = x.^2;

figure
plot(x,'b');
hold on;
plot(y_square,'r');
xlim([0 500]);
legend('x','Square relationship');
title('原始数据&平方关系变换');
save('y_square.mat','y_square');