function surface_plot
%SURFACE_PLOT Surface z = (x^2 - y^2)/(x^2 + y^2) on [-2,2]^2.
%   The function is undefined at the origin (the grid avoids that point).
%   Example:  surface_plot

[X, Y] = meshgrid(-2:0.03:2, -2:0.03:2);
Z = (X.^2 - Y.^2) ./ (X.^2 + Y.^2);
surf(X, Y, Z, 'EdgeColor', 'none');
xlabel('x'); ylabel('y'); zlabel('z');
end
