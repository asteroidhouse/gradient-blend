% This program creates an interactive application for gradient domain editing.

clear all;
close all;

% Read in the source and target images:
source = im2double(imread('input/jerry.jpg'));
target = im2double(imread('input/thor4.jpg'));

[t_rows, t_cols, channels] = size(target);

% Open an interactive session to allow the user to freehand select a region
% of interest in the source image, and create a mask for that region:
mask = create_mask(source);

% We find the bounding box containing the nonzero values in the mask:
[nonzero_rows, nonzero_cols] = find(mask);
min_row = min(nonzero_rows);
max_row = max(nonzero_rows);
min_col = min(nonzero_cols);
max_col = max(nonzero_cols);

width = max_col - min_col;
height = max_row - min_row;

% We crop the source image and the mask itself to the size of the bounding
% box, since the only pixels we care about from the source are those within
% the mask:
source_cropped = source(min_row:max_row, min_col:max_col, :);
mask_cropped = mask(min_row:max_row, min_col:max_col);

%figure; imshow(source_cropped);
%figure; imshow(mask_cropped);

% We show the user the target image and allow him to drag and resize the 
% rectangle representing the bounding box of the mask. This shows the user
% the position and size of the copied patch from the source in the
% destination image:
figure; imshow(target);
rect_handle = imrect(gca, [min_row min_col width height]);
setFixedAspectRatioMode(rect_handle,1);
wait(rect_handle);
pos = rect_handle.getPosition()

% Extract the components of the position:
xmin = pos(1);
ymin = pos(2);
rect_cols = pos(3);
rect_rows = pos(4);

% Resize the source and mask if desired:
rf = imresize(source_cropped, [rect_rows, rect_cols]);
rm = imresize(mask_cropped, [rect_rows, rect_cols]);

% Pad the source and the mask to be the same dimensions as the target image
source_padded = padarray(rf, [(size(target,1)-size(rf,1)), size(target,2)-size(rf,2)], 'post');
mask_padded = padarray(rm, [(size(target,1)-size(rm,1)), size(target,2)-size(rm,2)], 'post');


% Translate the source and target by the user-given (x,y) offset
source = imtranslate(source_padded, [xmin,ymin]);
mask = imtranslate(mask_padded, [xmin,ymin]);

% Now we find the new bounding box for the translated and resized region:
[nonzero_rows, nonzero_cols] = find(mask);
min_row = min(nonzero_rows);
max_row = max(nonzero_rows);
min_col = min(nonzero_cols);
max_col = max(nonzero_cols);

width = max_col - min_col;
height = max_row - min_row;

% Now we crop all the images: the source, the mask, and the target, to
% focus on the region that has to be blended:
source_region = source(min_row:max_row, min_col:max_col, :);
mask_region = mask(min_row:max_row, min_col:max_col);
target_region = target(min_row:max_row, min_col:max_col, :);

% Show the naive copy-paste solution:
foreground = source .* repmat(mask, [1,1,3]);
background = target .* repmat(~mask, [1,1,3]);
direct_copy = background + foreground;
figure;
imshow(direct_copy);

% Find the result of blending the cropped region:
result = gradient_blend(source_region, mask_region, target_region);

% Insert the blended cropped region back into its place in the original
% target, forming the final image:
blended_image = target;
blended_image(min_row:max_row, min_col:max_col, :) = result(:,:,:);

figure; imshow(blended_image);
