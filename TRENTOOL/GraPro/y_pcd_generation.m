load('x_value.mat');
y_pcd = 2*x;
y_pcd = circshift(y_pcd,1); %ѭ������һλ
figure
plot(x,'b');
hold on;
plot(y_pcd,'r');
xlim([0 500]);
legend('x','positive correlation with delay');
title('ԭʼ����&�����ʱ�����Ա任');
save('y_pcd.mat','y_pcd');