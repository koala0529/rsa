function e = rsa_cal(a,b,n )
%rsa_cal Summary of this function goes here
%   Detailed explanation goes here
e=1;
%sym i;
for i=64:-1:1
    tmp=bitget(b,i);
    if(tmp==1)
         %e=mod(a*e,n);
         e=abmodn(a,e,n);
    end
    if(i~=1)
        %e=mod(e*e,n);
        e=abmodn(e,e,n);
    end
end
