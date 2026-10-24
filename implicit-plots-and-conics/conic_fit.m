function v = conic_fit
%CONIC_FIT Least-squares conic through measured points.
%   Fits  a x^2 + b xy + c y^2 + d x + e y + 1 = 0  to ten data points,
%   solving the overdetermined system A v = -1 in the least-squares sense.
%   Plots the data's contour map and the fitted conic. Returns v = [a b c d e]'.
%   Example:  v = conic_fit;

X = [1.03 0.95 0.87 0.77 0.67 0.56 0.43 0.30 0.16 0.01];
Y = [0.39 0.32 0.27 0.22 0.18 0.15 0.13 0.12 0.13 0.15];

A = [X.^2; X.*Y; Y.^2; X; Y]';
rhs = -ones(numel(X), 1);
v = A \ rhs;                                 % least squares (QR), better than normal equations

[a, b, c, d, e] = deal(v(1), v(2), v(3), v(4), v(5));
f = @(x, y) a*x.^2 + b*x.*y + c*y.^2 + d*x + e*y + 1;

figure
[gx, gy] = meshgrid(-5:0.01:5, -5:0.01:5);
contour(gx, gy, f(gx, gy), 'ShowText', 'on');
hold on
fimplicit(f, 'r', 'LineWidth', 3);
plot(X, Y, 'ko', 'MarkerFaceColor', 'k');
hold off
axis equal; xlabel('x'); ylabel('y');
title('Least-squares conic fit');
end
