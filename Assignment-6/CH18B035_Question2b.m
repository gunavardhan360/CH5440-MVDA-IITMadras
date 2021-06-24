%code by GUNAVARDHAN REDDY (CH18B035)
% y(k) = 0.5y(k-3) + 2u[k-3] - 1.8u(k-5)
clc;
clear all;
load siso5unequal

insamples = 1024;
Z = [];
L = 10;
for i = 1:L+1
    Z = [Z ymeas(L + 2 - i:insamples + 1 - i)];
end
for i = 1:L+1
    Z = [Z umeas(L + 2 - i:insamples + 1 - i )];
end
Z = Z';
for i=L+1:-1:1
    [nvar nsamples] = size(Z);
    SZ = Z*Z'/nsamples;
    flag = 1;
    nfact = 22-i;
    sumsing = 0;
    iter = 0;
    vsmall = 1.0e-04;
    covZ = cov(Z');
    vlb = vsmall*sqrt(diag(covZ));  % Lower bound on std
    vlb = [mean(vlb(1:11)) mean(vlb(12:22))];
    vub = sqrt(diag(covZ)); % Upper bound on std
    vub = [mean(vub(1:11)) mean(vub(12:22))];
    x0 = sqrt(vsmall)*vub;
    u = repelem(x0,L+1);
    Ltrue = diag(u);
    Lsinv = inv(Ltrue);
    while(flag)
        iter = iter + 1;
        Zs = zeros(nvar,nsamples);
        Zs = Lsinv*Z/sqrt(nsamples);
        [u s v] = svd(Zs,'econ');
        sdiag = diag(s);
        sumsingnew = sum(sdiag(nfact+1:end));
        A = u(:,nfact+1:end)';
        A = A*Lsinv/sqrt(nsamples);
        theta = A(end,:);
        theta = theta/theta(1);
        if ( abs(sumsingnew -sumsing) <= 0.01 )
            flag = 0;
        else
            [x, fval] = fmincon('obj_val',x0,[],[],[],[],vlb,vub,[],optimset('Display','iter','MaxFunEvals',50000),A,Z);
            u = repelem(x,L+1);
            Ltrue = diag(u);
            Lsinv = inv(Ltrue);
            sumsing = sumsingnew;
        end
    end
    %hypothesis testing
    [u s v] = svd(Z'*Lsinv/sqrt(nsamples-L),'econ');
    diag(s);
    lambda = diag(s).^2;
    n_bar = nsamples - L - (4*L + 15)/16;
    v = (i+2)*(i-1)/2;
    l_bar = sum(lambda(2*L+3-i:2*L+2))/i;
    tow = n_bar*(i*log(l_bar)-sum(log(lambda(2*L+3-i:2*L+2))));
    chi2inv(.975,v);
    if tow < chi2inv(.95,v)
        d = i;
        break
    end
end
%error variance estimate and process order
x.^2
d

eta = L - d + 1;
u = repelem([x(1) x(2)],eta+1);
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
%model estimate
theta = theta/theta(1)