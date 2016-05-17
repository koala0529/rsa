set(0,'RecursionLimit',10000);
clear all;
clc;
%-----------------------------------------------------
%��ʼ������1000���ڵ�����
index=4;
zs(1)=2;
zs(2)=3;
zs(3)=5;
zs(4)=7;
%uint64 i;
tic;
for i=9:2:100
    %t=uint64(i);
    %t=uint64(sqrt(i));
   for j=1:index
       p=mod(i,zs(j)); %===i%j
       if p==0
           break;
       elseif j==index
            index=index+1;
            zs(index)=i;  
        end
   end
end
toc;
%---------------------------------------------------
%����ҳ�һ���������p
while(1)
  i=rand()*(index-1);
  if i>10
      break;
  end
end
%---------------------------------------------------
%����ҳ�һ���������q,��p��=q
while(1)
    j=rand()*(index-1);
    if j>10 && round(j+1)~=round(i+1)
        break;
    end
end  
p=zs(round(i+1));%���������
q=zs(round(j+1));%���������
%-----------------------------------------------------
%����n
n=p*q;
%���㣨p-1��*��q-1��----------------------------------
r=(p-1)*(q-1);
%----------------------------------------------------
%���ȡһ��e������1<e<r,��e��r����
%����ȡ����������ֻҪr����e�ı���������������
while(1)
  
    e=zs(round(rand()*(index-1))+1);%�����ҳ���e������
    if(mod(r,e)~=0)    %ֻҪr����e�ı�������������
        break;
    end
end
%---------------------------------------
%��������ŷ������㷨��ȡe����r��ģ��Ԫ��d
if(mod(r,e)~=0)
    [d_,d]=(e_gcd(e,r));
end
%--------------------------------------
%�õ���Կ
disp(sprintf('public key={n,e}={0x%x,0x%x} for encryption ',n,e));
%------------------------------------------------
%�õ�˽Կ
disp(sprintf('private key={n,d}={0x%x,0x%x} for decryption',n,d));
disp('before encrypt,the info is:');
%-----------------------------------------
%�����ܵ���Ϣ
info='hello,i am koala.';
disp(info);
%----------------------------------------
%����ַ�������
[row,col]=size(info);

for k=1:col
    en_info(k)=sym(uint8(info(k)));
end
disp(en_info);

%���ݲ��ù�Կ���м���--------------------
tic;%���ܼ�ʱ����ʼ
for k=1:col
    %tmp(k)=sym(mod(en_info(k)^e,n));
    tmp(k)=rsa_cal(info(k),e,n);
end
disp('after encrypted,the info is:');
str=sym(tmp);
disp(str);  
toc;%���ܼ�ʱ������
%���ݲ���˽Կ����------------------------
tic;%���ܼ�ʱ����ʼ
for k=1:col 
    %den_info(k)=mod(tmp(k)^d,n);
    den_info(k)=rsa_cal(tmp(k),d,n);
end
%�з�������ת�����ַ�--------------------
for k=1:col 
    den_info_c(k)=uint8(den_info(k));
end
disp('after decrypted,the info is:');
disp(sprintf('%s',den_info_c));
str=sym(den_info);
disp(str);
toc;%���ܼ�ʱ������
%--------------------------------------
%clear var
clear str;
clear j;
clear k;
%clear index;
clear row;
clear tmp;
%clear zs;
clear info;
clear col;
clear i;
clear den_info;
clear den_info_c;
clear en_info;






















