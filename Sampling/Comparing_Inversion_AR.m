%
%   Description: Inversion and A/R simulation of random variables with
%   density, histogram and QQ plots
%   
%   Comment: Can use targetdensity or targetdensityMEX to compare speeds
%            of using C code or matlab code.. about twice as fast
%
clear all; clc;

%Inputs
n = 10000;                       %Number of simulated variables

%---------------------------------------------------------------
%Density calculation
x = linspace(0,6,1000);      
y1= ftargetdensity(x);
figure(1)
subplot(3,2,1); plot(x,y1);  
xlim([0 3]);
title('Plot af density')
legend('Density')

%---------------------------------------------------------------
%Inversion
u = unifrnd(0,1,n,1);  
tic                          
x1 = sqrt(-log(1-u));          
inversiontimer = toc;         

subplot(3,2,3);  
fHistogramAndDensity(x1,50,@ftargetdensity)
title('Plot of density and histogram for Inversion variable')

%Quantile for Inversion
tq1 = sqrt(-log(1-(1:95)/100));
q1 = quantile(x1,(1:95)/100);
subplot(3,2,6); plot(tq1,q1,q1,q1)
title('QQ plot of theoretical and fitted fractiles - Inversion')
legend('Empirical quantiles','90 degree line','location','NorthWest')

%---------------------------------------------------------------
%proposal distribution
c=3;                          
alpha = 6;
beta = 3;
y2 = c*fpdf(x,alpha,beta);       

subplot(3,2,2); plot(x,y1,x,y2); 
xlim([0 3]);
title('Plot of density and envelope densities')
legend('Density','Envelope')

%---------------------------------------------------------------
%Acceptance / rejection
x2 = NaN(n,1);
i= 1;

tic
while i<(n+1)                  %Vi vil have n observationer
    y = frnd(alpha,beta);
    u1 = unifrnd(0,1); 
    
    if u1 <= targetdensityMEX(y)/(c*fpdf(y,alpha,beta))
        x2(i)=y;
        i=i+1;
    end
    
end
ARtimer = toc;

subplot(3,2,4); fHistogramAndDensity(x2,50,@ftargetdensity)
title('Plot of density and histogram for Inversion variable')

%Quantile for A/R
tq2 = sqrt(-log(1-(1:95)/100));
q2 = quantile(x2,(1:95)/100);
subplot(3,2,5); plot(tq2,q2,q2,q2)
title('QQ plot of theoretical and fitted fractiles - A/R')
legend('Empirical quantiles','90 degree line','location','NorthWest')

%Timers
ARtimer
inversiontimer




