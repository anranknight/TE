load('x_value.mat');
y_nc = -2*x;

figure
plot(x,'b');
hold on;
plot(y_nc,'r');
xlim([0 500]);
legend('x','positive correlation');
title('ԭʼ����&��������Ա任');
save('y_nc.mat','y_nc');