%
%   Description: Compares crude monte carlo and conditional monte carlo
%   estimates for P(X_1,...X_n < x) with condtional monte carlo using the
%   sigma algebra given by (X_1,...,X_n-1)
%
%   Author: Thor P. Nielsen
%   
%   Date: 30-09-2021
%

%Preparation
clear all; clc;

%number of times we simulate our simulation
S = 10^3;

%Replications
R=10^2;

%numbers in sum
n=7;

%Sets logn-normal parameters so mean=1, variance=10
m=1; v=2;
mu=log((m^2)/sqrt(v+m^2));
sigma=sqrt(log(v/(m^2)+1));

%Sets a reasonably extreme x as n/2 times the mean 
x=n*m/3;

for j=1:S
    %Gets R replications
    for i=1:R
       %Draws sample
       X=lognrnd(mu,sigma,n,1);
       %calculates Z (cmc & cnd)
       Z_cmc(i) = sum(X)<x;
       Z_cnd(i) = logncdf(x-sum(X(1:(n-1))),mu,sigma);
    end

    %Gets estimates
    est_cmc(j) = mean(Z_cmc);
    est_cnd(j) = mean(Z_cnd);
end

%Mean of estimates
mean(est_cmc)
mean(est_cnd)

%Variance of estimates (scaled for nicer output)
var(est_cmc)*100000
var(est_cnd)*100000

%Ratio of variances
var(est_cmc)/var(est_cnd)

