%
%   Description: Simulates (possibly) several Brownian motion of length n,
%   starting at different values over a time period of T with T/n length
%   intervals. Not totally optimized for speed (could define more
%   constants).
%
function S = fBrownianMotion(T,n,mu,sigma,S0,dim)
h = T/n;                        %step length
Z = normrnd(0,1,n,dim);         %White noise (Much faster to draw all at once)
S = NaN(n,dim);                 %Space for BM output

% METHOD 1: Brownian motion 
%(non-optimized code)
S(1,:) = S0;
for i=1:n
    S(i+1,:)=S(i,:)+mu*h+sigma*sqrt(h).*Z(i,:);
end

% % METHOD 2: Brownian motion (more optimized code as it avoids for loop)
% S(1:n,1:dim) = cumsum(mu*h+sigma*sqrt(h).*Z);
% S(:,:) = S+S0;

return;
