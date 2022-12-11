% Description:
% Illustrates vectoring of a for loop
%
% Author:       Thor P. Nielsen (Thor.Nielsen@econ.ku.dk)
% Date:         13-01-2018
% Version:      1.0
%
%%

%Example 1: Squarring Chi2 variables
clear all; clc;
n = 60000000;
x = chi2rnd(1,n,1);

tic
for i=1:n
x(i) = x(i)^2;   
end
ForTimer = toc

x = chi2rnd(1,n,1);
tic
x=x.^2;
VectorizedTimer = toc

ForTimer/VectorizedTimer

%Example 2: Geometric brownian motion simulation
T = 1;
n = 10000;                       %Steps to use
h = T/n;                        %step length
mu = 0.05;
sigma = 0.3; 
S0 = 100;
dim = 10000;
Z = normrnd(0,1,n,dim);
S = NaN(n,dim);

%METHOD 1: Exponentiating a Brownian motion (non-optimized code)
tic;
S(1,:) = log(S0);
for i=1:n
    S(i+1,:)=S(i,:)+(mu-0.5*(sigma.^2))*h+sigma*sqrt(h).*Z(i,:);
end
S=exp(S);
GBMFor = toc

% METHOD 2: Exponentiating a Brownian motion (optimized code)
tic;
S(1:n,1:dim) = cumsum((mu-0.5*(sigma.^2))*h+sigma*sqrt(h).*Z);
S(:,:) = S+log(S0);
S=exp(S);
GBMVec = toc

GBMFor/GBMVec
