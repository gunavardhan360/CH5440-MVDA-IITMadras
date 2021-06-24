%code by GUNAVARDHAN REDDY (CH18B035)
clc ; clear all ;
load 'flowdata3'
nsamples = 1000;
nvar = 5;
nfact = 2;
Astruct = Atrue';

%PART B holestic data
[u s v] = svd(Fmeas','econ');
E = u(:,nfact+1:end)*s(nfact+1:end,nfact+1:end)*v(:,nfact+1:end)';
[C S] = fastNCA(E,Astruct,nvar-nfact);
Amat = C'
theta_ncaB = 180*subspace(Atrue', Amat')/pi
for i = 1:3
    bcol = Atrue(i,:)';
    maxdiff(i) = norm(bcol - Amat'*inv(Amat*Amat')*Amat*bcol);
end
maxdiff_ncaB = sum(maxdiff)

Amat = u(:,nfact+1:end)';
theta_pcaB = 180*subspace(Atrue', Amat')/pi
for i = 1:3
    bcol = Atrue(i,:)';
    maxdiff(i) = norm(bcol - Amat'*inv(Amat*Amat')*Amat*bcol);
end
maxdiff_pcaB = sum(maxdiff)


%PART C with know error covariance matrix
std = [0.01, 0.0064, 0.0369, 0.0544, 0.0324].^.5;
Ltrue = diag(std);
Lsinv = inv(Ltrue);
Ys = Lsinv*Fmeas';
Fmeas = Ys';
[u s v] = svd(Fmeas','econ');
E = u(:,nfact+1:end)*s(nfact+1:end,nfact+1:end)*v(:,nfact+1:end)';
[C S] = fastNCA(E,Astruct,nvar-nfact);
Amat = C'*Lsinv;
theta_ncaC = 180*subspace(Atrue', Amat')/pi
for i = 1:3
    bcol = Atrue(i,:)';
    maxdiff(i) = norm(bcol - Amat'*inv(Amat*Amat')*Amat*bcol);
end
maxdiff_ncaC = sum(maxdiff)

Amat = u(:,3:5)'*Lsinv/sqrt(nsamples);
theta_pcaC = 180*subspace(Atrue', Amat')/pi
for i = 1:3
    bcol = Atrue(i,:)';
    maxdiff(i) = norm(bcol - Amat'*inv(Amat*Amat')*Amat*bcol);
end
maxdiff_pcaC = sum(maxdiff)