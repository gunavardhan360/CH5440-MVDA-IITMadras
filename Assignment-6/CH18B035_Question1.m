%code by GUNAVARDHAN REDDY (CH18B035)
% y(k) = 0.5y(k-3) + 2u[k-3] - 1.8u(k-5)
clc ; clear all ;
load siso5equal.mat

nsamples = 1024;
eta = 5;
Z = [];
for i = 1:eta+1
    Z = [Z ymeas(eta + 2 - i:nsamples + 1 - i)];
end
for i = 1:eta+1
    Z = [Z umeas(eta + 2 - i:nsamples + 1 - i)];
end
%PART-A LPCA on lagged data matrix
[u s v] = svd(Z/sqrt(nsamples - eta),'econ');
lambda = diag(s).^2;
theta = v(:,end)';
theta = theta/theta(1);

%PART-B LPCA bootstrap on hundred sets
coef = bootstrp(100,@LPCA, Z);
mean(coef);
mean(coef) + 2.16*std(coef);
mean(coef) - 2.16*std(coef);
std(coef);

%PART-C DPCA on lagged data matrix with subsequent LPCA lag 10
z = [];
L = 10;
for i = 1:L+1
    z = [z ymeas(L + 2 - i:nsamples + 1 - i)];
end
for i = 1:L+1
    z = [z umeas(L + 2 - i:nsamples + 1 - i)];
end
[u s v] = svd(z/sqrt(nsamples-L),'econ');
diag(s);
lambda = diag(s).^2;
n_bar = nsamples - L - (4*L + 15)/16;
%hypothesis testing
for i=L+1:-1:1
    v = (i+2)*(i-1)/2;
    l_bar = sum(lambda(2*L+3-i:2*L+2))/i;
    tow = n_bar*(i*log(l_bar)-sum(log(lambda(2*L+3-i:2*L+2))));
    chi2inv(.975,v);
    if tow < chi2inv(.975,v)
        d = i;
        break
    end
end
d;
eta = L - d + 1;
Zeta = [];
for i = eta+1:-1:1
    Zeta = [Zeta ymeas(i:nsamples+i-L-1)];
end
for i = eta+1:-1:1
    Zeta = [Zeta umeas(i:nsamples+i-L-1)];
end
[u s v] = svd(Zeta/sqrt(nsamples-eta),'econ');
lambda = diag(s).^2;
theta = v(:,end)';
theta = theta/theta(1);


%PART-C DPCA on lagged data matrix with subsequent LPCA lag 15
z = [];
L = 15;
for i = 1:L+1
    z = [z ymeas(L + 2 - i:nsamples + 1 - i)];
end
for i = 1:L+1
    z = [z umeas(L + 2 - i:nsamples + 1 - i)];
end
[u s v] = svd(z/sqrt(nsamples-L),'econ');
diag(s);
lambda = diag(s).^2;
mean(lambda(22:32));
n_bar = nsamples - L - (4*L + 15)/16;
%hypothesis testing
for i=L+1:-1:1
    v = (i+2)*(i-1)/2;
    l_bar = sum(lambda(2*L+3-i:2*L+2))/i;
    tow = n_bar*(i*log(l_bar)-sum(log(lambda(2*L+3-i:2*L+2))));
    chi2inv(.975,v);
    if tow < chi2inv(.975,v)
        d = i;
        break
    end
end
d;
eta = L - d + 1;
Zeta = [];
for i = eta+1:-1:1
    Zeta = [Zeta ymeas(i:nsamples+i-L-1)];
end
for i = eta+1:-1:1
    Zeta = [Zeta umeas(i:nsamples+i-L-1)];
end
[u s v] = svd(Zeta/sqrt(nsamples-eta),'econ');
lambda = diag(s).^2;
theta = v(:,end)';
theta = theta/theta(1);


%function used in bootstrap function
function coef = LPCA(Z)
    [u s v] = svd(Z,'econ');
    theta = v(:,end)';
    theta = theta/theta(1);
    coef = theta';
end