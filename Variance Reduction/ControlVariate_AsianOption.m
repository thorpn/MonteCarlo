
%   Description: Uses a European call as control for Asian call, we know EU call price from BS and it should correlate with the asian call.
%   In practice a much better control would be the geometric call option which is highly correlated with the asian call and has known price.

clear; close; clc  

%Inputs
n = 10000;                          	
T = 2;                              	
M = 5;                                %Places we sample
sigma = 0.25;                         %Standard deviations for GBMs
k = 5;                                %Strike price for basket option
r = 0.04;                                 
S0 = 6;               

%Simulation of GBM
Z = normrnd(0,1,n,M);
S = exp(cumsum((r-0.5*(sigma.^2))*(T/M)+sigma*sqrt((T/M)).*Z,2)+log(S0));

%Option payoffs
Asian_Payoffs = exp(-r*T)*max((mean(S,2)-k),0);
Control_Payoffs = exp(-r*T)*max((S(:,end)-k),0);

%Estimate prices by crude monnte carlo
Asian_PriceEst = mean(Asian_Payoffs);
Control_PriceEst = mean(Control_Payoffs);

%Price est using control variate
disp('CMC price estimate');
Asian_PriceEst

%Plots payoffs to show correlation
plot(Control_Payoffs,Asian_Payoffs,'*')

%Control mean (Calculated using Black-Scholes)
d1 = (1/(sigma*sqrt(T)))*(log(S0/k)+(r+0.5*sigma^2)*T);
d2 = d1-sigma*sqrt(T);
Control_Mean = normcdf(d1,0,1)*S0-normcdf(d2,0,1)*k*exp(-r*T);

%Calculates Y_i's
covariance= cov(Asian_Payoffs,Control_Payoffs);
alfa = - covariance(1,2)./covariance(2,2);
Y = Asian_Payoffs+alfa*(Control_Payoffs-Control_Mean);

%Prints correlation coefficient
disp('Correlation of payoffs');
rho = corr(Asian_Payoffs,Control_Payoffs)

%Price est using control variate
disp('Control variate price estimate');
mean(Y)

%Checks variances
disp('Variance ratio of payoffs');
var(Asian_Payoffs)/var(Y)

