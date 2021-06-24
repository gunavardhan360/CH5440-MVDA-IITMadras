clear all
clc
load flowdata3 
Z = Fmeas';
[nvar nsamples] = size(Z);
SZ = Z*Z'/nsamples;  % mean not removed
% scale_factor = sqrt(diag(SZ));
% scale_factor = sqrt(nsamples*diag(Qe));
% scale_factor = [10 5 20 15 1];
scale_factor = sqrt(nsamples)*ones(1,nvar);
% scale_factor = sqrt(nsamples)*std;
flag = 1;
nfact = 2;
sumsing = 0;
iter = 0;
vsmall = 1.0e-04;
covZ = cov(Z');
vlb = vsmall*sqrt(diag(covZ));  % Lower bound on std
vub = sqrt(diag(covZ)); % Upper bound on std
x0 = sqrt(vsmall)*vub;  % Initial estimate of error covariance taken as identify matrix
while (flag)
    iter = iter + 1;
    Zs = zeros(nvar,nsamples);
    % Scale the data
    for i = 1:nvar
        for j = 1:nsamples
            Zs(i,j) = Z(i,j)/scale_factor(i);
        end
    end
    % Estimate number of PCs to retain
    [u s v] = svd(Zs,'econ');
    sdiag = diag(s);
    sumsingnew = sum(sdiag(nfact+1:end));
    %  Obtain constraint matrix in scaled domain
    for k = nfact+1:nvar
        Amat(k-nfact,:) = u(:,k)';
    end
    % Get the constraint matrix in terms of original variables
    for k = 1:nvar
        Amat(:,k) = Amat(:,k)/scale_factor(k);
    end
    if ( abs(sumsingnew -sumsing) <= 0.01 )
        flag = 0;
    else
        % Estimate covariance matrix (diagonal) and iterate
%         eststd = stdest(Amat,Z);
        [eststd, fval] = fmincon('obj_val',x0,[],[],[],[],vlb,vub,[],optimset('Display','iter','MaxFunEvals',50000),Amat,Z);
        scale_factor = sqrt(nsamples)*eststd;
        sumsing = sumsingnew;
    end
    % Set initial estimates of error covariances for next iteration to be
    % the converged estimates from previous iteration
    x0 = eststd;
end

Amat;
spca = diag(s);
theta_pca = 180*subspace(Atrue', Amat')/pi;
% Determine how well the model matches with the true constraint matrix.
% For this determine the minimum distance of each true constraint vector from the
% row space of model constraints
for i = 1:3
    bcol = Atrue(i,:)';
    dist_pca(i) = norm(bcol - Amat'*inv(Amat*Amat')*Amat*bcol);
end

% Regression model for the five variable flow problem
Aind = Atrue(:,1:2);
Adep = Atrue(:,3:5);
Rtrue = -inv(Adep)*Aind;
Aindest = Amat(:,1:2) ;
Adepest = Amat(:,3:5);
Rest = -inv(Adepest)*Aindest;
maxerr = max(max(abs(Rtrue-Rest)));

