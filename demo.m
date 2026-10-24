% DEMO  Run every example in this repository and show all the plots.
%   From the repository folder, in MATLAB, run:  demo
%   Each section opens its own figure(s); the console shows numerical results.

addpath(genpath(fileparts(mfilename('fullpath'))));
close all

%% 1. ODE and series
fprintf('Decay rate k            : %.6f\n', estimate_decay_rate);
fprintf('Constant E (y(7) = 21)  : %.2f\n', find_constant_E(21, 7));
J = bessel_series(1e-4);
fprintf('J0(1) = %.6f, J0''(1) = %.6f (power series)\n', J(1,1), J(2,1));
figure; plot_solution;
figure; plot_bessel;

%% 2. Random simulations
longest_streak_simulation(10000, 2000);   % opens 2 figures
card_collecting(1000, 2000);              % opens 2 figures

%% 3. Implicit plots and conics
figure; implicit_surface;
figure; surface_plot;
figure; conic_plot(-1, 0, -2, 0, 0);
v = conic_fit;                            % opens its own figure
fprintf('Fitted conic coefficients: %s\n', mat2str(v', 4));

%% 4. Root finding and lattice points
figure; plot_root_function;
fprintf('Bisection root : %.12f\n', bisection_root);
fprintf('Newton root    : %.12f\n', newton_root);
lattice_point_error(300);                 % opens 2 figures

%% 5. Recursive curves
figure; koch([0;0], [1;0], 4);
figure; hilbert_curve([0;0], [1;0], 5);
fprintf('magic(4) has equal line sums: %d\n', has_equal_line_sums(magic(4)));
