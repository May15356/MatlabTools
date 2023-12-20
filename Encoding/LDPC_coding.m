% This function applies to LDPC,QC_LDPC and GLDPC coding
% H is parity-check matrix, code_num is number of codes
% ��������������κ���֪У�����H�ı��룬code_num������Ҫ�������ֵ�
% �����������code��code_num�������������ɵľ���info_bit��ÿһ��
% ���ֵ���Ϣ���أ�info_bit_place����Щ���ֵ���Ϣ����λ��
function [code,info_bit,info_bit_place]=LDPC_coding(H,code_num)
L=size(H,2);
[Hermite_H,p]=Hermite(H);
code=double(rand(code_num,L)>0.5);
code(:,p)=mod(code*Hermite_H',2);
info_bit_place=1:L;
info_bit_place(p)=[];
info_L=length(info_bit_place);
info_bit=code(:,info_bit_place);
% fid=fopen('LDPC_coding.txt','w');
% fprintf(fid,'%d %d\r\n',info_L,L);
% for i=1:info_L
%     fprintf(fid,'%d ',info_bit_place(i));
% end
% fprintf(fid,'\r\n');
% for i=1:code_num
%     for j=1:info_L
%         fprintf(fid,'%d ',info_bit(i,j));
%     end
%     fprintf(fid,'\r\n');
% end
% for i=1:code_num
%     for j=1:L
%         fprintf(fid,'%d ',code(i,j));
%     end
%     fprintf(fid,'\r\n');
% end
% fclose(fid);