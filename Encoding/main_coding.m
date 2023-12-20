function main_coding(HbaseName) %eg. PLDPC_coding("Hbase0025.mat");
Hbase=importdata(HbaseName);
    z=max(max(Hbase))+1;
    [r,c]=size(Hbase);
    subr=c-r;
    subc=2*(c-r);
    subHbase=Hbase(1:subr,1:subc);
    subH=Hbase_H(subHbase,z);
    [subcode,~,~]=LDPC_coding(subH,1);  %1代表生成一个码字
    parity=zeros(1,(r-subr)*z);
    count=1;
    for i=subr+1:r
        list=find(Hbase(i,1:subc)>-1);
        sigma=Hbase(i,list);
        for j=1:z
            place=mod(sigma+j-1,z)+1+(list-1)*z;
            parity(count)=mod(sum(subcode(place)),2);
            count=count+1;
        end
    end
    code=[subcode parity];
    txtName=strcat('codeFile\',datestr(now,29) ,HbaseName, 'code','.txt');%写入文件路径
    fid=fopen(txtName,'wt');
    [m,n]=size(code);
    for i=1:1:m
        for j=1:1:n
            if j==n
            fprintf(fid,'%g\n',code(i,j));
            else
            fprintf(fid,'%g\t',code(i,j));
            end
        end
    end
    fclose(fid);
end
