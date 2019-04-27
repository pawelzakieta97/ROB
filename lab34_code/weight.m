function w = weight(distance)
  deviation = 5;
  w = 1/(1+(distance/deviation)^(4));
endfunction
