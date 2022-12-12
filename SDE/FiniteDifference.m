%Illustrates finite difference method on basket call
%Adapted from code by Mike Giles

clear all; close all

%Input for geometric brownian motion
N     = 10^5;
r     = 0.05;
sigma = 0.2;
T     = 1;
K     = 100;
S0    = 100;

%Uses cholesky decomposition rather than directly drawing from Matlab
Omega = eye(5) + 0.1*(ones(5)-eye(5));
L     = chol(Omega,'lower');

vals  = [];
vars  = [];
bumps = [];

%On purpose makes first bump so small floating point errors are an issue
eps('double')
for bump = linspace(10^-12,5,30)
    rng('default');          % reset random number generator
    fm = basket_vals(r,sigma,L,T,S0-bump,K, N);
    rng('default');          % reset random number generator
    fp = basket_vals(r,sigma,L,T,S0+bump,K, N);

    %Estimate by central Finite diff
    Del = (fp-fm)/(2*bump); %Get FD's
    val =  sum(Del)/N;      %Estimate by average
    var = (sum(Del.^2)/N - val^2)/(N-1); %Variance estimate

    %Keeps track of estimates, variances and bump sizes
    vals  = [vals  val];
    vars  = [vars  var];
    bumps = [bumps bump];
end

  subplot(2,1,1)
  plot(bumps,vals,'-x');
  xlabel('bump'); ylabel('Delta')

  title('same random numbers')
  subplot(2,1,2)
  plot(bumps,vars,'-x');
  xlabel('bump'); ylabel('Variance')

% function to evaluate lots of samples of basket call
function F = basket_vals(r,sigma,L,T,S0,K, N)

Y = randn(5,N);
S = S0*exp((r-sigma^2/2)*T + sigma*sqrt(T)*L*Y);
F = exp(-r*T)*max(0,sum(S,1)/5-K);

end
