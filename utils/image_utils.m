function [processed_img, lb, ub] = prepare_image(img_path)
    % Read and preprocess image
    img = imread(img_path);
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Find bounds
    lb = double(min(img(:)));
    ub = double(max(img(:)));
    
    processed_img = img;
end