function pts = koch(pl, pr, level)
%KOCH Koch curve between the column vectors PL and PR.
%   KOCH(PL, PR, LEVEL) plots the curve after LEVEL levels of recursion.
%   pts = KOCH(...) also returns the 2 x n matrix of vertices.
%   Example:  koch([0;0], [1;0], 4); axis equal

pts = koch_points(pl(:), pr(:), level);
if nargout == 0
    plot(pts(1,:), pts(2,:), 'b');
    axis equal
    clear pts
end
end

function pts = koch_points(pl, pr, level)
if level == 0
    pts = [pl, pr];
    return
end
A = (sqrt(3)/6) * [0 1; -1 0];         % rotate/scale: peak height is sqrt(3)/6 of the length
pmidl = (2*pl + pr)/3;
pmidr = (pl + 2*pr)/3;
ptop  = (pl + pr)/2 + A*(pl - pr);

left  = koch_points(pl,    pmidl, level-1);
lmid  = koch_points(pmidl, ptop,  level-1);
rmid  = koch_points(ptop,  pmidr, level-1);
right = koch_points(pmidr, pr,    level-1);
pts = [left, lmid(:,2:end), rmid(:,2:end), right(:,2:end)];   % drop duplicated joins
end
