%Simulates a Brownian motion and a brownian bridge.
%Outcommented code to use stratified endpoints

clear all; clc;

dim=15;
mu = 1;
sigma = 1;
T = 1;                  %Length of Time
n = 1000;                %Number of steps
h = T/n;                %Stepsize
Z = normrnd(0,1,n,dim); %White noise


%Time intervals from 0 to T with stepsize 1/n
t = linspace(0,T,n)';

%Brownian motion by cumsum of normals
S(1:n,1:dim) = cumsum(mu*h+sigma*sqrt(h).*Z);

%Plots BM & endpoint
subplot(2,2,1); plot(t,S) 
subplot(2,2,2); histfit(S(end,1:dim));

%The Brownian bridge from (0,0) to (1,target)
target = 0;  %Endpoint of brownian bridge
Y = ones(dim,1).*target;

%Uses stratified endpoints instead
%U  = ((1:dim)' - 1 + unifrnd(0,1,dim,1))/dim;
%Y = norminv(U);

B = S + t/T * (Y'-S(end,1:dim));

%Plots bridge
subplot(2,2,3); plot(t,B) 
subplot(2,2,4); histfit(B(end,1:dim));
