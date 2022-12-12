%
%   Description: Plots a histogram with superimposed density
%
%   Author: Thor P. Nielsen
%   
%   Date: 05-09-2012
%   
%   Input: Data vector, number of bins, function for density



function fHistogramAndDensity(data,bins,density)

[f,bars]=hist(data,bins);
dens=density(bars);
bar(bars,f/trapz(bars,f));hold on
plot(bars,dens,'r');hold off

end

