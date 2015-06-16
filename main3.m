%% Parameters:
%    im:  image for segmentation
%    mask: in [BGD, FGD]
%    bgdmodel, fgdmodel: background/foreground GMM

% Reference:
%    https://github.com/Mrliukuang/grabcut/blob/master/grabcut.m


clc; clear; close all;
addpath('./gmm');
addpath('./Bk_matlab');


%% Some global variables
MASK.BGD = 0;    % background 
MASK.FGD = 1;    % (probable)foreground

%% Load image
% im = imread('banana1.bmp');
im = imread('C:\Users\Kuang\Desktop\CS231B\1. Image Segmentation\data_GT\person2.jpg');
[H, W, ~] = size(im);
im = double(im) / 255;
imagesc(im)

%% User select a rectangle
[im_1d, alpha, im_sub] = select_rect(im);

%% Colect pixels into back/foreground
ind_f = (alpha == MASK.FGD);    % get index
ind_b = ~ind_f;

im_f = im_1d(ind_f, :);         % collect pixels
im_b = im_1d(ind_b, :);

%% Init GMMs
n_gauss = 5;    % number of Guassian components
gmm_f = fit_gmm(im_f, n_gauss); % foreground model
gmm_b = fit_gmm(im_b, n_gauss); % background model

%% Compute pairwise energy
gamma = 50;
fprintf('Computing pairwise term...\n')
pairwise = compute_pairwise(im_sub, gamma);
fprintf('Pairwise term computed in one shot\n')

max_iter = 100;
E_prev = Inf;
for i = 1:max_iter    
    %% 1. Assign GMM component to each pixel
    [comp_f, comp_b] = assign_gmm_component(im_1d, gmm_f, gmm_b, ind_f, ind_b);

    %% 2. Learn new GMMs, throw away old models
    [gmm_f, gmm_b] = update_gmms(im_1d, comp_f, comp_b, ind_f, ind_b);
    
    %% 3. Estimate segmentation: use min cut to solve
    [ind_f, E] = perform_cut(ind_f, im_sub, alpha, gmm_f, gmm_b, pairwise);
    
    %% Report progress
    E_diff = (E_prev-E) / E_prev;
    fprintf('iter %d: E drops by %.3f%%\n', i, E_diff*100)
    if abs(E_diff) < 1e-4
        break;
    end

    %% Update for next iteration
    ind_b = ~ind_f;
    E_prev = E;
    
    %% Display current result
    im_t = im_1d;
    % set background to white
    im_t(ind_b, :) = 255;
    im_t = reshape(im_t, H, W, []);
    figure;
    imagesc(im_t)
end


































