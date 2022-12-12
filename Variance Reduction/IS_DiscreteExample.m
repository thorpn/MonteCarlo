%Simulates an option with payoff 1001 (probability p) or 1 (probability
%1-p), estimates payoff by CMC and IS
clear all; clc;

n= 100;         % n parameter
m = 10000;      % Monte carlo replications
p = 0.01;       % Target distribution parameter
p2 = 0.7;       % Importance parameter

for i = 1:m
%CMC estimator
x = binornd(1,p,n,1); %n observations of 1 or 1001
z = x*1000+1;
CMC_Estimate(i) = mean(z);

%Importance sampling
x = binornd(1,p2,n,1); %proposal draws
z = x*1000+1;
L = (binopdf(x,1,p))./binopdf(x,1,p2); %likelihood ratio
Z = z.*L;
IS_Estimate(i) = mean(Z);
    
end

%stops using scientific notation
format short g

%CMC output
disp(['-----------------------------']);
disp([' CMC Output: ']);
disp(['Mean Estimate: ' num2str(mean(CMC_Estimate))]);
disp(['Var of Estimate: ' num2str(var(CMC_Estimate))]);
disp(['-----------------------------']);

%IS output
disp(['-----------------------------']);
disp([' IS Output: ']);
disp(['Mean Estimate: ' num2str(mean(IS_Estimate))]);
disp(['Var of Estimate: ' num2str(var(IS_Estimate))]);
disp(['-----------------------------']);

%CMC / IS ratio of variance
disp(['Relative efficiency: ' num2str(var(CMC_Estimate)/var(IS_Estimate))]);

