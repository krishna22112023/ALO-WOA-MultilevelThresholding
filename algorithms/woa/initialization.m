% This function initialize the first population of search agents
function Positions=initialization(SearchAgents_no,thresholds,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries

%generate random population of whales whose matrix dimension is
%Number of whales X number of thresholds
if Boundary_no==1
    Positions=rand(SearchAgents_no,thresholds).*double((ub-lb)+lb);

end

end
