clear;
x=[2;2.5];
for k=1:198
x(k+2)=0.7*x(k+1)+0.2*x(k)+3*randn(1,1);
end
x=[x;zeros(4,1)];%加四个0，这不会影响分析结果
y=iddata(x);%转化为ARMX能识别的数据类型

s=ar(y(1:200),1)%注意分析时只用前200个数据。


p=predict(y,s,4);%预测，p为204期值

p = p.OutputData;

