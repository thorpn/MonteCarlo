%
%   Description: Instructive implementation of Longstaff-Schwartz
%   
%   Comments: 
%   0. The brute force method is way too slow: Monte Carlo in Monte Carlo to estimate
%   continuation value
%   1. Not at all optimized code
%   2. note we truncate on x variable to only take paths in the money which has been shown to "improve performance" of
%   method
%   3. We are using constant interest rate and fixed step size.
%   4. We are estimating a stopping rule but we wont get the optimal one so
%   we have a slight negative bias
%   5. Note this is the simplest possible example; We could also have bonds which depend on many tenor points on interest rate curve
%   6. We could also have an option like max(S1,S2,S3,0) - this would give rise to more complex regression steps including interaction terms etc.
%   7. Current best practice is to use Chebyshev polynomials or Neural Networks instead of regression
%   8. Original article;
%   Longstaff-Schwartz: https://people.math.ethz.ch/~hjfurrer/teaching/LongstaffSchwartzAmericanOptionsLeastSquareMonteCarlo.pdf
%
%
clear all; clc;

%Simulation parameters
R = 8;      %Simulations
T = 3;       %Expiration 
n = 3;       %Steps 
dt = T/n;    %Stepsize

%BS model parameters
r = 0.06;
sigma = 0.4; 
S0 = 38;

%Option parameters
k = 1.10;                             %Strike
h = @(s,k) max(k-s.*ones(R,1),0);   %Payoff function

%Grabs functions for simulating GBM
addpath(genpath('D:\Google Drive\Ekstern lektor\Monte carlo - Seminar\Youtube\2022 Spring (YT)\Lectures\Lecture 2 - SDE and variance reduction'))

%Simulates GBM
S = fGeometricBrownianMotion(T,n,r,sigma,S0,R)';

%% Replicates tabels from LS

S = [1 1.09 1.08 1.34; 
1 1.16 1.26 1.54;
1 1.22 1.07 1.03;
1 0.93 0.97 0.92;
1 1.11 1.56 1.52;
1 0.76 0.77 0.9;
1 0.92 0.84 1.01;
1 0.88 1.22 1.34];

%%

%Gets discounts
df=exp(-r*dt);

%Gets final value
val = zeros(R,n+1);
val(:,end) = h(S(:,end),k);

%Stoppingtime and cashflow matrices
CF = zeros(R,n);
CF(:,end) = val(:,end);

%Off-line estimation
for i = 1:n-1
    
    %State payoffs
    payoffs = h(S(:,end-i),k);
    
    %(Note code only works for in the money from starts options)
    paths = payoffs>0; 
    
    %Selects X and Y (discounted)
    x = S(:,end-i);
    X = [ones(R,1) x x.^2];
    
    %For each column forward in CF, discount appropriately to current time
    Y = (CF(:,(end-i+1):end))*(df.^(1:i))';
    %Y = val(:,end-i+1).*df;

    %Estimates Beta on paths in the money
    beta = mvregress(X(paths,:),Y(paths,:));
    
    %Estimates continuation values for all paths
    ContVal=X*beta;
    
    %Longstaff & Schwartz approach
    Indicator = payoffs > ContVal;
    val(paths,end-i) = Indicator(paths).*payoffs(paths)+(1-Indicator(paths)).*ContVal(paths);

    %Stopping times
    
    
    %Current cash flow
    CF(:,end-i) = h(S(:,end-i),k).*Indicator;
    
    %Update previous Cash flows
    CF(:,end-i+1) = h(S(:,end-i+1),k).*(1-Indicator);
end

%Estimates t=0 value, seems slightly off ?
%4.472
mean(val(:,1))

