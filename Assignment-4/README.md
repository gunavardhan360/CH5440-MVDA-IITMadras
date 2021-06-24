1. Apply Non-negative matrix factorization (NMF) to extract the pure component spectra
from the mixture UV absorbance data set used in assignment 3. Assume that the number
of pure components in the mixture is known to be three (NMF requires the number of pure
species to be specified by the user). For this purpose you can either use the code provided
(Prof. Haesun Park of Georgia Tech) or write your own code using the ALS multiplicative
update rules. Before applying NMF it is better to set all negative absorbance values in the
data matrix to zero. Also an initial estimate of the non-negative matrices can be obtained
by first using PCA to reduce the rank of the absorbance matrix and use absolute values of
the loadings and scores matrix as initial guesses for the non-negative matrices.
(a) Use the first sample from the five replicates for each of the 26 mixtures and apply NMF
to the data. Compare the extracted pure component spectra to the measured pure
component spectra using correlation and identify which of the pure component spectra are
being extracted well (Note that the order in which NMF extracts the pure components
cannot be ascertained, that is, there is a permutation ambiguity). Therefore you have to
compare each extracted spectra with every pure spectra to determine the permutation order.
(b) Determine the average of the five replicates for each mixture. Apply NMF to the
averaged data and determine whether the pure components spectra are extracted more
accurately.
Report the correlations for the two cases in the form of a table and report your conclusions.
2. For the flow process and data given in problem 1 of assignment 3, we wish to derive the
constraint matrix from data using NCA. For this purpose assume that the structure of the
constraint matrix is known.
(a) Show that the constraint matrix for the given network is NCA complaint.
(b) Use the gNCA code provided to estimate the constraint matrix and compute the
subspace angle between true and estimated constraint matrix. Also estimate the
maxdiff value defined in problem 1 of assignment 3 for F3, F5 chosen as
independent variables. Does NCA perform better than PCA? If so, why?
(c) Assume that the diagonal elements of the error covariance matrix are given by
[0.01, 0.0064, 0.0369, 0.0544, 0.0324]. Use the error covariance matrix to
appropriately scale the data and apply NCA on scaled data to estimate the constraint
matrix (this is maximum likelihood NCA similar to MLPCA). Report the subspace
angle and maxdiff value. Are the results using MLNCA better than MLPCA? If
so, why?
