function hmm = qtcCND;
validtr=zeros(81,81);

[c,from]=qtc2case([-1 -1 -1 -1]);

qtc=[];
for i1=1:3
	for i2=1:3
		for i3=1:3
			for i4=1:3
				qtc(end+1,:)=[i1-2 i2-2 i3-2 i4-2];
			end;
		end;
	end;
end;

d=zeros(83,83);
for i1=1:size(qtc,1)
	for i2=1:size(qtc,1)
		d(i1+1,i2+1)=sum(abs(qtc(i1,:)-qtc(i2,:)));
	end;
end;
validtr=double(d==1);

validtr(1,:)=1;
validtr(:,1)=0;
validtr(:,end)=1;
validtr(1,end)=0;
validtr(end,:)=0;

t=validtr./repmat(sum(validtr,2),1,size(validtr,2))
t(end,:)=0;

emmissions=eye(83,83);

hmm.t=t;
hmm.e=emmissions;

