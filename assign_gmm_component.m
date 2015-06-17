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


% im_f = im_1d(ind_f, :);
% comp_ind_f = assign_each_gmm(im_f, gmm_f);
% 
% im_b = im_1d(ind_b, :);
% comp_ind_b = assign_each_gmm(im_b, gmm_b);
% 
% 
% 
% function comp_ind = assign_each_gmm(im, gmm)
% pix_D = zeros(size(im, 1), 5);
% for k = 1:5
%     pi_coeff = gmm.Weights(k);
%     mu = gmm.Mu(k, :);
%     sigma = gmm.Sigma(:, :, k);
%     
%     pix_D(:, k) = -log(mvnpdf(im, mu, sigma))-log(pi_coeff)-1.5*log(2*pi);
% end
% 
% [~, comp_ind] = min(pix_D, [], 2);