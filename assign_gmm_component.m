function comp_idx = assign_gmm_component(im, mask, gmm_f, gmm_b, MASK)

[H, W, ~] = size(im);
comp_idx = zeros(H, W);

mask_b = (mask == MASK.BGD | mask == MASK.PR_BGD);
mask_f = (mask == MASK.FGD | mask == MASK.PR_FGD);

im_reshaped = reshape(im, H*W, []);
comp_idx(mask_b) = predict(im_reshaped(mask_b, :), gmm_b);
comp_idx(mask_f) = predict(im_reshaped(mask_f, :), gmm_f);

