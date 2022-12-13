function[r] = f_CIR_Exact(a,b,sigma,r0,T,n)
% NOTES   : CIR: dr = a(b-r)dt + sigma*sqrt(r)*dW
%           Glasserman (2004, p. 124)


dt = T/n;       % Step size


r = nan(n+1,1);

%Constants
r(1) = r0;
v = sigma^2;
d = 4*a*b/v;
e = exp(-a*dt);
c = v.*(1-e)/(4*a);

for i = 1:n
    l = r(i)*e/c; 
    r(i+1) = c*ncx2rnd(d,l);
end   






