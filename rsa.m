set(0,'RecursionLimit',10000);
clear all;
clc;
%-----------------------------------------------------
%初始化生成1000以内的质数
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
%随机找出一个大的质数p
while(1)
  i=rand()*(index-1);
  if i>10
      break;
  end
end
%---------------------------------------------------
%随机找出一个大的质数q,且p！=q
while(1)
    j=rand()*(index-1);
    if j>10 && round(j+1)~=round(i+1)
        break;
    end
end  
p=zs(round(i+1));%查表获得质数
q=zs(round(j+1));%查表获得质数
%-----------------------------------------------------
%计算n
n=p*q;
%计算（p-1）*（q-1）----------------------------------
r=(p-1)*(q-1);
%----------------------------------------------------
%随机取一个e，满足1<e<r,且e与r互质
%这里取的是质数，只要r不是e的倍数就满足条件。
while(1)
  
    e=zs(round(rand()*(index-1))+1);%这里找出的e是质数
    if(mod(r,e)~=0)    %只要r不是e的倍数就满足条件
        break;
    end
end
%---------------------------------------
%利用扩张欧几里得算法求取e关于r的模反元素d
if(mod(r,e)~=0)
    [d_,d]=(e_gcd(e,r));
end
%--------------------------------------
%得到公钥
disp(sprintf('public key={n,e}={0x%x,0x%x} for encryption ',n,e));
%------------------------------------------------
%得到私钥
disp(sprintf('private key={n,d}={0x%x,0x%x} for decryption',n,d));
disp('before encrypt,the info is:');
%-----------------------------------------
%待加密的信息
info='hello,i am koala.';
disp(info);
%----------------------------------------
%获得字符串长度
[row,col]=size(info);

for k=1:col
    en_info(k)=sym(uint8(info(k)));
end
disp(en_info);

%数据采用公钥进行加密--------------------
tic;%加密计时器开始
for k=1:col
    %tmp(k)=sym(mod(en_info(k)^e,n));
    tmp(k)=rsa_cal(info(k),e,n);
end
disp('after encrypted,the info is:');
str=sym(tmp);
disp(str);  
toc;%加密计时器结束
%数据采用私钥解密------------------------
tic;%解密计时器开始
for k=1:col 
    %den_info(k)=mod(tmp(k)^d,n);
    den_info(k)=rsa_cal(tmp(k),d,n);
end
%有符号数字转换成字符--------------------
for k=1:col 
    den_info_c(k)=uint8(den_info(k));
end
disp('after decrypted,the info is:');
disp(sprintf('%s',den_info_c));
str=sym(den_info);
disp(str);
toc;%解密计时器结束
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






















