function beta = compute_beta(im_sub)
[im_h, im_w, ~] = size(im_sub);

beta = 0;
cnt = 0;
for h = 1:im_h
    for w = 1:im_w
        % Current node
        p = im_sub(h, w, :);
        
        % Right neighbor
        if w < im_w     % Has a right neighbor
            diff = p - im_sub(h, w+1, :);
            beta = beta + sum(diff.^2);
            cnt = cnt + 1;
        end
        
        % Down neighbor
        if h < im_h     % Has a down neighbor
            diff = p - im_sub(h+1, w, :);
            beta = beta + sum(diff.^2);
            cnt = cnt + 1;
        end
    end
end

beta = 1/(2*(beta/cnt));
