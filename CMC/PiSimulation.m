%
% Description: A classic simulation example: Estimating pi by simulating dots on unit circle (area=pi) on the square
%([-1,1],[-1,1]) and multiply ratio of dots inside unit cirlce to outside
%by 4 (area of square) to estimate pi.

clear all; clc;
n=100:100:10000;         %#dots used
m=250;                  %#replications to see std. dev. of estimate

%memory allocation
Estimate = NaN(length(n),1);
Error = NaN(length(n),1);
StdError = NaN(length(n),1);

%Creates local function to calculate distance from (0,0)
FunDistance = @(x1,x2) sqrt(x1.^2.+x2.^2);

%Loops over sample sizes
for i = 1:length(n)
    %Gets m estimates per sample size to estimate std. dev. of error
    for j=1:m
        %Draws coordinates from [-1,1]
        X = unifrnd(-1,1,n(i),2);
        %Gets distance from (0,0)
        y = FunDistance(X(:,1),X(:,2));
        %estimates pi by scaling fraction with area
        Estimate(i,j) = 4*mean(y<1);
        %gets error
        Error(i,j) =  Estimate(i,j)-pi;
        %plots first simulation
        if i==1 && j==1
           figure(1)
           subplot(1,3,1); 
           plot(X(:,1),X(:,2),'*')
           title('We estimate pi by simulation - n = 100')
           hold on;
           plot(-1:0.01:1,sqrt(1-(-1:0.01:1).^2),'red')
           hold on;
           plot(-1:0.01:1,-sqrt(1-(-1:0.01:1).^2),'red')
        end
    end
    StdError(i) = sqrt(var(Error(i,:)));
end

%Plots estimates and std. error
subplot(1,3,2); 
plot(n,Estimate(:,1))
hold on; plot(n,ones(length(n),1).*pi,'red')
title('Estimate vs. sample size (n)')
subplot(1,3,3); 
plot(n,StdError)
title('Estimate std. error vs. sample size (n)')

%Some helpful text
disp(['Pi estimate = 4 x ' num2str(mean(y<1)) ' = ' num2str(mean(y<1)*4)])
