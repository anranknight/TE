load('x_value.mat');
load('AR(10)_value.mat');

e=0.4;

X_e = (1-e)*x + e*X;
Y_e = e*x + (1-e)*X;

figure
plot(X_e,'b');
hold on;
plot(Y_e,'r');
xlim([0 500]);
legend('X_e','Y_e');
title('ÏßÐÔ»ìºÏ e=0.4');
save('X_e.mat','X_e');
save('Y_e.mat','Y_e');