% Description:
% A simple program to generate n random normals, and redraw all values
% larger than 2 from a chi(2) distribution
%
% Author:       Thor P. Nielsen (Thor.Nielsen@econ.ku.dk)
% Date:         13-01-2018
% Version:      1.0
%
%%




n = 5000;
x = normrnd(0,1,n,1);

%Loops over all observations
for i=1:n
    %If a value is greater than 2, replace with a value from a chi2rnd
    if x(i)>2
        x(i) = chi2rnd(1);
    end
end

%plot a histogram and kernel density
histfit(x)