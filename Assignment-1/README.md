1. (a) Let 𝑥𝑥 1 , 𝑥𝑥 2 , ⋯ , 𝑥𝑥 𝑁𝑁 and 𝑦𝑦 1 , 𝑦𝑦 2 , ⋯ , 𝑦𝑦 𝑁𝑁 be a set of N measurements of two variables x and
y which are linearly related. We are interested in determining the linear regression parameter
a where y = ax + b. Assume that the measurements of x and y contain errors, with standard
𝜎𝜎 2
deviations σ δ and σ ε , respectively. (a) If the ratio of the error variances α = 𝜖𝜖 2 is known,
𝜎𝜎
𝛿𝛿
derive the weighted TLS (WTLS) estimates of a and b in terms of 𝑠𝑠 𝑥𝑥𝑥𝑥 , 𝑠𝑠 𝑦𝑦𝑦𝑦 , 𝑥𝑥̅ , 𝑦𝑦�, α . (b) How
will the solution for α change if it is already known that the constant b is known to be 0?
Note: The WTLS regression problem when the error variances are known is the solution of
the following minimization problem. Multiply the objective function by σ ε 2 and replace the
ratio of the error variances by α . Differentiate the objective function with respect to the decision
variables and solve resulting set of nonlinear algebraic equations for obtaining the parameters
a and b.
min (𝑦𝑦 𝑖𝑖 − 𝑎𝑎𝑥𝑥� 𝑖𝑖 − 𝑏𝑏) 2 /𝜎𝜎 𝜀𝜀2 + (𝑥𝑥 𝑖𝑖 − 𝑥𝑥� 𝑖𝑖 ) 2 /𝜎𝜎 𝛿𝛿2
𝛼𝛼,𝛽𝛽,𝑥𝑥� � 𝚤𝚤
(b) From the solution of WTLS, obtain the solutions of the regression parameters for IOLS
and OLS in the limit as α → 0 and α → ∞. Also obtain the solution for the estimates of x i and
y i for each case (OLS, IOLS, WTLS) in terms of the regression parameters and measurements
2. The level of phytic acid in urine samples was determined by a catalytic fluorimetric (CF)
method and the results were compared with those obtained using an established extraction
photometric (EP) technique. The results, in mg/L, are the means of triplicate measurements, as
shown in Table 2.
(a) Is the new method (CF) a good substitute for the established method (EP) for measuring
the level of phytic acid in urine? Justify your conclusion using linear regression between
the two methods for different modelling assumptions regarding the accuracy of the
respective measurement techniques.
(b) Estimate the level of phytic acid in urine if EP measurement is 2.31 mg/l and CF
measurement is 2.20 mg/l, for different modelling assumptions and provide 95%
confidence intervals for these estimates, if possible.
3.
Carbon-dioxide (CO2) is one of the major greenhouse gases that is implicated in the gradual
warming of the earth’s temperature. Measured concentrations of CO2 (in ppm) and
atmospheric temperature (spatially and temporally averaged over a year) available from
USEPA’s Climate Change Indicators website (www.epa.gov/climate-indicators) between
1984 and 2014 is given in Table 1. The temperatures are deviation in deg F from the averagetemperature in the period 1901-2000. Climate models recommend that the global temperature
increase should be kept below 1.5 deg C by cutting down on CO2 emissions. Using linear
regression estimate the maximum permissible level of CO2 in the atmosphere that can meet
this goal. Your estimate should be conservative (which implies that among all estimates based
on different assumptions you should use the least value). Note that this is a simplified analysis
because other greenhouse gases such as methane, nitrous oxide, water vapour, etc. have not
been considered. In order to improve your model you are encouraged to use other reliable data
sources you can find (cite the sources from where you obtain additional data).
