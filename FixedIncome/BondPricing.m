%
%   Description: Prices Zero coupon bond in CIR model:
%                dr = a(b-r)dt + s*sqrt(r)*dW
%   
%   Comment: Only t=0 works, this simplifies the pricing formula. 
%            Source for pricing formula is Hull, other stuff is Glassermann
%
clear all; clc;

%Inputs
a  = 0.4;       % mean-reversion parameter
b  = 0.10;      % long-term mean
s  = 0.3;       % volatility
r0 = 0.25;      % starting value
n  = 50;          % Steps
R  = 10000;       % Replications
T  = 1;

%Tests if parameters avoids negative values
2*a*b > s^2;

%Simulates either exactly or using Euler method, takes end point.
for i = 1:R
    CIR_Exact = f_CIR_Exact(a,b,s,r0,T,n);
    CIR_Euler = f_CIR_Euler(a,b,s,r0,T,n);
    
    %Price of bond is E[exp(-r(T-t))*f_T]
    %where r is the average interest rate over [t,T]
    %See Hull page 682. (For equally spaced steps, else see Glassermanns
    %book for general case of solving the integral)
    y1(i) = exp(-mean(CIR_Exact));
    y2(i) = exp(-mean(CIR_Euler));
end

%Plots the two samples
subplot(1,2,1);histfit(y1);
subplot(1,2,2); histfit(y2);

%Simulated prices
mean(y1)
mean(y2)

%2 sample KS test
%The result h is 1 if the test rejects the null hypothesis at the 5% significance level, and 0 otherwise.
%[h,p]  = kstest2(y1,y2)

%Analytical price
l = sqrt(a^2+2*s^2);
x = (exp(l*T)-1);
B = (2*x)/((l+a)*x+2*l);
A = ((2*l*exp((a+l)*(T)*0.5))/((l+a)*x+2*l))^((2*a*b)/(s^2));
P = A*exp(-B*r0)










