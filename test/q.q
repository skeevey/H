\p 29001
\S 1

rnorm:{$[x=2*n:x div 2;raze sqrt[-2*log n?1f]*/:(sin;cos)@\:(2*acos -1)*n?1f;-1_.z.s 1+x]};

q:([]time:asc 1000?01:00:00.000000000;sym:`g#1000?`ABC`DEF`GHI;bsize:1000*1+1000?10;bid:1000#0N;ask:1000#0N;asize:1000*1+1000?10);
update bid:abs rand[100f]+sums rnorm[count i] by sym from `q;
update ask:bid + rand 0.5 from `q;