function [root, history] = newton_root(x0, tol, maxIter)
%NEWTON_ROOT Newton-Raphson for f(x) = 2x cos x - sin x.
%   f'(x) = cos x - 2x sin x. Defaults: X0 = 1.16, TOL = 1e-12, MAXITER = 100.
%   HISTORY lists all iterates starting with X0.
%   Method: follow the tangent line to its zero. Near a simple root the number of
%   correct digits roughly doubles each step (quadratic convergence), so a
%   handful of iterations suffice, versus about 35 for bisection.
%   Example:  root = newton_root   % about 1.16556

if nargin < 1, x0 = 1.16; end
if nargin < 2, tol = 1e-12; end
if nargin < 3, maxIter = 100; end

if ~(isscalar(tol) && tol > 0) || ~(isscalar(maxIter) && maxIter >= 1)
    error('newton_root:invalidInput', 'tol must be positive and maxIter at least 1.');
end

f  = @(x) 2*x*cos(x) - sin(x);
fp = @(x) cos(x) - 2*x*sin(x);

history = x0;
x = x0;
for n = 1:maxIter
    if fp(x) == 0
        error('newton_root:zeroDerivative', ...
            'Derivative is zero at x = %g; choose a different starting point.', x);
    end
    xNew = x - f(x)/fp(x);
    history(end+1, 1) = xNew; %#ok<AGROW>
    if abs(xNew - x) <= tol
        root = xNew;
        return
    end
    x = xNew;
end
root = x;
warning('newton_root:noConvergence', 'No convergence within %d iterations.', maxIter);
end
