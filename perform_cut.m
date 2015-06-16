function [ind_f, E] = perform_cut(ind_f, im_sub, alpha, gmm_f, gmm_b, pairwise)
%% Perform segmentation using min-cut
% Inputs:
%   - ind_f: logical indices for foreground
%   - im_sub: user selected foreground where min-cut is performed
%   - alpha: initial foreground labels, 0 for background, 1 for foreground
%   - gmm_f, gmm_b: fore/background GMMs
%   - pairwise: pairwise edge weight term computed ahead
%
%  Outputs:
%   - ind_f: indices of foreground after min-cut
%   - E: energy after min-cut

% Get image dimension
[im_h, im_w, ~] = size(im_sub);

% Number of pixels
n_nodes = im_h * im_w;

% Unary term of each node
unary = zeros(2, n_nodes);

fprintf('Computing unary terms...\n');
for h = 1:im_h
    for w = 1:im_w
        
        
        
    end
end










