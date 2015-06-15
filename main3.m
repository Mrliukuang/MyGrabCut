%% Parameters:
%    im:  image for segmentation
%    mask: in [BGD, FGD]
%    bgdmodel, fgdmodel: background/foreground GMM

% Reference:
%    https://github.com/Mrliukuang/grabcut/blob/master/grabcut.m


clc; clear; close all;
addpath('.\gmm\');
addpath('.\Bk_matlab\');

%% Some global variables
MASK.BGD = 0;    % background 
MASK.FGD = 1;    % (probable)foreground

%% Load image
im = imread('banana1.bmp');
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
pairwise = compute_pairwise(im_sub, gamma);



































