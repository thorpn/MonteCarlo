%
%   Description: Simulates (possibly) several Geometric brownian motion of length n,
%   starting at different values over a time period of T with T/n length
%   intervals. Not totally optimized for speed (could define more
%   constants).
%
%   Author: Thor P. Nielsen
%   
%   Date: 14-01-2018
%
function S = fGeometricBrownianMotion(T,n,mu,sigma,S0,dim)
h = T/n;                        %step length
Z = normrnd(0,1,n,dim);         %White noise (Much faster to draw all at once)
S = NaN(n,dim);                 %Space for GBM

% % METHOD 1: Exponentiating a Brownian motion (non-optimized code)
S(1,:) = log(S0);
for i=1:n
   S(i+1,:)=S(i,:)+(mu-0.5*(sigma.^2))*h+sigma*sqrt(h).*Z(i,:);
end
S=exp(S);

% % % METHOD 2: Exponentiating a Brownian motion (optimized code)
% S(1:n,1:dim) = cumsum((mu-0.5*(sigma.^2))*h+sigma*sqrt(h).*Z);
% S(:,:) = S+log(S0);
% S=exp(S);
% 
% % Method 3: Euler discretization
% % Warning: Not-exact simulation unlike Methods 1 & 2
% S(1,:) = S0;
% for i =1:n
%      S(i+1,:) = S(i,:) + mu.*S(i,:)*h + S(i,:).*sigma*sqrt(h).*Z(i,:);
% end

%Method 4: Millstein discretization
%Warning: Not-exact simulation unlike Methods 1 & 2
% S(1,:) = S0;
% for i =1:n
%     S(i+1,:) = S(i,:) + mu.*S(i,:)*h + S(i,:).*sigma.*sqrt(h).*Z(i,:)+(1/2)*S(i,:).*sigma.*sigma.*h.*(Z(i,:).^2-1);
% end

return;
