load('x_value.mat');
y_pc = 2*x;
figure
plot(x,'b');
hold on;
plot(y_pc,'r');
xlim([0 500]);
legend('x','positive correlation');
title('ԭʼ����&��������Ա任');
save('y_pc.mat','y_pc');