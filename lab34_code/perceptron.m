function [sepplane posmiss negmiss] = perceptron(pclass, nclass)
% Computes separating plane (linear classifier) using
% perceptron method.
% pclass - 'positive' class (one row contains one sample)
% nclass - 'negative' class (one row contains one sample)
% Output:
% sepplane - row vector of separating plane coefficients
% posmiss - number (coefficient) of misclassified samples of pclass
% negmiss - number (coefficient) of misclassified samples of nclass

  sepplane = rand(1, columns(pclass) + 1) - 0.5;
  %sepplane = [1, 1, 0];
  nPos = rows(pclass); % number of positive samples
  nNeg = rows(nclass); % number of negative samples
  tset = [ ones(nPos, 1) pclass; -ones(nNeg, 1) -nclass];
  initial_rate = 1;
  max_iter = 400;
  min_change = 0.001;
  i = 1;
  do 
	%%% YOUR CODE GOES HERE %%%
	%% You should:
	%% 1. Check which samples are misclassified (boolean column vector)
	%% 2. Compute separating plane correction 
	%%		This is sum of misclassfied samples coordinate times learning rate 
	%% 3. Modify solution (i.e. sepplane)

	%% 4. Optionally you can include additional conditions to the stop criterion
	%%		200 iterations can take a while and probably in most cases is unnecessary
  
    learning_rate = initial_rate/sqrt(i);
    #boolean vector of misclassified samples
    classification = tset * sepplane'< 0;
    s = sum(reshape(tset(classification(),:),[],columns(tset)),1);
    d_sepplane = learning_rate * s;
    sepplane = sepplane + d_sepplane;
	  ++i;
    if norm(d_sepplane)<min_change
      break;
    endif
  until i >max_iter;
  
  %%% YOUR CODE GOES HERE %%%
  %% You should:
  %% 1. Compute the numbers (coefficients) of misclassified positive 
  %%    and negative samples
  i
  len = rows(classification);
  posmiss = sum(classification(1:nPos,1))/nPos;
  negmiss = sum(classification(nPos+1:end))/nNeg;
end