function X=initialization(SearchAgents_no,dim,ub,lb)

Boundary_no= size(ub,2); % numnber of boundaries


% generate random threshold values whose matrix dimension is
% SearchAgents_no X number of thresholds(dim)
if Boundary_no==1
    X=rand(SearchAgents_no,dim).*double((ub-lb)+lb);
end


end
