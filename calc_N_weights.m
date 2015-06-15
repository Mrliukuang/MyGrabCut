function [leftW, upleftW, upW, uprightW] = calc_N_weights(im, gamma, beta)
%% N-link weights:
%    N(m, n) = 50/dist(m, n) * exp(-beta||Zm-Zn||^2)
%    Zm is color of pixel m

[H, W, ~] = size(im);

%% gamma_div_sqrt2 = gamma / dist(m, n)
%    dist(m, n) = 1 if m, n in stright line.
%    dist(m, n) = 2 if m, n in diagonal line.
gammaDivSqrt2 = gamma / sqrt(2);

%% 4 weights each for one direction
leftW = zeros(H, W);
upleftW = zeros(H, W);
upW = zeros(H, W);
uprightW = zeros(H, W);

for w = 1:W
    for h = 1:H
        p = im(h, w, :);
        if w > 1    % left
            diff = p - im(h, w-1, :);
            leftW(h, w) = gamma * exp(-beta*sum(diff.^2));
        end
        
        if w > 1 && h > 1   % upleft
            diff = p - im(h-1, w-1, :);
            upleftW(h, w) = gammaDivSqrt2 * exp(-beta*sum(diff.^2));
        end
        
        if h > 1    % up
            diff = p - im(h-1, w, :);
            upW(h, w) = gamma * exp(-beta*sum(diff.^2));
        end
        
        if h > 1 && w < W-1 % upright
            diff = p - im(h-1, w+1, :);
            uprightW(h, w) = gammaDivSqrt2 * exp(-beta*sum(diff.^2));
        end
    end
end

