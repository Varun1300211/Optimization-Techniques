clc
clear all
% a: supply
% b: demand
% c: cost matrix
%c=[3 11 4 14 15;6 16 18 2 28;10 13 15 19 17;7 12 5 8 9];
% c=[2 3 11 7;1 0 6 1;5 8 15 9];
%  c=[2 10 4 5; 6 12 8 11;3 9 5 7];
cost=[6 4 1 5;8 9 2 7;4 3 6 4];
A=[14 16 5];
B=[6 10 15 4];
m=size(cost,1);
n=size(cost,2);
% a=[15 25 10 15];
% b=[20 10 15 15 5];
% a=[6 1 10];
% b=[7 5 3 2];
% a=[12 25 20];
% b=[25 10 15 5];
z=0;
if sum(A)==sum(B)
    fprintf('Given transportation problem is Balanced \n');
else
     fprintf('Given transportation problem is Unbalanced \n');
     if sum(A)<sum(B)
         cost(end+1,:)=zeros(1,size(A,2));
         A(end+1)=sum(B)-sum(A);
     else
         cost(:,end+1)=zeros(1,size(A,1));
         B(end+1)=sum(A)-sum(B);
     end
end
X=zeros(m,n);
InitialC=cost;
   for i=1:size(cost,1)
       for j=1:size(cost,2)
    cpq=min(cost(:));
    if cpq==Inf
    break
       end
[p1,q1]=find(cpq==cost)
xpq=min(A(p1),B(q1))
[X(p1,q1),ind]=max(xpq)
p=p1(ind)
q=q1(ind)
X(p,q)=min(A(p),B(q))
if min(A(p),B(q))==A(p)
B(q)=B(q)-A(p)
A(p)=A(p)-X(p,q)
cost(p,:)=Inf;
else
    A(p)=A(p)-B(q);
    B(q)=B(q)-X(p,q);
    cost(:,q)=Inf;
end
       end
   end
for i=1:size(cost,1)
    for j=1:size(cost,2)
z=z+InitialC(i,j)*X(i,j);
    end
end
%fprintf('Initial BFS \n')
array2table(X)
fprintf('Transportation cost is %f \n',z);