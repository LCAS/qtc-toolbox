qtc-toolbox
===========

*A toolbox for QTC_c computations*

# QTC representation

 * A QTC_c sequence is represented as a matrix 
     * with 4 columns indicating QTC elements `(human-dist, robot-dist, human-side, robot-side)`
	 * with as many rows as the sequence has states
	 * two successively occurring same states should be collapsed into one
 * a set of QTC_c sequences is represented as a one-dimensional cell array of QTC sequences

# Existing functions 

 * `qtc2case` converts a given QTC sequence matrix into a one-dimensional stream of case identifiers (numbered 1-49)
 * `qtc2hmm` computes the transition probabilities of a set of QTC sequences to form a Markov model with added start and end states. Uses the standard Matlab HMM functions. 
 * `qtcDist` computes the QTC edit distance between either all pairs in a set (when invoked with one arg) or two explicitly given sequences
 * `qtcMarkovDot` create a visualisation in GraphViz of the transition probablilities
 * `qtcSeqDecode` can compute the likelihood of a given sequence allowing for automatic classification

Some useful case:

*plot*

```
% create without pseudo state transitions (useful for plotting)
hmm=qtc2hmm(overtake_ns,0.0)
qtcMarkovDot(hmm)
! dot -Tps tmp.dot > out.ps

```

*classifiy*

```
% create with pseudo transitions
hmm=qtc2hmm(overtake_ns)
% compute the likelihood for a given sequnce:
qtcSeqDecode(hmm,overtake_s{4})
```
