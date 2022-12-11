%
%   Description: simulating European call option in BS model with pseudo
%   and quasi random numbers. Takes 2nd dimension of sobol/Halton since 1st
%   is equivalent
%
%   Author: Thor P. Nielsen
%   
%Initializations
clear; close; clc 

%Inputs for GBM and call option
nvector = 500:50:15000;
k = 120;        
T = 10;
r = 0.07;       
mu = r; 
sigma = 0.15;     
S0 = 115;
    
%space for mean estimates
[Crudeestimates, Quasiestimates1, Quasiestimates2] = deal(NaN(length(nvector),1));

%Starts simulation
for l=1:length(nvector)
    n =nvector(l);

    %Crude Monte-Carlo simulation via pseudo random
    Z = norminv(unifrnd(0,1,n,1));
    VFinalstockprice = S0.*exp((mu-0.5*sigma^2)*T+sigma*sqrt(T)*Z);
    vOptionValues =max(exp(-r*T)*(VFinalstockprice-k),0);
    Crudeestimates(l) = mean(vOptionValues);

    %Quasi Monte-Carlo simulation using Halton sequence
    q1 = qrandstream('halton',2,'Skip',1000);
    QuasiNumbers = qrand(q1,n);
    Z = norminv(QuasiNumbers(:,2));
    VFinalstockprice = S0.*exp((mu-0.5*sigma^2)*T+sigma*sqrt(T)*Z);
    vOptionValues =max(exp(-r*T)*(VFinalstockprice-k),0);
    Quasiestimates1(l) = mean(vOptionValues);

    %Quasi Monte-Carlo simulation using Sobol sequence
    q2 = qrandstream('sobol',2,'Skip',1000);
    QuasiNumbers = qrand(q2,n);
    Z = norminv(QuasiNumbers(:,2));
    VFinalstockprice = S0.*exp((mu-0.5*sigma^2)*T+sigma*sqrt(T)*Z);
    vOptionValues =max(exp(-r*T)*(VFinalstockprice-k),0);
    Quasiestimates2(l) = mean(vOptionValues);
end

plot(nvector,Crudeestimates,nvector,Quasiestimates1,nvector,Quasiestimates2)
legend('Crude','Halton','Sobol')
