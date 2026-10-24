function E = find_constant_E(target, t, k)
%FIND_CONSTANT_E Constant E such that the solution y(t) equals TARGET.
%   The solution has the form
%       y(t) = 3 - 5k( w sin(w(t-2)) + k cos(w(t-2)) )/(k^2+w^2) + E exp(-k t),
%   with w = pi/12. E = FIND_CONSTANT_E(TARGET, T, K) solves y(T) = TARGET.
%   Defaults: TARGET = 21, T = 7, K = 0.3892.
%   (TARGET = 15 at T = 8 gives the same value of E to within rounding of K.)
%   Example:  E = find_constant_E(21, 7)   % about 322.1

if nargin < 1, target = 21; end
if nargin < 2, t = 7; end
if nargin < 3, k = 0.3892; end

w = pi/12;
particular = 3 - 5*k*(w*sin(w*(t-2)) + k*cos(w*(t-2)))/(k^2 + w^2);
E = (target - particular)/exp(-k*t);
end
