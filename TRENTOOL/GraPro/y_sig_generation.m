load('x_value.mat');
ex = 1+50*x;
div = 1+exp(ex);
y_sig = 1./div;

figure
plot(x,'b');
hold on;
plot(y_sig,'r');
xlim([0 500]);
legend('x','Threshold relationship');
title('原始数据&阈值关系变换');
save('y_sig.mat','y_sig');