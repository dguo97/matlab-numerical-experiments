function f = bessel_rhs(t, y)
%BESSEL_RHS First-order system for Bessel's equation of order zero.
%   J'' + J'/t + J = 0. With y(1) = J and y(2) = J':
%       y1' = y2,    y2' = -y1 - y2/t.
%   Example:  [t, y] = ode45(@bessel_rhs, [1 20], [0.7652; -0.4401]);

f = [y(2); -y(1) - y(2)/t];
end
