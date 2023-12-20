function H=Hbase_H(Hbase,z)
[r,c]=size(Hbase);
H=zeros(r*z,c*z);
for i=1:r
    for j=1:c
        if Hbase(i,j)==-1
            H((i-1)*z+1:i*z,(j-1)*z+1:j*z)=zeros(z);
        else
            H((i-1)*z+1:i*z,(j-1)*z+1:j*z)=circshift(eye(z),[0 Hbase(i,j)]);
        end
    end
end
end