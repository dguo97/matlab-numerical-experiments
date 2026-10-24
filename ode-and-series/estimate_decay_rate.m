function k = estimate_decay_rate(k0, tol, maxIter)
%ESTIMATE_DECAY_RATE Fixed-point iteration for the decay rate k.
%   k = ESTIMATE_DECAY_RATE(K0, TOL, MAXITER) iterates
%       k <- log( (18(k^2+w^2) + 5k(k cos 5w + w sin 5w)) /
%                 (12(k^2+w^2) + 5k(k cos 6w + w sin 6w)) ),   w = pi/12,
%   starting from K0 until successive iterates differ by less than TOL.
%   Defaults: K0 = 2, TOL = 1e-10, MAXITER = 200.
%   Example:  k = estimate_decay_rate   % about 0.3892

if nargin < 1, k0 = 2; end
if nargin < 2, tol = 1e-10; end
if nargin < 3, maxIter = 200; end

w = pi/12;
k = k0;
for iter = 1:maxIter
    num = 18*(k^2 + w^2) + 5*k*(k*cos(5*w) + w*sin(5*w));
    den = 12*(k^2 + w^2) + 5*k*(k*cos(6*w) + w*sin(6*w));
    kNew = log(num/den);
    if abs(kNew - k) < tol
        k = kNew;
        return
    end
    k = kNew;
end
warning('estimate_decay_rate:noConvergence', ...
    'Did not converge to tolerance %g within %d iterations.', tol, maxIter);
end
