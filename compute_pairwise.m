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
% Function define: compute_weight()
% Compute pairwise weight given label a and color diff
% compute_weight = @(a1, a2, diff)(gamma * (a1 ~= a2) * exp(-beta*(sum(diff.^2))));
for h = 1:im_h
    for w = 1:im_w
        p_idx = (w-1)*im_h + h; % current point index
        p = im_sub(h, w, :);    % current point color
        
        % right neightbor
        if w < im_w
            pr_idx = p_idx + im_h;  % right point index
            pr = im_sub(h, w+1, :); % right point color
            diff = p - pr;          % color diff
            pairwise(idx, 1) = p_idx;
            pairwise(idx, 2) = pr_idx;
            pairwise(idx, 3) = 0;   % compute_weight(0, 0, diff);
            tmp = gamma * exp(-beta*(sum(diff.^2)));
            pairwise(idx, 4) = tmp; % compute_weight(0, 1, diff);
            pairwise(idx, 5) = tmp; % compute_weight(1, 0, diff);
            pairwise(idx, 6) = 0;   % compute_weight(1, 1, diff);
            idx = idx + 1;
        end
        
        % down neightbor
        if h < im_h
            pd_idx = p_idx + 1;     % down point index
            pd = im_sub(h+1, w, :); % down point color
            diff = p - pd;          % color diff
            pairwise(idx, 1) = p_idx;
            pairwise(idx, 2) = pd_idx;
            pairwise(idx, 3) = 0;
            tmp = gamma * exp(-beta*(sum(diff.^2)));
            pairwise(idx, 4) = tmp;
            pairwise(idx, 5) = tmp;
            pairwise(idx, 6) = 0;
            idx = idx + 1;
        end 
    end
end













