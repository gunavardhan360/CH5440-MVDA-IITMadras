%code by GUNAVARDHAN REDDY (CH18B035)
clc ; clear all ;
load news_posts
%conversion of sparse logic to double
%PART-A
A = double(full(documents));
[U S V] = svd(A'/sqrt(100),'econ');
S = (diag(S*S));
TWO_PC_VARIANCE =  S(1)/sum(S)

%PART-B
%G is used to obtain most repeated words in each article
G = [];
[Fcomp,adj_var,cum_var] = sparsePCA(A(:,1:4605)'/sqrt(100), 18, 1);
i = find(Fcomp);
for j= 1:length(i)
    Fcomp(i(j)) = 1;
end
G = [G Fcomp];
[Frec,adj_var,cum_var] = sparsePCA(A(:,4606:8124)'/sqrt(100), 18, 1);
i = find(Frec);
for j= 1:length(i)
    Frec(i(j)) = 1;
end
G = [G Frec];
[Fsci,adj_var,cum_var] = sparsePCA(A(:,8125:10781)'/sqrt(100), 18, 1);
i = find(Fsci);
for j= 1:length(i)
    Fsci(i(j)) = 1;
end
G = [G Fsci];
[Ftalk,adj_var,cum_var] = sparsePCA(A(:,10782:end)'/sqrt(100), 18, 1);
i = find(Ftalk);
for j= 1:length(i)
    Ftalk(i(j)) = 1;
end
G = [G Ftalk];
%first sparsePC 
[F,adj_var,cum_var] = sparsePCA(A'/sqrt(100), 18, 1);
adj_var;
i = find(F);
for j= 1:length(i)
    F(i(j)) = 1;
end
%norm to calculate the best match
min = norm(F-G(:,1));   
k = 1;
for i= 2:4
    sum = norm(F-G(:,i));
    if(min > sum)
        min = sum;
        k = i;
    end
end
k


%PART-C
%G used to store most repeated words
G = [];
[Fcomp,adj_var,cum_var] = sparsePCA(A(:,1:4605)'/sqrt(100), 17, 1);
i = find(Fcomp);
for j= 1:length(i)
    Fcomp(i(j)) = 1;
end
G = [G Fcomp];
[Frec,adj_var,cum_var] = sparsePCA(A(:,4606:8124)'/sqrt(100), 17, 1);
i = find(Frec);
for j= 1:length(i)
    Frec(i(j)) = 1;
end
G = [G Frec];
[Fsci,adj_var,cum_var] = sparsePCA(A(:,8125:10781)'/sqrt(100), 17, 1);
i = find(Fsci);
for j= 1:length(i)
    Fsci(i(j)) = 1;
end
G = [G Fsci];
[Ftalk,adj_var,cum_var] = sparsePCA(A(:,10782:end)'/sqrt(100), 17, 1);
i = find(Ftalk);
for j= 1:length(i)
    Ftalk(i(j)) = 1;
end
G = [G Ftalk];
%second sparsePC
[F,adj_var,cum_var] = sparsePCA(A'/sqrt(100), 17, 2);
adj_var
cum_var
F = F(:,2);
i = find(F);
for j= 1:length(i)
    F(i(j)) = 1;
end
min = norm(F-G(:,1));
k = 1;
for i= 2:4
    sum = norm(F-G(:,i));
    if(min > sum)
        min = sum;
        k = i;
    end
end
k
