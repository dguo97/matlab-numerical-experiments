function plot_root_function
%PLOT_ROOT_FUNCTION Plot f(x) = 2x cos x - sin x on [0, 2*pi] to locate roots.
%   Example:  plot_root_function

x = 0:0.01:2*pi;
y = 2*x.*cos(x) - sin(x);
plot(x, y, [0 2*pi], [0 0]);
title('Locating the smallest positive root');
xlabel('x'); ylabel('f(x)'); grid on
end
