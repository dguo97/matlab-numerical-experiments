function N = count_lattice_points(R)
%COUNT_LATTICE_POINTS Number of integer points (x,y) with x^2 + y^2 <= R^2.
%   Accepts a scalar or array of non-negative radii (R may be non-integer).
%   Counts one open quadrant plus an axis and uses symmetry:
%       N(R) = 1 + 4 * sum_{x=1}^{floor(R)} ( floor(sqrt(R^2 - x^2)) + 1 ).
%   Method: for each x = 1..floor(R) there are floor(sqrt(R^2 - x^2)) + 1 points
%   with y >= 0. These cover one quadrant (x > 0, y >= 0), so four copies by
%   rotation plus the origin give every point.
%   Example:  count_lattice_points(2)   % returns 13

if ~isnumeric(R) || ~isreal(R) || any(~isfinite(R(:))) || any(R(:) < 0)
    error('count_lattice_points:invalidInput', ...
        'R must be a finite, real, non-negative number or array.');
end

N = zeros(size(R));
for idx = 1:numel(R)
    r = R(idx);
    x = 1:floor(r);
    N(idx) = 1 + 4*sum(floor(sqrt(r^2 - x.^2)) + 1);
end
end
