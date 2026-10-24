function tf = has_equal_line_sums(A)
%HAS_EQUAL_LINE_SUMS True if all row, column and both diagonal sums of A agree.
%   This is the "magic sum" property only: entries need not be distinct, so the
%   test also accepts matrix powers of magic squares, e.g.
%       has_equal_line_sums(magic(3)^5)
%   Example:  has_equal_line_sums(magic(4))   % returns true

if size(A,1) ~= size(A,2)
    tf = false;
    return
end
sums = [sum(A,2).', sum(A,1), trace(A), trace(fliplr(A))];
tf = all(sums == sums(1));
end
