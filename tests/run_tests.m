% RUN_TESTS  Basic regression tests for the functions in this repository.
%   Run from MATLAB with:  run('tests/run_tests.m')
%   Prints "All tests passed" or stops at the first failing check.

root = fileparts(fileparts(mfilename('fullpath')));
addpath(genpath(root));

%% ode-and-series
k = estimate_decay_rate;
assert(abs(k - 0.3892) < 1e-4, 'estimate_decay_rate');

E = find_constant_E(21, 7);
assert(abs(E - 322.1) < 0.1, 'find_constant_E');

J = bessel_series(1e-4);
assert(abs(J(1,1) - 0.7651977) < 1e-3, 'bessel_series: J0(1)');
assert(abs(J(2,1) + 0.4400505) < 1e-3, 'bessel_series: J0''(1)');

[~, y] = ode45(@bessel_rhs, [1 5], [J(1,1); J(2,1)], odeset('RelTol',1e-9,'AbsTol',1e-12));
assert(abs(y(end,1) + 0.1775968) < 1e-3, 'bessel_rhs: J0(5)');

%% random-simulations (statistical checks with generous tolerances)
close all
m = longest_streak_simulation(1000, 200, 1);
assert(numel(m) == 200 && mean(m) > 6 && mean(m) < 14, 'longest_streak_simulation');

T = card_collecting(100, 500, 1);
assert(numel(T) == 500 && abs(mean(T) - 518.7) < 52, 'card_collecting');

% the seed makes results reproducible
m2 = longest_streak_simulation(1000, 200, 1);
T2 = card_collecting(100, 500, 1);
assert(isequal(m, m2) && isequal(T, T2), 'seeded simulations must be reproducible');
close all

%% implicit-plots-and-conics
v = conic_fit;
assert(isequal(size(v), [5 1]), 'conic_fit size');
X = [1.03 0.95 0.87 0.77 0.67 0.56 0.43 0.30 0.16 0.01];
Y = [0.39 0.32 0.27 0.22 0.18 0.15 0.13 0.12 0.13 0.15];
resid = [X.^2; X.*Y; Y.^2; X; Y]' * v + 1;
assert(max(abs(resid)) < 0.05, 'conic_fit residual');
close all

%% root-finding-and-lattice-points
assert(count_lattice_points(0) == 1, 'lattice R=0');
assert(count_lattice_points(1) == 5, 'lattice R=1');
assert(count_lattice_points(2) == 13, 'lattice R=2');
assert(count_lattice_points(5) == 81, 'lattice R=5');
assert(isequal(count_lattice_points([1 2]), [5 13]), 'lattice vector input');

r1 = bisection_root;
r2 = newton_root;
assert(abs(r1 - 1.16556118520721) < 1e-9, 'bisection_root');
assert(abs(r2 - 1.16556118520721) < 1e-9, 'newton_root');

%% recursive-curves
p = koch([0;0], [1;0], 2);
assert(isequal(size(p), [2 17]), 'koch size');
assert(isequal(p(:,1), [0;0]) && isequal(p(:,end), [1;0]), 'koch endpoints');
assert(abs(max(p(2,:)) - sqrt(3)/6) < 1e-12, 'koch peak height');

h = hilbert_curve([0;0], [1;0], 3);
assert(isequal(size(h), [2 256]), 'hilbert size');

assert(has_equal_line_sums(magic(4)), 'magic(4)');
assert(has_equal_line_sums(magic(3)^5), 'magic(3)^5');
assert(~has_equal_line_sums([1 2; 3 4]), 'non-magic');
assert(~has_equal_line_sums(ones(2,3)), 'non-square');

%% input validation (bad input must give an error, not a wrong answer)
assert(throws(@() count_lattice_points(-1)),            'lattice negative R');
assert(throws(@() count_lattice_points('a')),           'lattice non-numeric R');
assert(throws(@() koch([0;0], [1;0], -1)),              'koch negative level');
assert(throws(@() koch([0;0], [1;0], 1.5)),             'koch non-integer level');
assert(throws(@() hilbert_curve([0;0], [1;0], -2)),     'hilbert negative level');
assert(throws(@() longest_streak_simulation(0, 10)),    'streak N = 0');
assert(throws(@() card_collecting(100, -5)),            'cards M < 0');
assert(throws(@() bisection_root(1, 1.1)),              'bisection without a sign change');
assert(throws(@() has_equal_line_sums([])),             'empty matrix');
assert(throws(@() conic_plot(1, 2, 3)),                 'conic_plot wrong arg count');
close all

disp('All tests passed.')

function tf = throws(f)
%THROWS True if calling the function handle F raises an error.
tf = false;
try
    f();
catch
    tf = true;
end
end
