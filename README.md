# MATLAB Numerical Experiments

A small collection of MATLAB scripts and functions covering numerical methods,
Monte Carlo simulation, plotting and recursive geometry.

These are examples of MATLAB projects I completed as an undergraduate at the University of Warwick.

Written for MATLAB R2016b or newer (`fimplicit`, `fimplicit3`, `histogram`,
local functions). No toolboxes are required.

## Quick start

```matlab
demo                       % runs every example and shows all plots
run('tests/run_tests.m')   % runs the regression tests
help count_lattice_points  % every function has built-in help with an example
```

## What each folder does

### `ode-and-series/`
Models a quantity governed by a first-order linear ODE with a sinusoidal forcing term.
`estimate_decay_rate` finds the decay rate *k* by fixed-point iteration,
`find_constant_E` fixes the integration constant so the solution hits a target value at a given time,
and `plot_solution` shows the resulting curve on [5, 6].
The same folder studies Bessel's equation of order zero, J'' + J'/t + J = 0:
`bessel_series` sums the power series for J0(1) and J0'(1), and
`plot_bessel` solves the ODE with `ode45` and compares it with the large-t asymptotic form √(2/(πt))·cos(t − π/4).

### `random-simulations/`
Two Monte Carlo experiments, each compared with a theoretical bound.
`longest_streak_simulation` records the longest run of equal outcomes in N fair coin tosses
and plots the empirical P[streak ≥ k] against the union bound N / 2^(k−1).
`card_collecting` simulates the coupon-collector problem (draws needed to see all N cards)
and plots P[T > N log N + cN] against the bound e^(−c).
Both take an optional seed, e.g. `card_collecting(1000, 2000, 1)`, for reproducible results.

### `implicit-plots-and-conics/`
`implicit_surface` draws the level set of a sum of sines in three variables with `fimplicit3`,
and `surface_plot` draws z = (x² − y²)/(x² + y²).
`conic_plot` plots any conic a·x² + b·xy + c·y² + d·x + e·y + 1 = 0.
`conic_fit` fits a conic to ten data points by least squares, then overlays the contours and the fitted curve.

### `root-finding-and-lattice-points/`
`bisection_root` and `newton_root` locate the smallest positive root of 2x·cos x − sin x
(about 1.16556), and `plot_root_function` shows where it lies.
`count_lattice_points` counts integer points inside a circle of radius R (the Gauss circle problem), and
`lattice_point_error` plots the count against the area πR² and the error |N(R) − πR²|
alongside a guide curve C·R^a.

### `recursive-curves/`
`koch` generates the Koch curve by replacing each segment with four smaller ones,
and `hilbert_curve` builds a Hilbert-type curve by recursive subdivision.
`has_equal_line_sums` checks whether every row, column and both diagonals of a matrix have the same sum.

## How it works

Every function's help text (`help functionName`) includes a short **Method** note.
In brief:

- `card_collecting` sums geometric waiting times instead of drawing cards one at a time, which gives the same distribution much faster.
- `count_lattice_points` counts one quadrant exactly and uses symmetry for the rest.
- `lattice_point_error`'s guide curve C·R^a is an empirical comparison, not a proven bound.
- `bisection_root` converges linearly (about 35 steps), `newton_root` quadratically (a handful of steps).
- `koch` and `hilbert_curve` build all vertices recursively and plot once.

## Tests

`tests/run_tests.m` checks known values (for example `count_lattice_points(2)` is 13,
both root finders return about 1.16556, `has_equal_line_sums(magic(4))` is true),
output sizes for the curves, loose statistical ranges for the simulations, and that invalid input
(negative radii or levels, wrong argument counts, an interval with no sign change) raises a clear error.
It ends with `All tests passed.` if everything is correct.
A GitHub Actions workflow (`.github/workflows/tests.yml`) runs the same tests on every push.

## Licence

MIT. See `LICENSE`.
