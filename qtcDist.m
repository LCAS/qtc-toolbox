function d=qtcDist(qtc1,qtc2);
if (nargin<2 && iscell(qtc1))
    n=length(qtc1);
    d=zeros(1,n*(n-1)/2);
    k=0;
    for (i=1:n)
        for (j=i+1:n)
            k=k+1;
            d(k)=qtcDist(qtc1{i},qtc1{j});
        end;
    end;
else;
s1=qtc2case(qtc1);
s2=qtc2case(qtc2);
d=EditDist(s1,s2);
end;