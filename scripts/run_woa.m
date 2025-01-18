function results = run_woa(img_path, thresholds, search_agents, max_iter)
    % Load and prepare image
    [img, lb, ub] = prepare_image(img_path);
    
    % Run optimization
    [Leader_score, Leader_pos, conv_curve] = WOA(thresholds, search_agents, max_iter, lb, ub, img);
    
    % Process results
    results.thresholds = sort(round(Leader_pos));
    results.fitness = Leader_score;
    results.convergence = conv_curve;
    
    % Perform segmentation
    value = [0 results.thresholds(2:end) 255];
    results.segmented_img = imquantize(img, results.thresholds, value);
    
    % Compute metrics
    results.psnr = psnr(img, uint8(results.segmented_img));
    results.ssim = ssim(img, uint8(results.segmented_img));
end
