function conic_plot(a, b, c, d, e)
%CONIC_PLOT Plot the conic  a x^2 + b xy + c y^2 + d x + e y + 1 = 0.
%   Defaults give the ellipse x^2 + 2y^2 = 1 (a = -1, c = -2, others 0).
%   Note that the constant term is fixed at +1, so for example a = 1 with all
%   other coefficients 0 has no real points.
%   Example:  conic_plot(-1, 0, -2, 0, 0)   % the ellipse x^2 + 2y^2 = 1

if nargin == 0
    a = -1; b = 0; c = -2; d = 0; e = 0;
elseif nargin ~= 5
    error('conic_plot:invalidInput', 'Give either no arguments or all five coefficients a, b, c, d, e.');
end

fimplicit(@(x, y) a*x.^2 + b*x.*y + c*y.^2 + d*x + e*y + 1, [-5 5 -5 5]);
axis equal; grid on
xlabel('x'); ylabel('y');
title(sprintf('%g x^2 + %g xy + %g y^2 + %g x + %g y + 1 = 0', a, b, c, d, e));
end
