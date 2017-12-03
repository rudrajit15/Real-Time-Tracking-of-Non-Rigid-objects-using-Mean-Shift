function [rho] = get_rho(p,q)
t = p.*q;
rho = sqrt(sum(t(:)));




