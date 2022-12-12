clc; clear all;

%Number of simulations
R=10^6;

%Transformation from input to output
%try f(x)=x and f(x)=exp(x) ie. log-normal
transform = @(x) x;

%Crude Monte Carlo
tic
z = normrnd(0,1,R,1);
timer1 = toc;
y = transform(z);
crude_stdDev = sqrt(var(y))/sqrt(R);
CMC = mean(y);

%Antithetic 
clear y
M=R/2;
tic
z(1:M) = normrnd(0,1,M,1);
z((M+1):end) = -z(1:M);
timer2 = toc;
y = (transform(z(1:M))+transform(z((M+1):end)))/2;
AT_stdDev = sqrt(var(y))/sqrt(M);
AV = mean(y);

disp(['----------------------------------']);
disp(['CMC estimate = ' num2str(CMC)]);
disp(['AV estimate = ' num2str(AV)]);
disp(['----------------------------------']);
disp(['CMC std = ' num2str(crude_stdDev)]);
disp(['AV std = ' num2str(AT_stdDev)]);
disp(['----------------------------------']);
disp(['Relative computing efficiency = ' num2str(timer1/timer2)]);
disp(['Relative variance efficiency = ' num2str(crude_stdDev/AT_stdDev)]);


%Note:
% 1. If output (y) is linear function of (perfectly correlated) input (z), 
% AV is a zero variance estimator and always has right result. So we might expect larger variance
% reductions of linear mappings from the input roughly speaking
% 2. More general discussions can be found in Glassermann & in Asmussen,
% but it is often hard to have an a priori intuition so testing it out is
% often the best approach



