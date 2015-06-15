%% Parameters:
%    im:  image for segmentation
%    mask: in [BGD, FGD, PR_BGD, PR_FGD]
%    bgdmodel, fgdmodel: background/foreground GMM

% Reference:
%    http://blog.csdn.net/zouxy09/article/details/8535087


clc; clear; close all;
addpath('.\gmm\');

%% Some global variables
MASK.BGD = 0;    % background 
MASK.FGD = 1;    % foreground
MASK.PR_BGD = 2; % probable background
MASK.PR_FGD = 3; % probable foreground

%% load image
im = imread('banana1.bmp');
im = double(im) / 255;
imagesc(im)
rect = get_bbox(im);

%% init mask
mask = init_mask_with_rect(im, rect, MASK);

%% init GMMs
[gmm_f, gmm_b] = init_gmms(im, rect, mask, MASK);

%% grabcut
gamma = 50;
lambda = 9*gamma;
beta = calc_beta(im);

[leftW, upleftW, upW, uprightW] = calc_N_weights(im, gamma, beta);

max_iter = 1;
for i = 1:max_iter
    comp_idx = assign_gmm_component(im, mask, gmm_f, gmm_b, MASK);
    [gmm_f1, gmm_b1] = learn_gmms(im, mask, comp_idx, gmm_f, gmm_b, MASK);
    
    
end

















