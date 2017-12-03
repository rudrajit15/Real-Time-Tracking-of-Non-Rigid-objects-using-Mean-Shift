function [f] = kernel(x)
%f = exp(-0.5*x)/(2*pi);
if(x < 1)
    f = 0.75*(1-x);
else
    f = 0;
end
f = exp(-0.5*x)/(2*pi);