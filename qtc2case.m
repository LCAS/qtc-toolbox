function [c,n]=qtc2case(qtc);
mult=[27 9 3 1];
coded=(qtc+1).*repmat(mult,size(qtc,1),1);
n=(sum(coded,2))'+1;
c=char(n+32);