function hmm = qtcCND;
% validtr=zeros(81,81);

% [c,from]=qtc2case([-1 -1 -1 -1]);

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

validqtc=[];

d=zeros(83,83);
for i1=1:size(qtc,1)
	for i2=1:size(qtc,1)
		d(i1+1,i2+1)=max(abs(qtc(i1,:)-qtc(i2,:)));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % e.g. -0 to 0-        
        if d(i1+1,i2+1)==1
            if sum(abs(qtc(i1,1:2)))==1 & sum(abs(qtc(i2,1:2)))==1
                if max(abs(qtc(i1,1:2)-qtc(i2,1:2))) > 0 & sum(qtc(i1,1:2)-qtc(i2,1:2))==0
                    d(i1+1,i2+1)=2;
                end
            end
        end
        if d(i1+1,i2+1)==1
            if sum(abs(qtc(i1,3:4)))==1 & sum(abs(qtc(i2,3:4)))==1
                if max(abs(qtc(i1,3:4)-qtc(i2,3:4))) > 0 & sum(qtc(i1,3:4)-qtc(i2,3:4))==0
                    d(i1+1,i2+1)=2;
                end
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % e.g. -0 to 0+
        if d(i1+1,i2+1)==1
            if sum(abs(qtc(i1,1:2)))==1 & sum(abs(qtc(i2,1:2)))==1
                if max(abs(qtc(i1,1:2)-qtc(i2,1:2))) > 0 & abs(sum(qtc(i1,1:2)-qtc(i2,1:2)))==2
                    d(i1+1,i2+1)=2;
                end
            end
        end
        if d(i1+1,i2+1)==1
            if sum(abs(qtc(i1,3:4)))==1 & sum(abs(qtc(i2,3:4)))==1
                if max(abs(qtc(i1,3:4)-qtc(i2,3:4))) > 0 & abs(sum(qtc(i1,3:4)-qtc(i2,3:4)))==2
                    d(i1+1,i2+1)=2;
                end
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % e.g. ++0+ to 0+++
        if d(i1+1,i2+1)==1
            if sum(abs(qtc(i1,[1,3])))==1 & sum(abs(qtc(i2,[1,3])))==1
                if max(abs(qtc(i1,[1,3])-qtc(i2,[1,3]))) > 0 & sum(qtc(i1,[1,3])-qtc(i2,[1,3]))==0
                    d(i1+1,i2+1)=2;
                end
            end
        end
        if d(i1+1,i2+1)==1
            if sum(abs(qtc(i1,[2,4])))==1 & sum(abs(qtc(i2,[2,4])))==1
                if max(abs(qtc(i1,[2,4])-qtc(i2,[2,4]))) > 0 & sum(qtc(i1,[2,4])-qtc(i2,[2,4]))==0
                    d(i1+1,i2+1)=2;
                end
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % e.g. ++0+ to 0+-+
        if d(i1+1,i2+1)==1
            if sum(abs(qtc(i1,[1,3])))==1 & sum(abs(qtc(i2,[1,3])))==1
                if max(abs(qtc(i1,[1,3])-qtc(i2,[1,3]))) > 0 & abs(sum(qtc(i1,[1,3])-qtc(i2,[1,3])))==2
                    d(i1+1,i2+1)=2;
                end
            end
        end
        if d(i1+1,i2+1)==1
            if sum(abs(qtc(i1,[2,4])))==1 & sum(abs(qtc(i2,[2,4])))==1
                if max(abs(qtc(i1,[2,4])-qtc(i2,[2,4]))) > 0 & abs(sum(qtc(i1,[2,4])-qtc(i2,[2,4])))==2
                    d(i1+1,i2+1)=2;
                end
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % e.g. 00-0 to 0-00
        if d(i1+1,i2+1)==1
            if sum(abs(qtc(i1,[2,3])))==1 & sum(abs(qtc(i2,[2,3])))==1
                if max(abs(qtc(i1,[2,3])-qtc(i2,[2,3]))) > 0 & sum(qtc(i1,[2,3])-qtc(i2,[2,3]))==0
                    d(i1+1,i2+1)=2;
                end
            end
        end
        if d(i1+1,i2+1)==1
            if sum(abs(qtc(i1,[1,4])))==1 & sum(abs(qtc(i2,[1,4])))==1
                if max(abs(qtc(i1,[1,4])-qtc(i2,[1,4]))) > 0 & sum(qtc(i1,[1,4])-qtc(i2,[1,4]))==0
                    d(i1+1,i2+1)=2;
                end
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % e.g. 00+0 to 0-00
        if d(i1+1,i2+1)==1
            if sum(abs(qtc(i1,[2,3])))==1 & sum(abs(qtc(i2,[2,3])))==1
                if max(abs(qtc(i1,[2,3])-qtc(i2,[2,3]))) > 0 & abs(sum(qtc(i1,[2,3])-qtc(i2,[2,3])))==2
                    d(i1+1,i2+1)=2;
                end
            end
        end
        if d(i1+1,i2+1)==1
            if sum(abs(qtc(i1,[1,4])))==1 & sum(abs(qtc(i2,[1,4])))==1
                if max(abs(qtc(i1,[1,4])-qtc(i2,[1,4]))) > 0 & abs(sum(qtc(i1,[1,4])-qtc(i2,[1,4])))==2
                    d(i1+1,i2+1)=2;
                end
            end
        end
        if d(i1+1,i2+1)==1
            validqtc(end+1,:)=[qtc(i1,:), 9 ,qtc(i2,:)];
        end
	end;
end;
validtr=double(d==1);

validtr(1,:)=1;
validtr(:,1)=0;
validtr(:,end)=1;
validtr(1,end)=0;
validtr(end,:)=0;

validtr=validtr+eye(83,83)*0.00001;
validtr(1,1)=0;
t=validtr./repmat(sum(validtr,2),1,size(validtr,2));

%emmissions=ones(83,83)*(0.001/82)+eye(83,83)*0.999;
emmissions=eye(83,83);

emmissions(1,2:end)=0;
%emmissions(end,1:end-1)=0.0001;
emmissions=emmissions./repmat(sum(emmissions,2),1,size(emmissions,2));

hmm.t=t;
hmm.e=emmissions;
hmm.q = validqtc;

