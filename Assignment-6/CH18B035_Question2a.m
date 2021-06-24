%code by GUNAVARDHAN REDDY (CH18B035)
% y(k) = 0.5y(k-3) + 2u[k-3] - 1.8u(k-5)
clc ; clear all ;
load siso5unequal.mat

%PART-A known error variance
nsamples = 1024;
z = [];
L = 10;
for i = 1:L+1
    z = [z ymeas(L + 2 - i:nsamples + 1 - i)];
end
for i = 1:L+1
    z = [z umeas(L + 2 - i:nsamples + 1 - i)];
end
u = repelem([sqrt(.8697) sqrt(0.0965)],L+1);
Ltrue = diag(u);
Lsinv = inv(Ltrue);
[u s v] = svd(z*Lsinv/sqrt(nsamples-L),'econ');
diag(s);
lambda = diag(s).^2;
n_bar = nsamples - L - (4*L + 15)/16;
%hypothesis testing
for i=L+1:-1:1
    v = (i+2)*(i-1)/2;
    l_bar = sum(lambda(2*L+3-i:2*L+2))/i;
    tow = n_bar*(i*log(l_bar)-sum(log(lambda(2*L+3-i:2*L+2))));
    chi2inv(.975,v);
    if tow < chi2inv(.95,v)
        d = i;
        break
    end
end
d;
eta = L - d + 1;
u = repelem([sqrt(.8697) sqrt(0.0965)],eta+1);
Ltrue = diag(u);
Lsinv = inv(Ltrue);
Zeta = [];
for i = eta+1:-1:1
    Zeta = [Zeta ymeas(i:nsamples+i-L-1)];
end
for i = eta+1:-1:1
    Zeta = [Zeta umeas(i:nsamples+i-L-1)];
end
[u s v] = svd(Zeta*Lsinv/sqrt(nsamples-eta),'econ');
lambda = diag(s).^2;
theta = v(:,end)'*Lsinv;
theta = theta/theta(1);