load('x_value.mat');
y_square = x.^2;

figure
plot(x,'b');
hold on;
plot(y_square,'r');
xlim([0 500]);
legend('x','Square relationship');
title('ԭʼ����&ƽ����ϵ�任');
save('y_square.mat','y_square');