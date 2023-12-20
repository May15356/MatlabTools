% This function applies to LDPC,QC_LDPC and GLDPC coding
% H is parity-check matrix, code_num is number of codes
% 这个程序适用于任何已知校验矩阵H的编码，code_num代表需要编码码字的
% 数量，输出的code是code_num个编码后码字组成的矩阵，info_bit是每一个
% 码字的信息比特，info_bit_place是这些码字的信息比特位置
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