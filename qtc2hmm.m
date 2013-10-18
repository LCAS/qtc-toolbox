function [ hmm ] = qtc2hmm( qtcc, pseudoT )

if nargin<2
    pseudoT=0.00001;
end;
pseudoE=0.1;

dimension=size(qtcc{1},2);
s=3^dimension;

trans=zeros(s+2,s+2);
e=eye(s+2,s+2);
hmm.t=trans;

for (i=1:length(qtcc))
    [dummy,n]=qtc2case(qtcc{i});
    extSeq=[1 n+1 s+2];
    [estimateTR, estimateE] = hmmestimate(extSeq,extSeq,'Pseudotransitions',ones(s+2,s+2)*pseudoT,'Pseudoemissions',ones(s+2,s+2)*pseudoT);
    trans=trans+estimateTR;
    e=e+estimateE;
end;
%     c=c+length(n);
% 
%     
%     p(n(1))=p(n(1))+1;
%     tpi(n(1))=tpi(n(1))+1;
%     for j=2:length(n)
%         p(n(j))=p(n(j))+1;
%         trans(n(j-1),n(j))=trans(n(j-1),n(j))+1;
%     end;
% end;
% p=p./sum(p);
% tpi=tpi./repmat(sum(tpi,2),1,81)
% trans=trans./repmat(sum(trans,2),1,81);
% hmm.t(2:s+1,2:s+1)=trans;
% hmm.t(1:s+1,1)=0;

st=sum(trans,2);
nni=find(st>0);

hmm.t(nni,:)=trans(nni,:)./repmat(st(nni),1,s+2);
hmm.e=e;

% end

