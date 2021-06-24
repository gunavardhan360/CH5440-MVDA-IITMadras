1. 1024 samples of inputs and outputs are generated for the following SISO
dynamic system and stored in siso5equal.mat. The input and output
measurements are corrupted by errors (white noise) having the same
variance.
∗ [
] − 0.5 ∗ [ − 3] = 2 ∗ [ − 3] − 1.8 ∗ [ − 5]
(a) Assuming that the input and output orders are known construct the
appropriate data matrix and apply LPCA to estimate the model coefficients.
(b) Assuming that the process order (maximum of the input and output order)
for the above system is known, construct the appropriate lagged data matrix
and apply LPCA to estimate all the model coefficients. In order to determine
whether the model coefficients are significant, perform a bootstrap (using
100 bootstrap sets) to estimate the mean and standard deviations of each
coefficient (Unlike Monte Carlo simulation where several different data sets
are generated for the same system using different random errors, in a
bootstrap multiple sample sets are generated from a single simulation run
by using sub-sampling. It may be noted that for a given data set, PCA can
be applied to any random sub-sample, say a random sub-set of 75% of the
data. Extend this idea to the dynamic case). Are you able to estimate the
input order, output order and delay correctly? Also report the estimated
value of error variance.
(c) Assume that the order/delay are not known. Apply DPCA to estimate the
process order using a lag of 10 (use hypothesis testing to determine the
number of constraints by starting with the maximum possible value of
number of constraints and decrementing it until the null hypothesis is not
rejected). Subsequently, use LPCA to estimate the model coefficients.
Repeat using a lag of 15. In both cases also report the estimated value of
the error variance.
2. Measurements for the SISO dynamic system described in previous
example were generated using an error variance of 0.0965 for input
measurement and 0.8697 for output measurement, and the data is stored
in siso5unequal.mat.
(a) Assuming that error variances are known, modify DPCA suitably to
estimate the process order (using a lag of 10), followed by modified LPCA
to estimate the model coefficients.
(b) Assuming that no information about the system is known, develop an
iterative procedure combining ideas in DPCA and IPCA to simultaneously
estimate both the error variances and process order. Report the steps of
your algorithm. Use the estimated variances and process order to modifyLPCA suitably to estimate the model coefficients.
coefficients obtained for a lag of 10.
