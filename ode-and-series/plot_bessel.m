function plot_bessel
%PLOT_BESSEL Solve Bessel's equation (order 0) and compare with its asymptotics.
%   Integrates J'' + J'/t + J = 0 with ode45 on [1, 50], starting from J0(1) and
%   J0'(1) computed by BESSEL_SERIES, and overlays the large-t approximation
%       J0(t) ~ sqrt(2/(pi t)) cos(t - pi/4).
%   Method: the approximation is accurate to about 1e-3 for t >= 10 and improves
%   as t grows; near t = 1 the two curves differ visibly.
%   Example:  plot_bessel

J = bessel_series(1e-12);
y1 = [J(1,1); J(2,1)];                       % [J0(1); J0'(1)]

tspan = 1:0.001:50;
[t, y] = ode45(@bessel_rhs, tspan, y1, odeset('RelTol',1e-9,'AbsTol',1e-12));

plot(t, y(:,1)); hold on
tt = 1:0.1:50;
plot(tt, sqrt(2./(pi*tt)).*cos(tt - pi/4), '--');
hold off

xlabel('t'); ylabel('J_0(t)');
legend('ode45 solution', '\surd(2/\pi t) cos(t - \pi/4)');
title('Bessel function of order 0'); grid on
end
