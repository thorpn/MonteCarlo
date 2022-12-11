%
%   Description: 
%
%   Author: Thor P. Nielsen
%   
%   Input: Data vector, number of bins, function for density


function result = ftargetdensity(u1)

result = (2*u1.*exp(-u1.^2));
return;

end


