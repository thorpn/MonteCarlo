%Clears memory and screen
clear all;
clc;

%Input variables for Brownian motion
T = 10;
n = 500;
mu = 0.05;
sigma = 0.10; 
S0 = 100;
dim = 200;

%Calls function
x = fBrownianMotion(T,n,mu,sigma,S0,dim);
subplot(1,2,1); plot(x)
subplot(1,2,2); histfit(x(end,:))
 
%Times function
tic
x = fBrownianMotion(T,n,mu,sigma,S0,dim);
toc
 
 
 
 
 
