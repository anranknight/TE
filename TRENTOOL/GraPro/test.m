clear;
x=[2;2.5];
for k=1:198
x(k+2)=0.7*x(k+1)+0.2*x(k)+3*randn(1,1);
end
x=[x;zeros(4,1)];%���ĸ�0���ⲻ��Ӱ��������
y=iddata(x);%ת��ΪARMX��ʶ�����������

s=ar(y(1:200),1)%ע�����ʱֻ��ǰ200�����ݡ�


p=predict(y,s,4);%Ԥ�⣬pΪ204��ֵ

p = p.OutputData;

