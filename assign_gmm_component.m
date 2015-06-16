function [comp_ind_f, comp_ind_b] = assign_gmm_component(im_1d, gmm_f, gmm_b, ind_f, ind_b)
%% Assign fore/background pixels to the most probable component
%
% Inputs:
%   - im_1d: image shaped [N, 3]
%   - gmm_f, gmm_b: fore/background GMM
%   - ind_f, ind_b: fore/background pixel index(mask)
%
% Outpus:
%   - comp_ind_f, comp_ind_b: learned component index


im_f = im_1d(ind_f, :);
comp_ind_f = predict(im_f, gmm_f);

im_b = im_1d(ind_b, :);
comp_ind_b = predict(im_b, gmm_b);

