
%Tries without setting seed
normrnd(0,1)
normrnd(0,1)

%Sets the seed to 1234
rng(1234) 
normrnd(0,1)
%Sets the seed to 1234
rng(1234)
normrnd(0,1)

%you can control generators etc. in rng, see documentation. Default is
% the Mersenne twister
%
% In simulation based risk management you will usually test several seeds to check how sensitive capital requirements are to it
