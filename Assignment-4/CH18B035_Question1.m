%code by GUNAVARDHAN REDDY (CH18B035)
clc ; clear all ;
load 'inorfull'
PURE = [PureCo;PureCr;PureNi];

%PART A first samples only
dataA = DATA(1:5:end, :);
[x,y] = find(dataA<0);

[U S V] = svds(dataA);
WinitA = abs(U(:,1:3)*S(1:3,1:3));
HinitA = abs(V(:,1:3)');

for i=1:length(x)
    dataA(x(i),y(i)) = 0;
end

[WA,HA] = nmf(dataA,WinitA,HinitA,.000001,1000,1000000);
corr(HA',PURE')

%PART B Average samples
dataB = []
for i=1:26
    istart = 5*(i-1)+1;
    iend = istart+4;
    avg = mean(DATA(istart:iend,:),1);
    dataB = [dataB; avg];
end

[x,y] = find(dataB<0);

for i=1:length(x)
    dataB(x(i),y(i)) = 0;
end

[U S V] = svds(dataB);
WinitB = abs(U(:,1:3)*S(1:3,1:3));
HinitB = abs(V(:,1:3)');

[WB,HB] = nmf(dataB,WinitB,HinitB,.000001,1000,10000);
corr(HB',PURE')


function [W,H] = nmf(V,Winit,Hinit,tol,timelimit,maxiter)

% NMF by alternative non-negative least squares using projected gradients
% Author: Chih-Jen Lin, National Taiwan University

% W,H: output solution
% Winit,Hinit: initial solution
% tol: tolerance for a relative stopping condition
% timelimit, maxiter: limit of time and iterations

W = Winit; H = Hinit; initt = cputime;

gradW = W*(H*H') - V*H'; gradH = (W'*W)*H - W'*V;
initgrad = norm([gradW; gradH'],'fro');
fprintf('Init gradient norm %f\n', initgrad); 
tolW = max(0.001,tol)*initgrad; tolH = tolW;

for iter=1:maxiter,
  % stopping condition
  projnorm = norm([gradW(gradW<0 | W>0); gradH(gradH<0 | H>0)]);
  if projnorm < tol*initgrad | cputime-initt > timelimit,
    break;
  end
  
  [W,gradW,iterW] = nlssubprob(V',H',W',tolW,1000); W = W'; gradW = gradW';
  if iterW==1,
    tolW = 0.1 * tolW;
  end

  [H,gradH,iterH] = nlssubprob(V,W,H,tolH,1000);
  if iterH==1,
    tolH = 0.1 * tolH; 
  end

  if rem(iter,10)==0, fprintf('.'); end
end
fprintf('\nIter = %d Final proj-grad norm %f\n', iter, projnorm);
end

function [H,grad,iter] = nlssubprob(V,W,Hinit,tol,maxiter)

% H, grad: output solution and gradient
% iter: #iterations used
% V, W: constant matrices
% Hinit: initial solution
% tol: stopping tolerance
% maxiter: limit of iterations

H = Hinit; WtV = W'*V; WtW = W'*W; 

alpha = 1; beta = 0.1;
for iter=1:maxiter,  
  grad = WtW*H - WtV;
  projgrad = norm(grad(grad < 0 | H >0));
  if projgrad < tol,
    break
  end

  % search step size 
  for inner_iter=1:20,
    Hn = max(H - alpha*grad, 0); d = Hn-H;
    gradd=sum(sum(grad.*d)); dQd = sum(sum((WtW*d).*d));
    suff_decr = 0.99*gradd + 0.5*dQd < 0;
    if inner_iter==1,
      decr_alpha = ~suff_decr; Hp = H;
    end
    if decr_alpha, 
      if suff_decr,
	H = Hn; break;
      else
	alpha = alpha * beta;
      end
    else
      if ~suff_decr | Hp == Hn,
	H = Hp; break;
      else
	alpha = alpha/beta; Hp = Hn;
      end
    end
  end
end

if iter==maxiter,
  fprintf('Max iter in nlssubprob\n');
end
end