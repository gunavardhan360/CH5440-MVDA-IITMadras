%code by GUNAVARDHAN REDDY (CH18B035)
clc ; clear all ;
load 'flowdata3'

nsamples = 1000;
nvar = 5;
nfact = 2;
Ltrue = diag(std(1:5));
Lsinv = inv(Ltrue);

Ys = Lsinv*Fmeas'/sqrt(nsamples);
[u s v] = svds(Ys,nvar);
s
for k = nfact+1:nvar
    Amat(k-nfact,:) = u(:,k)';
end
Amat = Amat*Lsinv/sqrt(nsamples)
sval = diag(s);
spca = diag(s);
theta_pca = 180*subspace(Atrue', Amat')/pi;
for i = 1:3
    bcol = Atrue(i,:)';
    maxdiff(i) = norm(bcol - Amat'*inv(Amat*Amat')*Amat*bcol);
end

maxdiff;
sum(maxdiff);
%part A ends
std_partB = stdest(Amat,Fmeas')';


Ltrue = diag(std_partB(1:5));
Lsinv = inv(Ltrue);

Ys = Lsinv*Fmeas'/sqrt(nsamples);
[u s v] = svds(Ys,nvar);
for k = nfact+1:nvar
    Amat(k-nfact,:) = u(:,k)';
end
Amat = Amat*Lsinv/sqrt(nsamples);
sval = diag(s);
spca = diag(s);
theta_pca = 180*subspace(Atrue', Amat')/pi
for i = 1:3
    bcol = Atrue(i,:)';
    maxdiff(i) = norm(bcol - Amat'*inv(Amat*Amat')*Amat*bcol);
end

maxdiff;
sum(maxdiff);
%part B ends

datamatrix = (Fmeas)./(std(1:5)*sqrt(nsamples));
[U S V] = svds(datamatrix);
S;
V;
Ames = V(1:5,2:5)'./(std(1:5)*sqrt(nsamples));
stdest(Ames,Fmeas')';
%part C ends

Adep = Atrue(:,[1,2,5]);
cond(Adep);
Adep = Atrue(:,[1,2,3]);
cond(Adep);
%part D ends