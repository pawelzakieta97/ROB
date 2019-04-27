function label = multiClassify(sample, centers, classifiers)
  weights = zeros(rows(centers),1);
  for w=1:rows(centers)
    weights(w) = weight(norm(sample-centers(w)));
  endfor
  sum = zeros(rows(sample),1);
  for cls = 1:rows(classifiers)
    sum = sum + [ones(rows(sample), 1) sample]*classifiers(cls,:)'*weights(cls);
  endfor
  label = sum>0;
endfunction
