function [root, history] = bisection_root(x0, x1, tol)
%BISECTION_ROOT Bisection for f(x) = 2x cos x - sin x on [x0, x1].
%   [root, history] = BISECTION_ROOT(X0, X1, TOL). Defaults: X0 = 1.16 (f > 0),
%   X1 = 1.17 (f < 0), TOL = 1e-12. HISTORY has rows [x0, x1, iteration].
%   Example:  root = bisection_root   % about 1.16556

if nargin < 1, x0 = 1.16; end
if nargin < 2, x1 = 1.17; end
if nargin < 3, tol = 1e-12; end

f = @(x) 2*x.*cos(x) - sin(x);
if sign(f(x0)) == sign(f(x1))
    error('bisection_root:noBracket', 'f must change sign on [x0, x1].');
end

sign0 = sign(f(x0));
history = [x0 x1 1];
n = 1;
while abs(x1 - x0) > tol
    xm = (x0 + x1)/2;
    if sign(f(xm)) == sign0
        x0 = xm;
    else
        x1 = xm;
    end
    n = n + 1;
    history(end+1, :) = [x0 x1 n]; %#ok<AGROW>
end
root = (x0 + x1)/2;
end
