function y = abmodn(a,b,n)
%abmodn Summary of this function goes here
%   Detailed explanation goes here
p=a;
m=0;
for j=1:64
    t=bitget(b,j);
    if(t==1)
        m=mod((m+p),n);
    end
    p=mod(2*p,n);
end
y=m;
end