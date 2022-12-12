%
%   Description: Target density function
%
%   Author: Thor P. Nielsen
%   
%   Input: x to evaluate in the target density function


function result = ftargetdensity(u1)

result = (2*u1.*exp(-u1.^2));
return;

end


