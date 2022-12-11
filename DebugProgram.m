% Description:
% Small program to demonstrate various errors and debugging methods
%
% Author:       Thor P. Nielsen (Thor.Nielsen@econ.ku.dk)
% Date:         13-01-2018
% Version:      1.0
%
%%

clear all; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Example 1:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = 1000;
x = normrnd(2,1,n,1);

for i=1:n
   x(i) = sqrt(x(i)); 
end

%No errors so far..


%but if we print output we see the problem!
disp(x)

%so we can instead step through it with f10

x = normrnd(2,1,n,1);

for i=1:n
   x(i) = sqrt(x(i)); 
end


%Instead of stepping through till we get the problem, we can make a
%breakpoint by clicking on the "breakpoint alley" in the left side of the
%screen
for i=1:n
    %If statement to find problem
    if imag(sqrt(x(i)))>0
        Problem = 1;
    end
    
    x(i) = sqrt(x(i)); 
end


