function plot_bessel
%PLOT_BESSEL Solve Bessel's equation (order 0) with ode45 and compare with an
%   empirical decay envelope  C t^(-b) cos(t + theta).
%   Initial values J0(1) and J0'(1) come from BESSEL_SERIES.
%   Example:  plot_bessel

J = bessel_series(1e-12);
y1 = [J(1,1); J(2,1)];                       % [J(1); J'(1)]

tspan = 1:0.001:50;
[t, y] = ode45(@bessel_rhs, tspan, y1, odeset('RelTol',1e-9,'AbsTol',1e-12));

plot(t, y(:,1)); hold on

% Empirical fit read from the numerical solution: local maxima occur at
% t = 0.745472 + 2*n*pi, giving the phase; C and b were fitted from the
% value at t = 1 and from the extrema near t = 45-48.
theta = -0.745472;
C = 0.7656;
b = 0.4898;
tt = 1:0.1:50;
plot(tt, C*tt.^(-b).*cos(tt + theta));

xlabel('t'); ylabel('J_0(t)');
legend('ode45 solution', 'C t^{-b} cos(t + \theta)');
title('Bessel function of order 0'); grid on
hold off
end
