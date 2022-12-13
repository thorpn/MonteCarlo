%
% Description: Simulates the Black-Scholes model and prices an EU call option along with a confidence interval
%
%
%
%


%Clears memory and screen
clear all; clc;

%stops scientific notation
format short g;

%Black-Scholes Model parameters
r = 0.07;       
mu = r; 
sigma = 0.15; 

%EU call option characteristics
S_0 = 115;
k = 120;
T = 10;

%Number of replications
R = 1000;

%Plots the log-normal distribution
x=0.01:0.01:5;
y=lognpdf(x,(mu-0.5*sigma^2)*T,T*sigma^2);
plot(x,y)

%Direct simulation of S(T) and V(T) (stock and Call payoff)
S_T = S_0*exp(normrnd((mu-0.5*sigma^2)*T,sigma*sqrt(T),1,R));
V_T = max(S_T(end,:)-k,0);

%Crude Monte Carlo Estimate
Est_Price = mean(exp(-r*T)*V_T)

%Black-scholes
d1 = (1/(sigma*sqrt(T)))*(log(S_0/k)+(r+0.5*sigma^2)*T);
d2 = d1-sigma*sqrt(T);
Actual_price = normcdf(d1,0,1)*S_0-normcdf(d2,0,1)*k*exp(-r*T)

%95% Confidence interval for price
Phi = norminv(0.975);
vol_V = sqrt(var(V_T));
CI = Est_Price + [-Phi*vol_V/sqrt(R) +Phi*vol_V/sqrt(R)]  

%The width of the CI (What happens if we 4x R?)
CI_width = 2*Phi*vol_V/sqrt(R)

%Simulation error for this estimate was
Actual_price-Est_Price

