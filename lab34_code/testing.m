[tvec tlab tstv tstl] = readSets(); 
comp_count = 80; 
[mu trmx] = prepTransform(tvec, comp_count);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);
tlab = tlab + 1;
tstl = tstl + 1;

threes = tvec(tlab==4, :);
fives = tvec(tlab==6, :);
[sp, fpos_init, fneg_init] = perceptron(threes, fives);
combined_set = [threes; fives];
results = [ones(rows(combined_set),1) combined_set] * sp';
results = results>0;
correct = [results(1:rows(threes))==1; results(rows(threes)+1:end)==0];

data_distrib = [mean(combined_set,1); max(combined_set); min(combined_set)]

reps = 10
sp_list = zeros(reps, columns(sp));
subset_size = 0.1;
distances = zeros(rows(combined_set), reps);
for i=1:reps
  idx1 = randi(rows(threes), rows(threes)*subset_size,1);
  idx2 = randi(rows(fives), rows(fives)*subset_size,1);
  [sp_list(i,:), ~, ~] = perceptron(threes(idx1, :), fives(idx2, :));
endfor

distances = [ones(rows(distances),1) combined_set] * sp_list';
results = sum(distances>0,2)>0;
correct = [results(1:rows(threes))==1; results(rows(threes)+1:end)==0];
