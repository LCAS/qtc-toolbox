function [ p ] = qtcCrossValidation( data_set1, data_set2, mode, type, KorP )
%QTCCROSSVALIDATION
%   Uses cross validation to evaluate the difference between the given
%   DATA_SET and the CONTROL. Returns classification probabilities.
%
%   P = QTCCROSSVALIDATION(DATA_SET, CONTROL) generates HMM
%   representations of DATA_SET and CONTROL and returns classification
%   rates for DATA_SET using CONTROL as a control. DATA_SET and CONTROL are
%   column matrixes. 
%
%   P = QTCCROSSVALIDATION(..., MODE) Set MODE to 'Kfold' or 'HoldOut'.
%
%   Kfold: Uses KORP for number of iterations. Default KORP = 5. Devides
%   DATA_SET into KORP number of sets and uses each as a test set in a
%   separate test run.
%
%   HoldOut: Uses KORP as the percentage of DATA_SET for the test set.
%   Default KORP = .5. Only runs once.
%
%   P = QTCCROSSVALIDATION(..., TYPE)  TYPE has to be 'qtcb', 'qtcc,' or 
%   'combined' dependign on what you want to do.See below for KORP 
%   description.

if isempty(type)
    cnd = qtcCND('type','qtcc');
end
if isempty(mode)
    mode = 'Kfold';
end

if strcmp(type,'qtcb')
    cnd = qtcCND('type','qtcb');
elseif strcmp(type,'qtcc')
    cnd = qtcCND('type','qtcc');
elseif strcmp(type,'combined')
    cnd = qtcCND('type','combined');
end

if strcmp(mode,'Kfold')
    disp('---------------------------------------------------------------')
    disp('K-fold crossvalidation')
    if nargin > 4
        indices1 = crossvalind(mode, 1:length(data_set1), KorP);
        indices2 = crossvalind(mode, 1:length(data_set2), KorP);
        disp(['k = ',num2str(KorP)])
    else
        indices1 = crossvalind(mode, 1:length(data_set1));
        indices2 = crossvalind(mode, 1:length(data_set2));
        disp('k = 5')
    end
    if max(indices1) ~= max(indices2)
        error('qtc-toolbox:qtcCrossValidation:%s','Amount of training sets is not equal.')
    end
    p = [];
    disp('---------------------------------------------------------------')
    for i=1:max(indices1)
        disp(['Run: ',num2str(i),'/',num2str(max(indices1))])
        disp('---------------------------------------------------------------')
        test_set1 = data_set1(indices1 == i);
        training_set1 = data_set1(indices1 ~= i);
        test_set2 = data_set2(indices2 == i);
        training_set2 = data_set2(indices2 ~= i);
        
        % data
        disp('---------------------------------------------------------------')
        disp('Test set 1:')
        disp('---------------------------------------------------------------')
        hmm1=qtcTrainHmm(cnd, training_set1, type);
        res1=qtcSeqDecode(hmm1, test_set1, type);
        control1=qtcSeqDecode(hmm1, test_set2, type);
        disp('---------------------------------------------------------------')
        disp('Test set 2:')
        disp('---------------------------------------------------------------')
        hmm2=qtcTrainHmm(cnd, training_set2, type);
        res2=qtcSeqDecode(hmm2, test_set2, type);
        control2=qtcSeqDecode(hmm2, test_set1, type);
        
        % results
        result = [[[res1.problog]' [control2.problog]']; ...
           [[res2.problog]' [control1.problog]'] ];
        [m,idx]=max(result');
        p = [p, nnz(idx==1)/length(idx)];
        disp('---------------------------------------------------------------')
    end
elseif strcmp(mode,'HoldOut')
    disp('---------------------------------------------------------------')
    disp('Hold-Out crossvalidation')
    if nargin > 4
        [Train, Test] = crossvalind('HoldOut', length(data_set1), KorP);
        disp(['p = ',num2str(KorP)])
    else
        [Train, Test] = crossvalind('HoldOut', length(data_set1));
        disp('p = 0.5')
    end
    disp('---------------------------------------------------------------')
    test_set1 = data_set1(Test);
    training_set1 = data_set1(Train);

    % data
    hmm_control = qtcTrainHmm(cnd, data_set2, type);
    p = [];
    hmm1=qtcTrainHmm(cnd, training_set1, type);
    res1=qtcSeqDecode(hmm1, test_set1, type);

    % control
    res_control = qtcSeqDecode(hmm_control, test_set1, type);
    result = [[res1.problog]' [res_control.problog]'];
    [m,idx]=max(result');
    p = [p, nnz(idx==1)/length(idx)];
    disp('---------------------------------------------------------------')
end

end

