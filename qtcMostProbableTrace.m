function [tr,p]=qtcMostProbableTrace(ct)

s=1;
tr=1;
[m,i]=max(ct');
p=m(1);

while(s~=size(ct,1))
    s=i(s)+1;
    tr=[tr s];
    p=p*m(s);
end;
