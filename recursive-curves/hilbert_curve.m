function pts = hilbert_curve(pl, pr, level)
%HILBERT_CURVE Recursive Hilbert-type curve.
%   HILBERT_CURVE(PL, PR, LEVEL) draws the curve built on the base segment from
%   PL to PR (column vectors). At level 0 each base segment is replaced by a
%   two-sided "roof" through the point above its midpoint; each higher level
%   replaces a roof by four smaller ones on the left side, middle and right side.
%   pts = HILBERT_CURVE(...) also returns the vertices (segments separated by NaN).
%   Example:  hilbert_curve([0;0], [1;0], 5)

pts = hilbert_points(pl(:), pr(:), level);
if nargout == 0
    plot(pts(1,:), pts(2,:), 'b');
    axis equal
    clear pts
end
end

function pts = hilbert_points(pl, pr, level)
A = 0.5 * [0 -1; 1 0];                  % anticlockwise rotation, scaled by 1/2
d = A * (pr - pl);
if level == 0
    pts = [pl, (pl + pr)/2 + d, pr, [NaN; NaN]];
else
    pltop = pl + d;
    pmtop = (pl + pr)/2 + d;
    prtop = pr + d;
    pts = [hilbert_points(pltop, pl,    level-1), ...
           hilbert_points(pltop, pmtop, level-1), ...
           hilbert_points(pmtop, prtop, level-1), ...
           hilbert_points(pr,    prtop, level-1)];
end
end
