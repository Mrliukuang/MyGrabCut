function pairwise = compute_pairwise(im_sub, gamma)
%% Compute pairwise energy as followings
%   N(m, n) = gamma / dist(m, n) * exp(-beta*||Zm-Zn||^2)
%   Zm is the color of pixel m
%
% Inputs:
%   - im_sub: 2D image [H, W, C]
%   - gamma: parameter fixed to 50
%
% Outputs:
%   - pairwise: [n_edges x 6] matrix, each row of the format: 
%       [i, j, e00, e01, e10, e11] where i and j are neighbours and the four
%       coefficients define the interaction potential

% Get image dimensions
[im_h, im_w, ~] = size(im_sub);

% Compute beta
beta = compute_beta(im_sub);

% Set pairwise
pairwise = zeros((im_h-1)*(im_w-1)*2+(im_h-1)+(im_w-1), 6);

idx = 1;
for h = im_h
    for w = im_w
        
        
        
    end
end













