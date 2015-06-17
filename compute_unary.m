function D_min = compute_unary(X, gmm)
%Compute Unary Term as paper formula (9)
%
% Inputs:
%   - X: reshaped image [N, D]
%   - gmm: Gaussian Mixture Model
%
% Outputs:
%   - D_min: output D
%
% TODO: use D_min or D_sum?

[N, D] = size(X);
K = numel(gmm.Weights);    % number of gaussian components
Ds = zeros(N, K);
try
for k = 1:K
    Pi = gmm.Weights(k);
    Mu = gmm.Mu(k, :);
    Sigma = gmm.Sigma(:, :, k);
    
    Ds(:, k) = -log(mvnpdf(X, Mu, Sigma))-log(Pi)-1.5*log(2*pi); 
end
catch
    fprintf('Error')
end

% D_min = min(Ds, [], 2)';
D_min = sum(Ds, 2)';

