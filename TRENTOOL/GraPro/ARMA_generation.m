load('x_value.mat');

%use ecolometrix modeler to get the ARMA data
% p = 10,q = 10
% get from the figure ARMA.fig
h1 = openfig('ARMA.fig'); % open figure
fig = gcf;
axObjs = fig.Children;
dataObjs = findobj(fig,'-property','YData');
y1 = dataObjs(1).YData;
Y = y1+0.1*wgn(1,500,1);

figure
plot(x,'b');
hold on;
plot(Y,'r');
xlim([0 500]);
legend('x','ARMA(10,10)');
title('原始数据&(10,10)自回归滑动平均模型预测数据');
save('ARMA_value','y1');


