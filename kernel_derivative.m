function [g] = kernel_derivative(x)
%g = 0.5*(exp(-0.5*x)/(2*pi));
if(x < 1)
    g = 0.75;
elseif(x == 1)
    g = 0.375;
else
    g = 0;
end
g = 0.5*(exp(-0.5*x)/(2*pi));