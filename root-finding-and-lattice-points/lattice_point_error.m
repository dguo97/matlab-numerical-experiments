function lattice_point_error(Rmax, C, a)
%LATTICE_POINT_ERROR Gauss circle problem: error E(R) = |N(R) - pi R^2|.
%   Plots N(R) against the area pi R^2, then the error E(R) for R = 0..RMAX
%   together with the empirical guide curve C*R^a (defaults RMAX = 500,
%   C = 7, a = 0.5).
%   Method: the exact count N(R) differs from the area pi R^2 by an error E(R)
%   that is conjectured to grow roughly like R^(1/2) (up to small factors); the
%   guide curve C R^a is an empirical comparison, not a proven bound.
%   Example:  lattice_point_error(200)

if nargin < 1, Rmax = 500; end
if nargin < 2, C = 7; end
if nargin < 3, a = 0.5; end
if ~isscalar(Rmax) || ~isnumeric(Rmax) || Rmax < 1 || Rmax ~= floor(Rmax)
    error('lattice_point_error:invalidInput', 'Rmax must be a positive integer.');
end

R = 0:Rmax;
N = count_lattice_points(R);

figure
plot(R, N, R, pi*R.^2);
xlabel('R'); ylabel('Number of lattice points');
legend('N(R)', '\pi R^2', 'Location', 'northwest');
title('Lattice points in a disc');

figure
E = abs(N - pi*R.^2);
plot(R, E, R, C*R.^a);
xlabel('R'); ylabel('E(R)');
legend('E(R)', sprintf('%g R^{%g}', C, a), 'Location', 'northwest');
title('Error of the area approximation');
end
