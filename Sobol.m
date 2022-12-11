%illustrates Sobol sequence, with and without skipping and compares with
%uniform draws
clear all; clc;


%Constructs a d dimensional Sobol sequence
d = 2;  %Dimension
R = [10, 20, 50, 100, 500];  %Observations
%Sets up the sequence
p = sobolset(d);


%% Quasi random variables often have bad properties in higher dimensions..
% Sobol sequences usually do ok, but around 1111 dim we get troubles..
% Halton is in trouble very early
Dim = 32;
p = haltonset(Dim,'skip',0,'skip',0);
%p = sobolset(Dim,'skip',0,'skip',0);
X = net(p,1000);
subplot(1,2,1); plot(X(:,1),X(:,2),'*')
    title(['First 2 dimensions of Halton sequence']);
subplot(1,2,2); plot(X(:,Dim-1),X(:,Dim),'*')
    title(['First 31/32 dimensions of Halton sequence']);

%%

%Draws Sobol 
%Sets up the sequence
p = sobolset(d,'skip',0,'skip',0);
for j=1:length(R)
X = net(p,R(j));
    subplot(2,length(R),j); plot(X(:,1),X(:,2),'*')
    title(['Sobol for R = ' num2str(R(j))]);
end

%Draws uniforms
clear X
for j=1:length(R)
X  = unifrnd(0,1,R(j),2);
    subplot(2,length(R),j+5); plot(X(:,1),X(:,2),'*')
    title(['Uniform for R = ' num2str(R(j))]);
end


%Comments:
% 1. Remember Quasi RV's are not RV's so you cant use confidence interval!
%    (sequence can be randomised though)



