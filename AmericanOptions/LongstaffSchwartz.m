%
%   Description: Instructive implementation of Longstaff-Schwartz
%   
%   Comments: 
%   0. The brute force method is way too slow: Monte Carlo in Monte Carlo to estimate
%   continuation value
%   1. Not at all optimized, I am honestly embarassed about how bad this
%   code is
%   2. note we truncate on x variable to only take paths in the money which has been shown to improve performance of
%   method. 
%   3. We are using constant interest rate and fixed step size.
%   4. We are estimating a stopping rule but we wont get the optimal one so
%   we have a slight negative bias
%   5. State of the art method is based on Chebychev-polynomials, see eg. https://arxiv.org/abs/1806.05579
%
%   Longstaff-Schwartz (LS): https://people.math.ethz.ch/~hjfurrer/teaching/LongstaffSchwartzAmericanOptionsLeastSquareMonteCarlo.pdf
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

%% Replicates tabelel of stock price paths from LS

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
%Note we are using a fixed interest rate
%But we could also have simulated one or used a non constant one
df=(exp(-r*dt).^(1:n))';

%Stopping time indicators
ST = zeros(R,n);
ST(:,end) = h(S(:,end),k)> 0;

%cashflow matrices
CF = zeros(R,n);
CF(:,end) = h(S(:,end),k);

%Loops over states starting at T-1
for i = 1:n-1
    
    %State payoffs
    payoffs = h(S(:,end-i),k);
    
    %(Note code only works for in the money from starts options)
    paths = payoffs>0; 
    
    %Selects X
    %pretty application specific, eg. multiple bonds or tenors for bonds
    %etc.
    x = S(:,end-i);
    X = [ones(R,1) x x.^2];
    
    %For each column forward in CF, discount appropriately to current time
    Y = (CF(:,(end-i+1):end))*df(1:i);

    %Estimates Beta on paths in the money
    beta = mvregress(X(paths,:),Y(paths,:));
    
    %Estimates continuation values for all paths
    ContVal=X*beta;
    
    %Longstaff & Schwartz approach
    Indicator = payoffs > ContVal;

    %Stopping time indicator updating
    %Horribly inefficient (uses for loops and runs through all columsn
    %every time!)
    ST(paths,end-i) = Indicator(paths);
    %Loops rows
    for j=1:R
        %reset called indicator
        called=0;
        %Loops columns
        for l=1:n
            %If called already we cant call it later
            if and(ST(j,l)==1,called==1) 
                called=1;
                ST(j,l)=0;
            end
            
            %Indicator for option having been called first time
            if and(ST(j,l)==1,called==0) 
                called=1;
            end
        end
    end
    
    %Current cash flow
    CF(:,end-i) = h(S(:,end-i),k).*Indicator;
    
    %Update previous Cash flows to avoid calling option in multiple periods
    CF = CF.*ST;
end

%Price matches Longstaff-Schwartz
mean(CF*df)
