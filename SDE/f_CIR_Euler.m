function[r] = f_CIR_Euler(a,b,sigma,r0,T,n)
%CIR: dr = a(b-r)dt + s*sqrt(r)*dW
%Glassermann 124

h = T/n;       % Step size

Z = normrnd(0,1,n,1);         %White noise

r = nan(n+1,1);

%Constants
r(1) = r0;

%Note takes abs values to avoid taking square root of negative numbers, see
%Glassermann eq. 3.66
for i = 1:n
    r(i+1) = r(i)+a*(b-r(i))*h+sigma*sqrt(abs(r(i)))*sqrt(h)*Z(i);
end   
