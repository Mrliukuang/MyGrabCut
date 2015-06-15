% function [xmin, ymin, xmax, ymax] = get_bbox(im)
function rect = get_bbox(im)
% a bounding box initialization
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

rect.xmin = xmin;
rect.xmax = xmax;
rect.ymin = ymin;
rect.ymax = ymax;
rect.width = xmax-xmin+1;
rect.height = ymax-ymin+1;