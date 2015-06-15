function [gmm_f, gmm_b] = learn_gmms(im, mask, comp_idx, gmm_f, gmm_b, MASK)
%% Learn new GMM parameters
[H, W, ~] = size(im);

mask_b = (mask == MASK.BGD | mask == MASK.PR_BGD);
mask_f = (mask == MASK.FGD | mask == MASK.PR_FGD);

comp_b = comp_idx(mask_b);
comp_f = comp_idx(mask_f);

im_reshaped = reshape(im, H*W, []);
X_b = im_reshaped(mask_b, :);
X_f = im_reshaped(mask_f, :);

gmm_b = update_gmm(gmm_b, X_b, comp_b);
gmm_f = update_gmm(gmm_f, X_f, comp_f);


