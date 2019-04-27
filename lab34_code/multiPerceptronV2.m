function [classifiers posmiss negmiss] = multiPerceptronV2(pclass, nclass, n)
% Computes n separating planes (linear classifier) using
% perceptron method. Each separating plane is assigned a random point in
% feature space that determines the weight for any considered sample
% pclass - 'positive' class (one row contains one sample)
% nclass - 'negative' class (one row contains one sample)
% Output:
% sepplane - row vector of separating plane coefficients
% posmiss - number (coefficient) of misclassified samples of pclass
% negmiss - number (coefficient) of misclassified samples of nclass
  combined_set = [pclass; nclass];
  data_distrib = [mean(combined_set,1); max(combined_set)- min(combined_set)];
  classifiers = rand(n, columns(combined_set)+1)-0.5;
  
  centers = zeros(n, columns(combined_set));
  %centers = (rand(n, columns(combined_set))-0.5).*data_distrib(2,:).+data_distrib(1,:);
  %centers(1,:) = combined_set(randi([1,rows(combined_set)]), :);
  
  nPos = rows(pclass); % number of positive samples
  nNeg = rows(nclass); % number of negative samples
  tset = [ ones(nPos, 1) pclass; -ones(nNeg, 1) -nclass];
  initial_rate = 1;
  max_iter = 400;
  min_change = 0.001;
  
  #boolean vector of misclassified samples
  global_classification = ones(rows(tset),1);
  for cls =1:n
    i = 1;
    
    misclassified_samples = combined_set(global_classification,:);
    centers(cls, :) = misclassified_samples(randi([1:sum(global_classification)]),:);
    weights = zeros(rows(combined_set),1);
    for sample =1:rows(combined_set)
      distance = norm(combined_set(sample, :)-centers(cls, :));
      weights(sample) = weight(distance);
    endfor
    total_weight = sum(weights);
    weights = weights / total_weight * (nPos+nNeg);
    do  
      learning_rate = initial_rate/sqrt(i);
      #boolean vector of misclassified samples
      local_classification = tset * classifiers(cls, :)'< 0;
      weighed_vec = tset.*weights;
      s = sum(reshape(weighed_vec(local_classification,:),[],columns(tset)),1);
      d_sepplane = learning_rate * s;
      classifiers(cls, :) = classifiers(cls, :) + d_sepplane;
      ++i;
      if norm(d_sepplane)<min_change
        break;
      endif
    until i >max_iter;
    global_classification = multiClassify(combined_set, centers(1:cls,:), classifiers(1:cls,:));
    cls
    incorrect = global_classification;
    incorrect(1:nPos) = incorrect(1:nPos)==0;
    posmiss = sum(incorrect(1:nPos,1))/nPos
    negmiss = sum(incorrect(nPos+1:end))/nNeg
  endfor
  
  
  %%% YOUR CODE GOES HERE %%%
  %% You should:
  %% 1. Compute the numbers (coefficients) of misclassified positive 
  %%    and negative samples
  
  %classification vector contains misclassified samples
  %classification = zeros(rows(tset),1);
  %for sample=1:rows(tset)
  %  label = multiClassify(combined_set(sample, :), centers, classifiers);
  %  classification(sample) = label;
  %endfor
  %classification(1:nPos) = classification(1:nPos)==0;
  %len = rows(classification);
  
end