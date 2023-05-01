%Simulates tail behavior of Normal/t copulas to illustrate tail dependence behavior

clear all;
clc;

%Gaussian copula
n = 1000; 
rho = .85;
Z = mvnrnd([0 0],[1 rho; rho 1],n);
%Get the copula
U = normcdf(Z);
%We get get gamma and t marginals
X = [gaminv(U(:,1),2,1) tinv(U(:,2),5)];

scatterhist(U(:,1),U(:,2))
% Scatter plot of data with histograms 
figure
scatterhist(X(:,1),X(:,2),'Direction','out')

% A look at Tail behavior via plots, correaltion and ruin probabilities
n = 1000000; 
rho = .95;
Z = mvnrnd([0 0],[1 rho; rho 1],n);

% %Multivariate t (99% Correlation, 2 DF)
% SIGMA = [1 0.99;0.99 1];
% Z = mvtrnd(SIGMA,2,n);

Borders = [-1 1:1:4];

for i = 1:length(Borders)
    subplot(2,3,i); 
    x = Z(Z(:,1)>Borders(i),1);
    y = Z(Z(:,1)>Borders(i),2);
    plot(x,y,'*');
    %Correalation
    corrz = corr(x,y);
    title(append('X1>', num2str(Borders(i)), ', Corr=', num2str(corrz)))
    %Proportion of X2>q|X1>q
    %mean(Z(Z(:,1)>1,2)>1)
    
end
