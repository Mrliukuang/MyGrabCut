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

% reshape im_sub to 1D
im_reshaped = reshape(im_sub, n_nodes, []);

% Unary term of each node
unary = zeros(2, n_nodes);

fprintf('Computing unary terms...\n');
unary(1, :) = compute_unary(im_reshaped, gmm_f);
unary(2, :) = compute_unary(im_reshaped, gmm_b);

% for h = 1:im_h
%     fprintf('%d/%d\n', h, im_h);
%     for w = 1:im_w
%         p = im_sub(h, w, :);    % current point
%         p = p(:)';  % reshape point to one row
%         ind = (w-1)*im_h + h;   % current point index
%         
%         % Compute unary term
%         % 1 for fackground
%         % 2 for boreground
%         unary(1, ind) = compute_unary(p, gmm_f);
%         unary(2, ind) = compute_unary(p, gmm_b);
%     end
% end

%% Perform min-cut using Bk_matlab
handle = BK_Create(n_nodes);
% set unary term
BK_SetUnary(handle, unary);
% set pairwise term
BK_SetPairwise(handle, pairwise);
% perform min-cut
E = BK_Minimize(handle);
% get new labels
labels = BK_GetLabeling(handle);
% clear memory
BK_Delete(handle);

% Replace initial alpha with GraphCut labels
alpha(alpha == 1) = labels;
% Remove background pixels from ind_f 
ind_f(alpha == 2) = 0;























