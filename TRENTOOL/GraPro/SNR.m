load('x_value.mat');
load('AR(10)_value.mat');

e=0.8;

X_e = x;
Y_e = (1-e)*x + e*wgn(1,500,1);

figure
plot(X_e,'b');
hold on;
plot(Y_e,'r');
xlim([0 500]);
legend('X_e','Y_e');
title('‘Î…˘”∞œÏ e=0.8');
save('X_e_noi.mat','X_e');
save('Y_e_noi.mat','Y_e');