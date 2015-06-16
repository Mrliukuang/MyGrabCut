function model = fit_gmm(X, K)
%% Fit Guassian Mixture Model with kmeans initilization
% Inputs:
%   - X: input data of size [N, D]
%   - K: number of Guassian components
%
% Ouputs:
%   - model: Guassian Mixture model containing:
%      - Pi: component weights [1 x K]
%      - Mu: component mean [K x D]
%      - Sigma: componet covariance [D x D x K]
%
% Notice: 
%   We are not actually performing EM algorithm, we just kmeans and
%   calculate GMM parameters. It's enough for this step, cause we are
%   refining these parameters later.


%% Get X dimension
[N, D] = size(X);

%% k-means initilization
fprintf('Performing kmeans 1 replicates...\n');
X_ind = kmeans(X, K, 'Distance', 'cityblock', 'Replicates', 1, 'Display', 'final');

%% Init model
model.Weights = zeros(1, K);
model.Mu = zeros(K, D);
model.Sigma = zeros(D, D, K);

for k = 1:K
    Xk = X(X_ind == k, :);
    model.Weights(k) = size(Xk, 1) / N;
    model.Mu(k, :) = mean(Xk);
    model.Sigma(:, :, k) = cov(Xk);
end