qtc-toolbox
===========

*A toolbox for QTC_c computations*

# QTC representation

 * A QTC_c sequence is represented as a matrix 
     * with 4 columns indicating QTC elements `(human-dist, robot-dist, human-side, robot-side)`
	 * with as many rows as the sequence has states
	 * two successively occurring same states are collapse into one
 * a set of QTC_c sequences is represented as a one-dimensional cell array of QTC sequences
 * `qtc2case` converts a given QTC sequence matrix into a one-dimensional stream of case identifiers (numbered 1-49)
 * `qtcTransProb` computes the transition probabilities of a set of QTC sequences to form a Markov model with added start and end states
 * `qtcDist` computes the QTC edit distance between either all pairs in a set (when invoked with one arg) or two explicitly given sequences
 * `qtcMostProbableTrace` takes the output of `qtcTransProb` and computes the a-priori most probable trace


to then generate a graph using GraphViz, use something like this

```
	[ct,labels]=qtcTransProb(qtcc(6:end));
	adj=zeros(size(ct)+1);
	adj(1:end-1,2:end)=ct;
	l=labels(:,1);
	l{end+1}='E';
	al=num2cell(adj);
	graph_to_dot(adj,'node_label',l,'arc_label',al)
	! dot -Tps tmp.dot > out.ps
	! open out.ps
```
