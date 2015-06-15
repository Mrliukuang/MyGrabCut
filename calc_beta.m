function beta = calc_beta(im)
%% Calculate beta - parameter of GrabCut algorithm. 
%    beta = 1/(2*avg(sqr(||color[i] - color[j]||))) 

[H, W, ~] = size(im);

beta = 0;
for w = 1:W
    for h = 1:H
        p = im(h, w, :);
        if w > 1    % left
            diff = p - im(h, w-1, :);
            beta = beta + sum(diff.^2);
        end
        
        if w > 1 && h > 1   % upleft
            diff = p - im(h-1, w-1, :);
            beta = beta + sum(diff.^2);
        end
        
        if h > 1    % up
            diff = p - im(h-1, w, :);
            beta = beta + sum(diff.^2);
        end
        
        if h > 1 && w < W-1 % upright
            diff = p - im(h-1, w+1, :);
            beta = beta + sum(diff.^2);
        end
    end
end

beta = 1.0 / (2 * beta/(4*H*W - 3*H - 3*W + 2));
