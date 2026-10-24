function J = bessel_series(tol)
%BESSEL_SERIES Power-series values of J0(1) and J0'(1).
%   J = BESSEL_SERIES(TOL) sums
%       J0(t)  = sum_k (-1)^k (t/2)^(2k) / (k!)^2
%       J0'(t) = sum_k (-1)^k k (t/2)^(2k-1) / (k!)^2
%   at t = 1. Both series alternate in sign, so stopping when the latest term
%   is below TOL bounds the truncation error by TOL (default 1e-4).
%   J is [value terms error; value terms error]: row 1 for J0(1), row 2 for J0'(1).
%   Example:  J = bessel_series(1e-4)   % J(1,1) is about 0.7652

if nargin < 1, tol = 1e-4; end

t = 1;
[v0, n0, e0] = alternating_sum(@(k) (-1)^k * (t/2)^(2*k) / factorial(k)^2, tol);
[v1, n1, e1] = alternating_sum(@(k) (-1)^k * k * (t/2)^(2*k-1) / factorial(k)^2, tol);
J = [v0 n0 e0; v1 n1 e1];
end

function [total, nTerms, lastTerm] = alternating_sum(term, tol)
total = term(0);
k = 0;
lastTerm = Inf;
while abs(lastTerm) > tol
    k = k + 1;
    lastTerm = term(k);
    total = total + lastTerm;
end
nTerms = k + 1;
end
