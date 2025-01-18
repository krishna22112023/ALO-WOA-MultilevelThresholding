%In order to model the antlions hunting capability, a roulette
% wheel is employed. As in Fig. 3 of the paper,ants are assumed to be trapped
% in only one selected antlion. The ALO algorithm is required to utilize
% a roulette wheel operator for selecting antlions based on their
% fitness during optimization. This mechanism gives high chances
% to the fitter antlions for catching ants.

% Usage example:
% fortune_wheel ([1 5 3 15 8 1])
%    most probable result is 4 (weights 15)

function choice = roulette_wheel(weights)
  accumulation = cumsum(weights);
  p = rand() * accumulation(end);
  chosen_index = -1;
  for index = 1 : length(accumulation)
    if (accumulation(index) > p)
      chosen_index = index;
      break;
    end
  end
  choice = chosen_index;
