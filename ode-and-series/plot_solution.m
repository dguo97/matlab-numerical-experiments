function plot_solution(E, k)
%PLOT_SOLUTION Plot y(t) on [5, 6] for the solution used in FIND_CONSTANT_E.
%   Defaults: E = 322.1, K = 0.3892.
%   Example:  plot_solution(322.1)

if nargin < 1, E = 322.1; end
if nargin < 2, k = 0.3892; end

w = pi/12;
t = linspace(5, 6, 1001);
y = 3 - 5*k*(w*sin(w*(t-2)) + k*cos(w*(t-2)))/(k^2 + w^2) + E*exp(-k*t);
plot(t, y);
xlabel('t'); ylabel('y(t)'); title('Solution on [5, 6]'); grid on
end
