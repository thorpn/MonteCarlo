% Description:
% Small program to compare speeds of various operators
%
% Author:       Thor P. Nielsen (Thor.Nielsen@econ.ku.dk)
% Date:         13-01-2018
% Version:      1.0
%
%%

clc
n=5000000;
disp(['Time to do the following on ' num2str(n) ' doubles (in seconds)']);


x = chi2rnd(1,n,1);
y = chi2rnd(1,n,1);

tic
for i=1:n
  y(i) = x(i)+x(i);
end
disp(['Addition: ' num2str(toc)])

tic
for i=1:n
  y(i) = x(i).^2;
end
disp(['squaring: ' num2str(toc)])

tic
for i=1:n
  y(i) = x(i)^2;
end
disp(['squaring: ' num2str(toc)])

tic
for i=1:n
  y(i) = x(i)*x(i);
end
disp(['squaring: ' num2str(toc)])

x = chi2rnd(1,n,1);
tic
for i=1:n
  y(i) = log(x(i));
end
disp(['log: ' num2str(toc)])

tic
for i=1:n
  y(i) = cos(x(i));
end
disp(['cos: ' num2str(toc)])

tic
y = cos(x);
toc

