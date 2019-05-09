x = normrnd(0,1,1,500);
%[A,var] = AR(x,10);
%load('x_value.mat');
A = aryule(x,10); % 用函数直接完成功能
% to be or not to be？
A(1:10) = A(2:11);
A(11) = 0;
X = [];
for i = 1:10
    X(i) = x(i);
end

for i = 11:500
    X(i) = A(1)*x(i-1)+A(1)*x(i-2)+A(3)*x(i-3)+A(4)*x(i-4)+A(5)*x(i-5)...
           +A(6)*x(i-6)+A(7)*x(i-7)+A(8)*x(i-8)+A(9)*x(i-9)+A(10)*x(i-10);
end
X = X+0.1*wgn(1,500,1);
plot(x,'b');
hold on;
plot(X,'r');
xlim([0 500]);
legend('x','AR(10)');
title('原始数据&10阶自回归模型预测数据');
x = x';
save('x_value.mat','x');
save('AR(10)_value','X');