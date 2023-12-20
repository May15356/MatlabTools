% This function applies to LDPC,QC_LDPC and GLDPC,the rank
% of H matrix is calculated by Hermite transformation
function [Hermite_H,p]=Hermite(GLDPC)
V=GLDPC;
[r,c]=size(V);
j=1;
for i=c:-1:1
    NoneZeroIndex=find(V(j:r,i))+j-1;
    if isempty(NoneZeroIndex)==0
        if V(j,i)==0
            V([j NoneZeroIndex(1)],:)=V([NoneZeroIndex(1) j],:);
        end
        NoneZeroIndex(1)=[];
        for k=1:length(NoneZeroIndex)
            V(NoneZeroIndex(k),:)=mod(V(NoneZeroIndex(k),:)+V(j,:),2);
        end
    NoneZeroIndex=find(V(1:j-1,i));
    for k=1:length(NoneZeroIndex)
        V(NoneZeroIndex(k),:)=mod(V(NoneZeroIndex(k),:)+V(j,:),2);
    end
    j=j+1;
    end
end
V(sum(V,2)==0,:)=[];
r=size(V,1);
p=fliplr(find(sum(V)==1));
Hermite_H=V;
if length(p)==r
    Hermite_H(:,p)=zeros(r);
else
    p=zeros(1,r);
    for i=1:r
        a=find(Hermite_H(i,:)==1);
        p(i)=a(length(a));
    end
    Hermite_H(:,p)=zeros(r);
end
end