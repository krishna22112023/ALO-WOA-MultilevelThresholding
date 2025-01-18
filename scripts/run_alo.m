function [results] = run_alo(img_path, thresholds, search_agents, max_iter)
%RUN_ALO Run Ant Lion Optimization for multilevel thresholding
%   Detailed implementation of ALO-based image thresholding
%
%   Parameters:
%   img_path - Path to the input image
%   thresholds - Number of thresholds (2-5 recommended)
%   search_agents - Number of search agents (default: 25)
%   max_iter - Maximum iterations (default: 50)
%
%   Returns:
%   results - Struct containing:
%       - thresholds: Optimal threshold values
%       - segmented_img: Segmented image
%       - fitness: Best fitness value
%       - psnr: Peak Signal-to-Noise Ratio
%       - ssim: Structural Similarity Index
%       - time: Computation time
%       - convergence: Convergence curve

% Input validation
if nargin < 2
    error('At least image path and number of thresholds are required');
end
if nargin < 3
    search_agents = 25;  % Default number of search agents
end
if nargin < 4
    max_iter = 50;      % Default number of iterations
end

% Read and prepare image
[img, lb, ub] = prepare_image(img_path);

% Initialize results structure
results = struct();
results.original_img = img;
results.parameters = struct('thresholds', thresholds, ...
                          'search_agents', search_agents, ...
                          'max_iter', max_iter);

% Run multiple iterations to get stable results
num_runs = 5;
threshold_results = zeros(num_runs, thresholds);

tic;  % Start timing
for iter = 1:num_runs
    % Run ALO optimization
    [elite_fitness, elite_pos, conv_curve] = ALO(thresholds, search_agents, ...
                                                max_iter, lb, ub, img);
    threshold_results(iter, :) = round(elite_pos);
end
results.time = toc;  % Store computation time

% Average the thresholds from multiple runs
avg_thresholds = round(mean(threshold_results, 1));
results.thresholds = sort(avg_thresholds);  % Store sorted thresholds

% Perform image segmentation
intensity_values = [0 results.thresholds(2:end) 255];
results.segmented_img = imquantize(img, results.thresholds, intensity_values);

% Calculate image quality metrics
results.psnr = psnr(img, uint8(results.segmented_img));
results.ssim = ssim(img, uint8(results.segmented_img));
results.fitness = fitness(results.thresholds, img);
results.convergence = conv_curve;

% Store all trial results for analysis
results.all_trials = threshold_results;

% Optional: Display results
if nargout == 0
    % Create figure with subplots
    figure('Name', 'ALO Thresholding Results');
    
    % Original image
    subplot(1,2,1);
    imshow(img);
    title('Original Image');
    
    % Segmented image
    subplot(1,2,2);
    imshow(uint8(results.segmented_img));
    title('Segmented Image');
    
    % Display metrics
    fprintf('\nALO Thresholding Results:\n');
    fprintf('Optimal Thresholds: %s\n', mat2str(results.thresholds));
    fprintf('PSNR: %.2f dB\n', results.psnr);
    fprintf('SSIM: %.4f\n', results.ssim);
    fprintf('Computation Time: %.2f seconds\n', results.time);
    fprintf('Final Fitness: %.4f\n', results.fitness);
end

end