%
%   Description: Fractional Brownian motion, very simple toy example
%
%   Author: Thor P. Nielsen
%   
%   Date: 22-11-2018
%
%   Comment: ARMA models have geometric decline in correlation, Fractional
%   series have hyperbolically which is much slower.
%
clear; close; clc 

H= [0.25 0.5 0.75];                 %Hurst parameter
n=4100;                   %Time length

%Erklærer nogle sager
mSigma=NaN(n,n);
Y=NaN(length(H),n);
payout=NaN(length(H),1);
for r=1:length(H)

    %fixes seed
    rng(123)
    
    %Laver kovarians matricen
    for t=1:n
        for s=1:n
        mSigma(t,s)=1/2*(abs(t)^(2*H(r))+abs(s)^(2*H(r))-abs(t-s)^(2*H(r)));
        end
    end

    %Cholesky til at simulere variablene
    Y(r,:) = mvnrnd(zeros(n,1),mSigma,1);
    %Y(r,:) = normrnd(0,mSigma,1,n);
end


plot(Y')
legend(num2str(H(:)))
