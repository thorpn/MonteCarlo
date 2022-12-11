%Clears memory and screen
clear all; clc;

%Sets example parameters
mu=0.5;
sigma=2;
S0=1;

%Discretisation parameters
T=1;                            %End point
n=10;                            %Number of steps
h=T/n;                        %step length

%Hardcodes the shock/diffusion 
Z=2;

% METHOD 1: Exponentiating a Brownian motion
S(1) = log(S0);
for i=1:n
   S(i+1)=S(i)+(mu-0.5*(sigma.^2))*h+sigma*sqrt(h).*Z(i);
end
disp('Exact method');
S=exp(S(end))


% METHOD 2: Euler discretization
S(1) = S0;
for i =1:n
     S(i+1) = S(i,:) + mu.*S(i)*h + S(i,:).*sigma*sqrt(h).*Z(i);
end
disp('Euler method');
S(end)

% METHOD 3: Milstein discretization
S(1) = S0;
for i =1:n
    S(i+1) = S(i) + mu.*S(i)*h + S(i).*sigma.*sqrt(h).*Z(i)+(1/2)*S(i).*sigma.*sigma.*h.*(Z(i).^2-1);
end
disp('Millstein method');
S(end)


%Note: Try different T to see error decrease as h decreases




