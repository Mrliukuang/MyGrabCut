% Grabcut for image segmentation.

clc; clear; close all;
addpath('.\gmm\');

im = imread('banana1.bmp');
imagesc(im)

[H, W, C] = size(im);

[xmin, ymin, xmax, ymax] = get_bbox(im);
HH = ymax - ymin + 1;
WW = xmax - xmin + 1;

im_f = im(ymin:ymax, xmin:xmax, :);
% [HH, WW, ~] = size(im_f);

num_f = HH * WW;        % foreground pixel num
num_b = H * W - num_f;  % background pixel num


%% Some global variables
% mask
BGD = 0;    % background
FGD = 1;    % foreground
PR_BGD = 2; % probable background
PR_FGD = 3; % prabable foreground

%% Data Structures needed
% 1. Color: X
im = double(im) / 255;
% 2. Mask: in [BGD, FGD, PR_BGD, PR_FGD]
mask = zeros(H, W);
% 3. Matte: opacity: background = 0; foreground = 1
alpha = zeros(H, W);
% 4. Gaussian Component Index: number between 1~K
comp_idx = zeros(H, W);


%% Collect foreground/background pixels into X_f/X_b
% TODO: double for-loop is stupid, use reshape and matrix deletion
% e.g. vector deletion: a(3:5)=[]
X_f = zeros(num_f, 3);
X_b = zeros(num_b, 3);
idx_f = zeros(num_f, 1);
idx_b = zeros(num_b, 1);
f_ctr = 1;                  % foreground counter
b_ctr = 1;                  % background counter
for w = 1 : W
    for h = 1 : H
        if (w >= xmin) && (w <= xmax) && (h >= ymin) && (h <= ymax)
            % this pixel belongs to the initial foreground
            mask(h, w) = PR_FGD;   % prabable foreground
            alpha(h, w) = 1;       % foreground alpha = 1
            idx_f(f_ctr) = h + (w-1)*H;
            X_f(f_ctr, :) = im(h, w, :);
            f_ctr = f_ctr+1;
        else
            % this pixel belongs to the initial background
            mask(h, w) = BGD;   % background
            idx_b(b_ctr) = h + (w-1)*H;
            X_b(b_ctr, :) = im(h, w, :);
            b_ctr = b_ctr+1;
        end
    end
end


%% Initialize GMM for foreground/background
K = 5;
% opts.Display = 'iter';
% g = fitgmdist(X_b, K, 'Options', opts);
gmm_f = gmm(X_f, K);
gmm_b = gmm(X_b, K);



while true
    %% Assign component to each pixel from bg/fg
    cluster_f = predict(X_f, gmm_f);
    cluster_b = predict(X_b, gmm_b);
    % update component index
    comp_idx(idx_f) = cluster_f;
    comp_idx(idx_b) = cluster_b;
    
    %% Update GMM
    
    
    
end






