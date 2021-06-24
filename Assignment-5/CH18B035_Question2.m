%code by GUNAVARDHAN REDDY (CH18B035)
clc ; clear all ;
load autocomp

A = carbdata - mean(carbdata);
[U S V] = svd(A,'econ');
S = S*S;
TOTAL_VARIANCE = sum(diag(S))
[Fcomp,adj_var,cum_var] = sparsePCA(A, 5, 1);
find(Fcomp) 
SPCS_VARAINCE = adj_var/TOTAL_VARIANCE