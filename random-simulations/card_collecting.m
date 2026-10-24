function T = card_collecting(N, M, seed)
%CARD_COLLECTING Number of draws needed to collect all N distinct cards.
%   T = CARD_COLLECTING(N, M) simulates M runs (defaults N = 1000, M = 5000).
%   Plots the histogram of T and compares P[T > N log N + cN] with e^(-c).
%   Optional SEED makes the run reproducible (it calls rng(SEED), which sets the
%   global random generator).
%   Method: with k cards still missing, the wait for a new one is geometric with
%   success probability k/N, and the total is the sum over k = N..1. A geometric
%   variable is sampled as floor(log(U)/log(1-p)) + 1 with U uniform, which is
%   far faster than drawing cards one at a time. The bound e^(-c) comes from a
%   union bound over the N cards: each is still missing after N log N + cN draws
%   with probability at most e^(-(log N + c)).
%   Example:  T = card_collecting(1000, 2000, 1);

if nargin < 1, N = 1000; end
if nargin < 2, M = 5000; end
if nargin >= 3 && ~isempty(seed), rng(seed); end
if ~(isscalar(N) && N >= 1 && N == floor(N)) || ~(isscalar(M) && M >= 1 && M == floor(M))
    error('card_collecting:invalidInput', 'N and M must be positive integers.');
end

p = (N:-1:1)' / N;                               % success probability per stage
T = sum(floor(log(rand(N, M)) ./ log(1 - p)) + 1, 1);   % 1 x M

figure
histogram(T, 60);
title('Card collecting');
xlabel('Number of draws'); ylabel('Number of occurrences');

figure
c = 1:20;
bound = exp(-c);
empirical = arrayfun(@(x) mean(T > N*log(N) + x*N), c);
plot(c, bound, c, empirical);
title('Accuracy of the upper bound');
xlabel('c'); ylabel('P[T > N log N + cN]');
legend('upper bound e^{-c}', 'simulation');
end
