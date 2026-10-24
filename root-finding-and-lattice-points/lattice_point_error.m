function lattice_point_error(Rmax, C, a)
%LATTICE_POINT_ERROR Gauss circle problem: error E(R) = |N(R) - pi R^2|.
%   Plots N(R) against the area pi R^2, then the error E(R) for R = 0..RMAX
%   together with the empirical guide curve C*R^a (defaults RMAX = 500,
%   C = 7, a = 0.5).
%   Example:  lattice_point_error(200)

if nargin < 1, Rmax = 500; end
if nargin < 2, C = 7; end
if nargin < 3, a = 0.5; end

R = 0:Rmax;
N = count_lattice_points(R);

figure
plot(R, N, R, pi*R.^2);
xlabel('R'); legend('N(R)', '\pi R^2', 'Location', 'northwest');
title('Lattice points in a disc');

figure
E = abs(N - pi*R.^2);
plot(R, E, R, C*R.^a);
xlabel('R'); ylabel('E(R)');
legend('E(R)', sprintf('%g R^{%g}', C, a), 'Location', 'northwest');
title('Error of the area approximation');
end
