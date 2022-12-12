
clear all; clc

%Gaussian distribution example
x=-2:0.01:2;
target = normpdf(x,0,1);
proposal = tpdf(x,2);


subplot(2,1,1);
plot(x,target,LineWidth = 2, color = 'red');
xlim([min(x),max(x)]);
ylim([0,max(proposal*1.7)]);

hold on;
plot(x,proposal,LineWidth = 2, color = 'blue');

% Chooses constant as simply 2 
c =1.5;

hold on;
plot(x,c*proposal,LineWidth = 2, color = 'green');
legend('N(0,1) pdf','t(2) pdf','1.5 * t(2) pdf')

subplot(2,1,2); 
plot(x,target./(c*proposal),LineWidth = 2, color = 'black');

legend('probability of accepting given x: f(x)/(c*g(x))')




