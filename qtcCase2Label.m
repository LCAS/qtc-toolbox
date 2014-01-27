function label=qtcCase2Label(c, type)

if nargin < 2
    multi = 4;
elseif strcmp(type, 'qtcc')
    multi = 4;
elseif strcmp(type, 'qtcb')
    multi = 2;
elseif strcmp(type, 'combined')
    for k=1:length(c)
        if c(k) <= 9
            label(k,:) = qtcCase2Label(c(k), 'qtcb');
        else
            label(k,:) = qtcCase2Label(c(k)-9, 'qtcc');
        end
    end
    return;
end
        

for k=1:length(c)
    q=3.^((multi-1):-1:0);

    rc=c(k)-1;

    f=floor(rc(1)/q(1));
    r=rem(rc(1),q(1));

    for i=2:length(q)
        rc(i)=rc(i-1)-f(i-1)*q(i-1);
        f(i)=floor(rc(i)/q(i));
        r(i)=rem(rc(i),q(i));
    end;
    qtc(k,:)=f-1;
   
end
label=qtcNum2Str(qtc);





