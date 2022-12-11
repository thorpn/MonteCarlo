clear all; clc;

%Density function (anonymous function)
TargetDensity = @(x) (2*x.*exp(-x.^2)); 

%proposal
alpha = 6; beta = 3;
proposal= @(x) fpdf(x,alpha,beta);

%Constant
c = 3;     

%evaluates density
x = 0:0.001:4;  
y1= TargetDensity(x);

%Proposal
y2 = proposal(x);

%Envelope
y3 = c*proposal(x);     

%Probability of acceptance
y4 = y1./y3;

subplot(1,2,1); plot(x,y1,x,y2,x,y3,x,y4,LineWidth = 1); 
xlim([0 4]);
ylim([0 2]);
legend('Target Density (f)','proposal density (g)','Envelope (c*g)', 'Prob Accept')

%---------------------------------------------------------------
%Acceptance / rejection
n = 20000;  %simulations

%Starts matlabs clock
tic;

%Counter for tries
j=1;

%Uses a while loop to get n simulations
i= 1;
while i<(n+1)
    x = frnd(alpha,beta); %proposal draws
    u1 = unifrnd(0,1);    %Uniform draws
    
    %A/R step
    if u1 <= TargetDensity(x) /(c*proposal(x))
        y(i)=x;
        i=i+1;
    end
    j=j+1;
end

%Stops matlabs clock
toc

%acceptance frequency (should be close to 1/c)
n/j

%Makes a histogram with target density
subplot(1,2,2); 
[f,bars]=hist(y,60);
dens= TargetDensity(bars);
bar(bars,f/trapz(bars,f));hold on
plot(bars,dens,'r',LineWidth = 1, color = 'red');

