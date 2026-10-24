function T = card_collecting(N, M)
%CARD_COLLECTING Number of draws needed to collect all N distinct cards.
%   T = CARD_COLLECTING(N, M) simulates M runs (defaults N = 1000, M = 5000).
%   Each run is sampled exactly as a sum of independent geometric waiting
%   times (stage i, with N-i+1 cards still missing, succeeds with probability
%   (N-i+1)/N), which has the same distribution as drawing cards one at a time.
%   Plots the histogram of T and compares P[T > N log N + cN] with e^(-c).
%   Example:  T = card_collecting(1000, 2000);

if nargin < 1, N = 1000; end
if nargin < 2, M = 5000; end

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
