for i=1:1000
    data(i)=sym(i);
end
e=sym(7);
n=sym(5);
tic;
for i=1:1000
    tmp1(i)=mod(data(i)^e,n);
    tmp2(i)=mod((mod(data(i),n))^e,n);
    if(tmp1~=tmp2)
        error('not equal!');
    else
        disp(sprintf('i=%010x,test ok.',i));
    end
end
toc;
