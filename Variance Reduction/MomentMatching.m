clc; clear all;

%Number of simulations
R=200;

%Draws a sample
mu = 5;
sigma = 10;

z = normrnd(mu,sigma,R,1);

%Moment matches
z_mm = ((z-mean(z))/sqrt(var(z)))*sigma+mu;

%Plots densities
[f,xi] = ksdensity(z); 
plot(xi,f,'r');
hold on;
[f,xi] = ksdensity(z_mm); 
plot(xi,f,'b');
plot(xi,normpdf(xi,mu,sigma),'g')
legend('Sample density','MM density','True density')
