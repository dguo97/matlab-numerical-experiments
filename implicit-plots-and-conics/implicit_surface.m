function implicit_surface
%IMPLICIT_SURFACE Plot the level set f(x,y,z) = 0 for
%   f = sin(x+y) + sin(x-y) + sin(y+z) + sin(y-z) + sin(x+z) + sin(x-z).
%   Example:  implicit_surface

f = @(x, y, z) sin(x+y) + sin(x-y) + sin(y+z) + sin(y-z) + sin(x+z) + sin(x-z);
fimplicit3(f, [-5 5 -5 5 -5 5]);
xlabel('x'); ylabel('y'); zlabel('z');
title('Level set  f(x,y,z) = 0');
axis equal; grid on; view(3)
end
