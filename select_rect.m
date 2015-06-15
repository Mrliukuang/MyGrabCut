function [im_1d, alpha, im_sub] = select_rect(im)
%% User select a rectangle as foreground
% Inputs:
%   - im: input image of size [H, W, C]
%
% Outputs:
%   - im_1d: reshape im into 1D [H*W, C]
%   - alpha: labels for each pixel 0 for backgrond, 1 for foreground of size [H, W]
%   - im_sub: sub image user select


%% A bounding box initialization
disp('Draw a bounding box to specify the rough location of the foreground');
set(gca,'Units','pixels');
ginput(1);
p1=get(gca,'CurrentPoint');  fr=rbbox;
p2=get(gca,'CurrentPoint');
p=round([p1; p2]);
xmin=min(p(:, 1)); xmax=max(p(:, 1));
ymin=min(p(:, 2)); ymax=max(p(:, 2));
[im_height, im_width, channel_num] = size(im);
xmin = max(xmin, 1); xmax = min(im_width, xmax);
ymin = max(ymin, 1); ymax = min(im_height, ymax);

bbox = [xmin, ymin, xmax, ymax];
line(bbox([1 3 3 1 1]),bbox([2 2 4 4 2]),'Color',[1 0 0],'LineWidth',1);
if channel_num ~= 3
    disp('This image does not have all the RGB channels, you do not need to work on it.');
    return;
end

% Get image dimension
[im_h, im_w, im_c] = size(im);

% Pixel label: 1 for foreground, 0 for background
alpha_2d = zeros(im_h, im_w);
alpha_2d(ymin:ymax, xmin:xmax) = 1;

im_sub = im(ymin:ymax, xmin:xmax, :);

% Reshape im & alpha into 1D
im_1d = reshape(im, [], im_c);
alpha = alpha_2d(:);
