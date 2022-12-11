


clear all; clc;

%Number of RV's
n = 1000;

%Makes Uniform draws by inversion
%Eg. the 100th RV will be (99+u)/100 
% So known to be between 0.99 and 1
U  = ((1:n)' - 1 + unifrnd(0,1,n,1))/n;

%Random variates
y1 = norminv(U);
y2 = normrnd(0,1,n,1);

%Plots histogram and Normal density
subplot(1,2,1); histfit(y1);
subplot(1,2,2); histfit(y2)

