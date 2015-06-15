function [gmm_f, gmm_b] = init_gmms(im, rect, mask, MASK)
%% init GMM foreground/background GMM from in/out rect respectively.

[H, W, ~] = size(im);
% count number of pixels for fg/bg
num_f = rect.height * rect.width;
num_b = H * W - num_f;

% collect fg/bg pixels
X_f = zeros(num_f, 3);
X_b = zeros(num_b, 3);
i_f = 1;    % counter for loops
i_b = 1;
for w = 1:W
    for h = 1:H
        if mask(h, w) == MASK.BGD || mask(h, w) == MASK.PR_BGD
            X_b(i_b, :) = im(h, w, :);
            i_b = i_b + 1;
        else
            X_f(i_f, :) = im(h, w, :);
            i_f = i_f + 1;
        end
    end
end

% learn GMM for each X_f/X_b
K = 5;
gmm_f = gmm(X_f, K);
gmm_b = gmm(X_b, K);