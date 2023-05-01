% This programs looks at the Bias and Variance of two estimators
% It is written for readability
clear all; clc;

mu      = 10;
Sigma2  = 10;
n       = 100;
R       = 1000;

for i=1:R
    % Note normrnd takes standard deviation, not variance
    % you can chech with F1
    % remember to also give normrnd the 1, or you get a (huge) matrix
    X = normrnd(mu,sqrt(Sigma2),n,1);
    
    %The two estimators
    ThetaHat1(i) = mean(X);
    ThetaHat2(i) = (mean(X)+5/n)*2;
    
end

Bias1 = mean(ThetaHat1-mu)
var1 = var(ThetaHat1)

Bias2 = mean(ThetaHat2-mu)
var2 = var(ThetaHat2)

var1/var2

%Also good idea to check normality of estimator visually..
subplot(1,2,1); histfit(ThetaHat1)
subplot(1,2,2); histfit(ThetaHat2)


