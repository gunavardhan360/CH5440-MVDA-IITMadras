function [fval] = obj_val(x,A,Z)
%  function which computes objective function for estimating standard
%  deviation of errors in IPCA
% INPUTS:
% x : decision variable vector (guess of error stds provided by optimizer)
% A : m x n constraint matrix
% Z : data matrix n x N, n rows are variables and N columns are samples
% %
% OUTPUTS
%  eststd : Estimated measurement error standard deviations
%  fval : Optimum objective function value
%
% Assume that error covariance matrix is diagonal and 
% decision variables are square root of these elements
% Compute the objective function as the sum squared differences between LHS
% and RHS of least squares approach
[m n] = size(A);
nz = length(x);
maxnz = m*(m+1)/2;
if ( maxnz < 2 )
        disp ('The maximum number of nonzero elements of Qe that can be estimated exceeds limit');
        return
end
% Construct G matrix
G = [];
for j = 1:n
    C = [];
    for i = 1:m
      C = [C; A(i,j)*A(i:m,j)];
    end
    G = [G, C];
end
% Construct RHS of equation
nsamples = size(Z,2);
R = A*Z;
V = R*R'/nsamples;
vecV = [];
for i = 1:m
    vecV = [vecV; V(i:end,i)];
end
x = [mean(x(1))*ones(n/2,1); mean(x(2))*ones(n/2,1)];
error = vecV - G*(x.^2);
fval = norm(error);

