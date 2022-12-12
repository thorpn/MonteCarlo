%PDF/CDF plotted
x = 0:0.001:6;
y1 = (2*x.*exp(-x.^2)); %PDF
y2 = 1-exp(-x.^2);      %CDF

subplot(1,3,1); plot(x,y1); 
xlim([0 3]);
title('PDF');

subplot(1,3,2); plot(x,y2);  
xlim([0 3]);
title('CDF');

%---------------------------------------------------------------
%Inversion
n = 10000;          %Number of simulated variables

%Starts matlabs clock
tic

%Step 1: Gets uniforms
u = unifrnd(0,1,n,1); 
%Step 2: Puts into quantile function
x1 = sqrt(-log(1-u));                  

%Stops matlabs clock
toc

%Local function of density for histogram plot
TargetDensity = @(x) (2*x.*exp(-x.^2)); 

%Makes a histogram with target density
subplot(1,3,3); 
[f,bars]=hist(x1,50);
dens= TargetDensity(bars);
bar(bars,f/trapz(bars,f));hold on
plot(bars,dens,'r',LineWidth = 1, color = 'red');

