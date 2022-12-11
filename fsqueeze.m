%
%   Description: 
%
%   Author: Thor P. Nielsen
%   
%   Input: Data vector, number of bins, function for density


function result = fsqueeze(x)


switch x
    case <0.15
        disp('negative one')
    case 0
        disp('zero')
    case 1
        disp('positive one')
    otherwise
        disp('other value')
end
end


