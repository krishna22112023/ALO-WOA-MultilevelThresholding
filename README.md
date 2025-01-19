# Multilevel Image Thresholding using Evolutionary optimization algorithms

This repository is the official implementation of the [paper](https://ieeexplore.ieee.org/abstract/document/8960178) titled "Antlion optimization and Whale optimization Algorithm for multilevel thresholding segmentation" published in i-PACT-2019 (Innovations in Power and Advanced Computing Technologies), IEEE.


## Project Structure

```
root/
├── algorithms/    # Optimization algorithms ALO and WOA
├── utils/         # Utility functions
└── scripts/       # Main execution scripts
└──  data/         # Test images
```

## Benchmark BSD-100
You can download the benchmark dataset [here](https://www2.eecs.berkeley.edu/Research/Projects/CS/vision/bsds/)
to a folder named data/images/

## Usage

```matlab
% Example usage for WOA
results_woa = run_woa('data/images/airplane.bmp', 5, 25, 50);

% Example usage for ALO
results_alo = run_alo('data/images/airplane.bmp', 5, 25, 50);

% Parameters:
% - image_path: Path to input image
% - thresholds: Number of thresholds (2-5)
% - search_agents: Number of search agents (default: 25)
% - max_iter: Maximum iterations (default: 50)
```

## Implementation Details

- Both algorithms use between-class variance as the fitness function
- Image segmentation is performed using the optimal thresholds
- Results include PSNR and SSIM metrics for quality assessment

## Requirements

- MATLAB R2019b or later
- Image Processing Toolbox

## Citation

If you include this in your work, please use the following citation : 
```
S. Iyer, A. P. Nadkarni and P. T. N., "Antlion optimization and Whale optimization Algorithm for multilevel thresholding segmentation," 2019 Innovations in Power and Advanced Computing Technologies (i-PACT), Vellore, India, 2019, pp. 1-8, doi: 10.1109/i-PACT44901.2019.8960178.
```
