%code by GUNAVARDHAN REDDY (CH18B035)
clc ; clear all ;
load 'flowdata3'

nsamples = 1000;
nvar = 5;
nfact = 2;
Ltrue = diag(std(1:5));
Ltrue(3,4) = std(6);
Ltrue(4,3) = std(6);
Lsinv = inv(Ltrue);

Ys = Lsinv*Fmeas'/sqrt(nsamples);
[u s v] = svds(Ys,nvar);
for k = nfact+1:nvar
    Amat(k-nfact,:) = u(:,k)';
end
Amat = Amat*Lsinv/sqrt(nsamples);
std1 = stdest(Amat,Fmeas')

Ltrue = diag(std1(1:5));
Ltrue(3,4) = std1(6);
Ltrue(4,3) = std1(6);
Lsinv = inv(Ltrue);

Ys = Lsinv*Fmeas'/sqrt(nsamples);
[u s v] = svds(Ys,nvar);
s
for k = nfact+1:nvar
    Amat(k-nfact,:) = u(:,k)';
end
Amat = Amat*Lsinv/sqrt(nsamples);
sval = diag(s);
spca = diag(s);
theta_pca1 = 180*subspace(Atrue', Amat')/pi
for i = 1:3
    bcol = Atrue(i,:)';
    maxdiff1(i) = norm(bcol - Amat'*inv(Amat*Amat')*Amat*bcol);
end

maxdiff1
sum(maxdiff1)

function [sd] = stdest(A,Y);
%  function for generating initial estimate of error covariance matrix
%  based on Keller's method (least squares solution)
% INPUTS:
% A : m x n constraint matrix
% Y : data matrix n x N, n rows are variables and N columns are samples
% %
% OUTPUTS
%  sd : Estimated measurement error standard deviations
%
[m n] = size(A);
nz = n;
maxnz = m*(m+1)/2;
if ( nz > maxnz )
        disp ('The maximum number of nonzero elements of Qe that can be estimated exceeds limit');
        return
end
% Construct D matrix
G = [];
for j = 1:n
    C = [];
    for i = 1:m
        C = [C; A(i,j)*A(:,j)];
    end
    G = [G, C];
end
C = [];
for i = 1:m
    C = [C; (A(i,3)*A(:,4) + A(i,4)*A(:,3))];
end
G = [G, C];
% Construct RHS of equation
nsamples = size(Y,2);
R = A*Y;
V = R*R'/nsamples;
vecV = [];
for i = 1:m
    vecV = [vecV; V(:,i)];
end
% Least squares estimate
sd = sqrt(abs((G'*G)\(G'*vecV)));
end

