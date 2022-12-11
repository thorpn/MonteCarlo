
clear all; clc
n=10000;

x = unifrnd(0,1,n,2);

figure(1)
plot(x(:,1),x(:,2),'.')
hold on;
z=0.01:0.01:1;
plot(z,betapdf(z,0.5,0.5),LineWidth = 2)

%We discard all points above the pdf line
x(x(:,2)>normpdf(x(:,1),0.5,.4),:)=[];

figure(3)
plot(x(:,1),x(:,2),'*')
xlim([0,1])
ylim([0,1])

%We show a histogram
histogram(x(:,1))

