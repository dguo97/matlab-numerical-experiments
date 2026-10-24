function maxStreaks = longest_streak_simulation(N, M)
%LONGEST_STREAK_SIMULATION Longest run of equal outcomes in N fair coin tosses.
%   maxStreaks = LONGEST_STREAK_SIMULATION(N, M) repeats the experiment M times
%   (defaults N = 10000, M = 5000), returns the longest streak of each
%   experiment, plots the histogram, and compares the empirical tail
%   P[longest streak >= k] with the union bound N / 2^(k-1) (capped at 1).
%   Example:  m = longest_streak_simulation(10000, 2000);

if nargin < 1, N = 10000; end
if nargin < 2, M = 5000; end

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
