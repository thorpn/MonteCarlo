
%Number of uniforms drawn
n = 5;

%Draws uniforms
u = unifrnd(0,1,n,1)

%Uses built in quantile function
x = norminv(u')

%Plot of Normal dist. CDF
x = -4:0.01:4;
y = normcdf(x);
plot(x,y)

%Adds lines
for i = 1:length(u)
    %Horizontal line
    x = linspace(-4,norminv(u(i)));
    y = linspace(u(i),u(i));
    line(x,y,'Color','red','LineStyle','--')

    %Vertical line
    x = linspace(norminv(u(i)),norminv(u(i)));
    y = linspace(u(i),0);
    line(x,y,'Color','red','LineStyle','--')
end

