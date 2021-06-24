%code by GUNAVARDHAN REDDY (CH18B035)
clc ; clear all ;
%reading the data
A = readtable('ghg-concentrations_1984-2014.xlsx');
T = table2array(A);
z = T(1:31,2:5);

%OLS after autoscaling
y1 = T(1:31,7:7);
y = y1 - mean(y1);
y = y./std(y);
zs = z - mean(z);
zs = zs./std(zs);
stdaols = inv(zs'*zs)*zs'*y

%OLS without autoscaling
y1 = T(1:31,7:7);
y = y1 - mean(y1);
zs = z - mean(z);
aols = inv(zs'*zs)*zs'*y

%TLS with autoscaling
Z = [T(1:31,2:5) T(1:31,7:7)];
Z = Z - mean(Z);
Z = Z./std(Z);
[U S V] = svd(Z);
loweig = V(1:5,5:5);
stdatls = loweig/loweig(5)

%TLS without autoscaling
Z = [T(1:31,2:5) T(1:31,7:7)];
Z = Z - mean(Z);
[U S V] = svd(Z);
loweig = V(1:5,5:5);
atls = loweig/loweig(5)