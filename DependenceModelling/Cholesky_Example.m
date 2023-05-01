% Description: Shows cholesky decomposition of covariance matrix
  
clear all; clc;

%Define a covaraiance matrix
Sigma = [1,0.9 ; 0.9,1];
mu = [2;1];

%Lets get 100 samples in pairs of 2
n = 100;
[Y,C] = mvnrnd(mu,Sigma,n);

%prints realizations
Y

%Plots realizations
plot(Y(:,1),Y(:,2),'.')

%Prints sigma and cholesky factor
Sigma
C'
