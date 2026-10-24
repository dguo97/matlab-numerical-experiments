function maxStreaks = longest_streak_simulation(N, M, seed)
%LONGEST_STREAK_SIMULATION Longest run of equal outcomes in N fair coin tosses.
%   maxStreaks = LONGEST_STREAK_SIMULATION(N, M) repeats the experiment M times
%   (defaults N = 10000, M = 5000), returns the longest streak of each
%   experiment, plots the histogram, and compares the empirical tail
%   P[longest streak >= k] with the union bound N / 2^(k-1) (capped at 1).
%   Optional SEED makes the run reproducible (it calls rng(SEED), which sets the
%   global random generator).
%   Method: each experiment draws N tosses, finds where the outcome changes with
%   diff, and takes the largest gap between changes as the longest streak. The
%   union bound holds because a streak of length k can start in at most N places
%   and each has probability 2^(-(k-1)).
%   Example:  m = longest_streak_simulation(10000, 2000, 1);

if nargin < 1, N = 10000; end
if nargin < 2, M = 5000; end
if nargin >= 3 && ~isempty(seed), rng(seed); end
if ~(isscalar(N) && N >= 1 && N == floor(N)) || ~(isscalar(M) && M >= 1 && M == floor(M))
    error('longest_streak_simulation:invalidInput', 'N and M must be positive integers.');
end

maxStreaks = zeros(M, 1);
for j = 1:M
    tosses = rand(N, 1) < 0.5;
    changes = [0; find(diff(tosses) ~= 0); N];   % indices where a streak ends
    maxStreaks(j) = max(diff(changes));
end

figure
histogram(maxStreaks, 'BinMethod', 'integers');
title('Longest streak');
xlabel('Streak length'); ylabel('Number of occurrences');

figure
m = max(maxStreaks);
k = 1:m;
bound = min(N * 0.5.^(k - 1), 1);
empirical = arrayfun(@(i) mean(maxStreaks >= i), k);
plot(k, bound, k, empirical);
axis([1, m, 0, 1]);
title('Accuracy of the union bound');
xlabel('k (streak length)'); ylabel('P[longest streak \geq k]');
legend('upper bound N/2^{k-1}', 'simulation');
end
