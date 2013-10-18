function [ output_args ] = qtcMarkovDot( hmm, th)
    if nargin<4
        fn='tmp.dot';
    end;
    adj=hmm.t;
    %threshold it
    adj(find(adj<th))=0;
    
    
    stIncl=unique([find(sum(adj)>0)'; find(sum(adj,2)>0)])
    a=adj(stIncl,stIncl);
    
    
    ql=qtcCase2Label(stIncl(2:end-1)-1);
    t={'S' ql{:}, 'E'};
    al=num2cell(a);
    ap=sum(a);
    graph_to_dot(a,'node_label',t,'arc_label',al, 'filename',fn, 'nodewgt',ap);
end

