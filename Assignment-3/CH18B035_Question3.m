%  Test the expt. data sets downloaded from Wentzell's site both with PCR (assuming covariance matrix of errors for all samples are
%  same).  Here the data at different wavelengths is assumed to be the
%  different samples.  Absorbance for 26 different mixture concentrations at 176
%  different wavelengths are taken and each is repeated 5 times to give a
%  data matrix of size 130 x 176 (n x N). Corresponding to each conc. since
%  5 readings are taken at all wavelengths, we compute the average of every
%  5 rows to get a data matrix of size 26 x 176.
clear all
clc

load 'inorfull'

%  Compute average of every 5 rows of DATA matrix and store.  To be used
%  with lab data generated experimentally by Wentzell and loaded in his web site.

Yavg = [];
Ysample = [];
stdavg = [];
concavg = [];
for i=1:26
    istart = 5*(i-1)+1;
    Ysample = [Ysample; DATA(istart,:)];
    iend = istart+4;
    avg = mean(DATA(istart:iend,:),1);
    stda = mean(stdDATA(istart:iend,:),1)/sqrt(5);
    Yavg = [Yavg; avg];
    stdavg = [stdavg; stda];
    avg = mean(CONC(istart:iend,:),1);
    concavg = [concavg;avg];
end

nPC = 3;
RMSEPCRavg = [];
% PCR on averaged values
for i = 1:nPC
%     nPC = i;
%     [U S V] = svd(Yavg,0); % Economical svd
%     T = Yavg*V(:,1:nPC);  % Compute scores for chosen number of PCs
%     BPCR = inv(T'*T)*T'*concavg;
%     RMSEPCRavg(i) = norm(concavg - T*BPCR);
      RMSEPCRavg = [RMSEPCRavg; LOOCV_PCR(Yavg,concavg,i)];
end
 

[m1 idx1] = max(PureCo);
[m2 idx2] = max(PureCr);
[m3 idx3] = max(PureNi);
X1 = [Yavg(:,idx1),Yavg(:,idx2),Yavg(:,idx3)];
RMSE_partA = sum(LOOCV_PCR(X1,concavg,3));

X = DATA(1:5:end,:);
Y = CONC(1:5:end,:);
Ys = Y - mean(Y,1);
Xs = X - mean(X,1);
RMSE_partB(1) = sum(LOOCV_PCR(Xs,Ys,1));
RMSE_partB(2) = sum(LOOCV_PCR(Xs,Ys,2));
RMSE_partB(3) = sum(LOOCV_PCR(Xs,Ys,3));
RMSE_partB(4) = sum(LOOCV_PCR(Xs,Ys,4));
RMSE_partB(5) = sum(LOOCV_PCR(Xs,Ys,5));


RMSE_partC(1) = sum(LOOCV_PCR(Yavg,concavg,1));
RMSE_partC(2) = sum(LOOCV_PCR(Yavg,concavg,2));
RMSE_partC(3) = sum(LOOCV_PCR(Yavg,concavg,3));
RMSE_partC(4) = sum(LOOCV_PCR(Yavg,concavg,4));
RMSE_partC(5) = sum(LOOCV_PCR(Yavg,concavg,5));

figure
plot(300:2:650,stda,'*')
figure
plot(1:5,RMSE_partC)


for i=1:1
    A = mean(stdDATA)
end

function [RMSE] = LOOCV_PCR(X,Y,nfact)
%
%  Function for performing leave one sample out cross validation using PCR
%
%  X : N x n matrix of inputs where N is number of samples and n number of
%  variables
%  Y : N x p output vector (assumed to be only one output)
[nsamples nvar] = size(Y);
%
% Estimate OLS regression matrix leaving one sample out in turn 
%
RMSE = zeros(1,nvar);
%
%  Build PCR model dropping each sample out in turn
for i = 1:nsamples
    Xsub = [X(1:i-1,:); X(i+1:end,:)];
    Ysub = [Y(1:i-1,:); Y(i+1:end,:)];
    [u s v] = svd(Xsub,'econ');
    v(:,1:nfact);
    Tsub = Xsub*v(:,1:nfact);
    B = inv(Tsub'*Tsub)*Tsub'*Ysub;
    prederr = Y(i,:) - X(i,:)*v(:,1:nfact)*B;
    RMSE = RMSE + prederr.*prederr;
end
RMSE = sqrt(RMSE/nsamples);
end