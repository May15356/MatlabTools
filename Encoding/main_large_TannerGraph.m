function main_large_TannerGraph(HbaseName)  %eg. HbaseName="Hbase0025.mat"
Hbase=importdata(HbaseName);
z=max(max(Hbase))+1; % zÎªCPM³ß´ç
[r,c]=size(Hbase);
Hb=double(Hbase~=-ones(r,c));
dv_max=max(sum(Hb,1));
dc_max=max(sum(Hb,2));
dv=zeros(1,c*z);
dc=zeros(1,r*z);
for j=1:c
    dv((j-1)*z+1:j*z)=sum(Hb(:,j));
end
for i=1:r
    dc((i-1)*z+1:i*z)=sum(Hb(i,:));
end

CN=zeros(r*z,dc_max);
VN=zeros(c*z,dv_max);
for j=1:c
    j1=(j-1)*z+1;
    j2=j*z;
    NZ_col=find(Hb(:,j));
    for i=1:r
        i1=(i-1)*z+1;
        i2=i*z;
        NZ_row=find(Hb(i,:));
        if Hb(i,j)==1
            cn_index=find(NZ_col==i);
            vn_index=find(NZ_row==j);
            sigma=Hbase(i,j);
            VN(j1:j2,cn_index)=circshift(i1:i2,[0 sigma]);
            CN(i1:i2,vn_index)=circshift(j1:j2,[0 -sigma]);
        end
    end
end

%% write into txt
txtName=strcat('codeFile\',datestr(now,29) ,HbaseName, 'Tanner.txt');
fid=fopen(txtName,'w');
fprintf(fid,'%d %d\r\n',c*z,r*z);
fprintf(fid,'%d %d\r\n',dv_max,dc_max);
for j=1:c*z
    fprintf(fid,'%d ',dv(j));
end
fprintf(fid,'\r\n');
for i=1:r*z
    fprintf(fid,'%d ',dc(i));
end
fprintf(fid,'\r\n');
for j=1:c*z
    for k=1:dv(j)
        fprintf(fid,'%d ',VN(j,k));
    end
    fprintf(fid,'\r\n');
end
for i=1:r*z
    for k=1:dc(i)
        fprintf(fid,'%d ',CN(i,k));
    end
    fprintf(fid,'\r\n');
end
fclose('all');
end
