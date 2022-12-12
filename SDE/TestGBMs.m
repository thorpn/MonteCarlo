
%Example parameters
T = 10;
n = 10000;
r = 0.05;
sigma = 0.3; 
S0 = 100;
dim = 20;

%go into function and try out the different ways of simulating the GBM..
%Note how the input given is treated..
tic;
y = fGeometricBrownianMotion(T,n,r,sigma,S0,dim);
toc

plot(y)
title('Geometric Brownian Motion')


%Example parameters 2 (365 days, E(S(T))~110, with
%var(S(T))~5
T  = 365;
n = 1000;
r = 0.00025;
sigma = 0.001;
S0 = 100;
dim = 1;

tic;
y = fGeometricBrownianMotion(T,n,r,sigma,S0,dim);
toc

plot(y)
mean(y(end,:))


%Set fgeometric to implementation with discretisation error

%Final comment: Of course if we only care about S(T), we can simulate it
%directly rather than the whole path. But many options are path dependent
%so that is not always a feasible solution.

clear all
EstimatedValue = [];
EstimatedValue2 = [];

%Pricing a call with different number of steps (and hence size of
%discretization error)
for n = 2:1:80
    k = 120;        T = 10;
    r = 0.07;       mu = r; 
    sigma = 0.15;     S0 = 115;
    dim = 100000;
    
    %Discretization of GBM (under Q)
    y = fGeometricBrownianMotion(T,n,mu,sigma,S0,dim);
    
    %Direct simulation of Y(T) 
    y2 = S0.*exp((mu-0.5*sigma^2)*T+sigma*sqrt(T)*normrnd(0,1,1,dim));
    
    %crude monte carlo estimate error
    EstimatedValue = [EstimatedValue exp(-r*T)*mean(max(y(end,:)-k,0))];
    EstimatedValue2 = [EstimatedValue2 exp(-r*T)*mean(max(y2(end,:)-k,0))];
end

%Black-scholes
d1 = (1/(sigma*sqrt(T)))*(log(S0/k)+(r+0.5*sigma^2)*T);
d2 = d1-sigma*sqrt(T);
PayoffAct = normcdf(d1,0,1)*S0-normcdf(d2,0,1)*k*exp(-r*T);


%convergence of price estimate with discretization
figure(2)
plot(EstimatedValue)


%convergence of price estimate with exact simulation
figure(3)
plot(EstimatedValue2)

