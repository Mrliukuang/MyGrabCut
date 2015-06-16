function [gmm_f, gmm_b] = update_gmms(im_1d, comp_f, comp_b, ind_f, ind_b)
%% Learn new GMM parameters
% Inputs:
%   - im_1d: RGB image shaped [N, 3]
%   - comp_f, comp_b: GMM component index of each fore/background pixel
%   - ind_f, ind_b: logical indices for fore/backround
%
% Outputs:
%   - gmm_f, gmm_b: learned new GMMs

% update foreground
im_f = im_1d(ind_f, :);
gmm_f = update_each_gmm(im_f, comp_f);

% update background
im_b = im_1d(ind_b, :);
gmm_b = update_each_gmm(im_b, comp_b);


function model = update_each_gmm(X, comp_ind)
%% update each GMM

[N, D] = size(X);
K = 5;    % number of gaussian component
%% Pre-allocate memory
model.Weights = zeros(1, K);
model.Mu = zeros(K, D);
model.Sigma = zeros(D, D, K);
for k = 1:K
    Xk = X(comp_ind == k, :);
    model.Weights(k) = size(Xk, 1) / N;
    model.Mu(k, :) = mean(Xk);
    model.Sigma(:, :, k) = cov(Xk);
end






