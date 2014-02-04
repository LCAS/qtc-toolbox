function [ output_args ] = qtcMarkovDot( hmm, th, type, name)
    if nargin<4
        fn='tmp.dot';
    else
        fn=name;
    end;
    adj=hmm.t;
    %threshold it
    
    adj(find(adj<th))=0;
    ix=find(sum(adj(:,2:end))<th);
    adj(ix+1,:)=0;
    
    stIncl=unique([1; intersect(find(sum(adj)>th)', find(sum(adj,2)>th))], 'stable');
    %stIncl=unique([1 find(sum(adj,1)>th)]);
    
    a=adj(stIncl,stIncl);
    %[ri,ci]=find(a<th);
    %a(ri,ci)=0;
    
    ql=qtcCase2Label(stIncl-1, type);
    t={'S' ql{2:end-1} 'E'};
    al=num2cell(a);
    ap=sum(a);
    graph_to_dot(a,'node_label',t,'arc_label',al, 'filename',fn, 'nodewgt',ap);
end

