function pairwise = compute_pairwise(im_sub, gamma)
%COMOUTE_PAIRWISE Part of GrabCut. Compute the pairwise terms.
%
% Inputs:
%   - im_sub: 2D subimage, on which Graph Cut is performed
%   - gamma: gamma parameter
%
% Output:
%   - pairwise: a dense no_edgesx6 matrix of doubles. Each row is of the
%format [i, j, e00, e01, e10, e11] where i and j are neighbours and the four
%coefficients define the interaction potential
%
% Author:
%   Xiuming Zhang
%   xiuming6zhang[on]gmail.com
%   Dept. of ECE, National University of Singapore
%   April 2015
%

% Get image dimensions
[im_h, im_w, ~] = size(im_sub);

%------- Compute \beta

beta = compute_beta(im_sub);

%------- Set pairwise

pairwise = zeros((im_h-1)*(im_w-1)*2+(im_h-1)+(im_w-1), 6);

% Loop through all the pixels (nodes) and set pairwise
idx = 1;
for y = 1:im_h
    for x = 1:im_w
        % Current node
        node = (x-1)*im_h+y;
        color = get_rgb_double(im_sub, x, y);
        
        % Right neighbor
        if x < im_w % Has a right neighbor
            node_r = (x+1-1)*im_h+y;
            color_r = get_rgb_double(im_sub, x+1, y);
            pairwise(idx, 1) = node;
            pairwise(idx, 2) = node_r;
            pairwise(idx, 3) = compute_V(color, 0, color_r, 0, gamma, beta);
            pairwise(idx, 4) = compute_V(color, 0, color_r, 1, gamma, beta);
            pairwise(idx, 5) = compute_V(color, 1, color_r, 0, gamma, beta);
            pairwise(idx, 6) = compute_V(color, 1, color_r, 1, gamma, beta);
            idx = idx+1;
        end
        
        % Down neighbor
        if y < im_h % Has a down neighbor
            node_d = (x-1)*im_h+y+1;
            color_d = get_rgb_double(im_sub, x, y+1);
            pairwise(idx, 1) = node;
            pairwise(idx, 2) = node_d;
            pairwise(idx, 3) = compute_V(color, 0, color_d, 0, gamma, beta);
            pairwise(idx, 4) = compute_V(color, 0, color_d, 1, gamma, beta);
            pairwise(idx, 5) = compute_V(color, 1, color_d, 0, gamma, beta);
            pairwise(idx, 6) = compute_V(color, 1, color_d, 1, gamma, beta);
            idx = idx+1;
        end
    end
end

end


function beta = compute_beta(im_sub)

% Get image dimensions
[im_h, im_w, ~] = size(im_sub);

beta_sum = 0;
cnt = 0;

for y = 1:im_h
    for x = 1:im_w
        % Current node
        color = get_rgb_double(im_sub, x, y);
        
        % Right neighbor
        if x < im_w % Has a right neighbor
            color_r = get_rgb_double(im_sub, x+1, y);
            beta_sum = beta_sum+norm(color-color_r)^2;
            cnt = cnt+1;
        end
        % Down neighbor
        if y < im_h % Has a down neighbor
            color_d = get_rgb_double(im_sub, x, y+1);
            beta_sum = beta_sum+norm(color-color_d)^2;
            cnt = cnt+1;
        end
    end
end

beta = 1/(2*(beta_sum/cnt));

end


function V = compute_V(color1, label1, color2, label2, gamma, beta)

V = gamma*double(label1~=label2)*exp(-beta*(norm(color1-color2)^2));

end










% function pairwise = compute_pairwise(im_sub, gamma)
% %% Compute pairwise energy as followings
% %   N(m, n) = gamma / dist(m, n) * exp(-beta*||Zm-Zn||^2)
% %   Zm is the color of pixel m
% %
% % Inputs:
% %   - im_sub: 2D image [H, W, C]
% %   - gamma: parameter fixed to 50
% %
% % Outputs:
% %   - pairwise: [n_edges x 6] matrix, each row of the format: 
% %       [i, j, e00, e01, e10, e11] where i and j are neighbours and the four
% %       coefficients define the interaction potential
% 
% % Get image dimensions
% [im_h, im_w, ~] = size(im_sub);
% 
% % Compute beta
% beta = compute_beta(im_sub);
% 
% % Set pairwise
% pairwise = zeros((im_h-1)*(im_w-1)*2+(im_h-1)+(im_w-1), 6);
% 
% idx = 1;
% % Function define: compute_weight()
% % Compute pairwise weight given label a and color diff
% % compute_weight = @(a1, a2, diff)(gamma * (a1 ~= a2) * exp(-beta*(sum(diff.^2))));
% for h = 1:im_h
%     for w = 1:im_w
%         p_idx = (w-1)*im_h + h; % current point index
%         p = im_sub(h, w, :);    % current point color
%         
%         % right neightbor
%         if w < im_w
%             pr_idx = p_idx + im_h;  % right point index
%             diff = p - im_sub(h, w+1, :);   % color diff
%             pairwise(idx, 1) = p_idx;
%             pairwise(idx, 2) = pr_idx;
%             pairwise(idx, 3) = 0;   % compute_weight(0, 0, diff);
%             tmp = gamma * exp(-beta*(sum(diff.^2)));
%             pairwise(idx, 4) = tmp; % compute_weight(0, 1, diff);
%             pairwise(idx, 5) = tmp; % compute_weight(1, 0, diff);
%             pairwise(idx, 6) = 0;   % compute_weight(1, 1, diff);
%             idx = idx + 1;
%         end
%         
%         % down neightbor
%         if h < im_h
%             pd_idx = p_idx + 1;     % down point index
%             diff = p - im_sub(h+1, w, :);   % color diff
%             pairwise(idx, 1) = p_idx;
%             pairwise(idx, 2) = pd_idx;
%             pairwise(idx, 3) = 0;
%             tmp = gamma * exp(-beta*(sum(diff.^2)));
%             pairwise(idx, 4) = tmp;
%             pairwise(idx, 5) = tmp;
%             pairwise(idx, 6) = 0;
%             idx = idx + 1;
%         end 
%     end
% end













