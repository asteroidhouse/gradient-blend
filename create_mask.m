function mask = create_mask(I)
% Allows the user to freehand-select an image region, and returns a 
% binary mask representing the selected region.
%
% Inputs:
%   I: the original image used as the basis for sampling pixels
% 
% Outputs:
%   mask: a binary matrix of the same size as the input I, that represents 
%         the selected region, i.e. a matrix with 1s at selected pixel positions, 
%         and 0s everywhere else.

imshow(I, []);
freehand_handle = imfreehand();
% Constrains the selected region to be within the bounds of the image.
fcn = makeConstrainToRectFcn('impoly',get(gca,'XLim'),get(gca,'YLim'));
setPositionConstraintFcn(freehand_handle,fcn);
% Waits for the user to double-click to finish creating the mask; this
% allows the user to move or edit the selected region before it is final.
wait(freehand_handle);
mask = freehand_handle.createMask();