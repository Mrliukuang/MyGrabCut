function mask = init_mask_with_rect(im, rect, MASK)
%% init mask with given rect
%   mask(rect) = MASK.PR_FGD
%   mask(else) = MASK.BGD

[H, W, ~] = size(im);
mask = zeros(H, W);     % init with MASK.BGD = 0;
xmin = rect.xmin;
xmax = rect.xmax;
ymin = rect.ymin;
ymax = rect.ymax;

mask(ymin:ymax, xmin:xmax) = MASK.PR_FGD;


