function [ p ] = qtcCrossValidation( data_set, control, mode, KorP )
%QTCCROSSVALIDATION
%   Uses cross validation to evaluate the difference between the given
%   DATA_SET and the CONTROL. Returns classification probabilities.
%
%   P = QTCCROSSVALIDATION(DATA_SET, CONTROL, MODE, KORP) generates HMM
%   representations of DATA_SET and CONTROL and returns classification
%   rates for DATA_SET using CONTROL as a control. DATA_SET and CONTROL are
%   column matrixes. Set MODE to 'Kfold' or 'HoldOut'. See below for KORP
%   description.
%
%   Kfold: Uses KORP for number of iterations. Default KORP = 5. Devides
%   DATA_SET into KORP number of sets and uses each as a test set in a
%   separate test run.
%
%   HoldOut: Uses KORP as the percentage of DATA_SET for the test set.
%   Default KORP = .5. Only runs once.

if size(data_set,2) == 2
    cnd = qtcCND('type','qtcb');
elseif size(data_set,2) == 4
    cnd = qtcCND('type','qtcc');
end

if strcmp(mode,'Kfold')
    disp('---------------------------------------------------------------')
    disp('K-fold crossvalidation')
    if nargin > 3
        indices = crossvalind(mode, 1:length(data_set), KorP);
        disp(['k = ',num2str(KorP)])
    else
        indices = crossvalind(mode, 1:length(data_set));
        disp('k = 5')
    end
    disp('---------------------------------------------------------------')
    hmm_control = qtcTrainHmm(cnd, control);
    p = [];
    for i=1:max(indices)
        disp(['Run: ',num2str(i)])
        disp('---------------------------------------------------------------')
        test_set = data_set(indices == i);
        training_set = data_set(indices ~= i);
        
        % data
        hmm_test=qtcTrainHmm(cnd, training_set);
        res_test=qtcSeqDecode(hmm_test, test_set);
        
        % control
        res_control = qtcSeqDecode(hmm_control, test_set);
        result = [[res_test.problog]' [res_control.problog]'];
        [m,idx]=max(result');
        p = [p, nnz(idx==1)/length(idx)];
        disp('---------------------------------------------------------------')
    end
elseif strcmp(mode,'HoldOut')
    disp('---------------------------------------------------------------')
    disp('Hold-Out crossvalidation')
    if nargin > 3
        [Train, Test] = crossvalind('HoldOut', length(data_set), KorP);
        disp(['p = ',num2str(KorP)])
    else
        [Train, Test] = crossvalind('HoldOut', length(data_set));
        disp('p = 0.5')
    end
    disp('---------------------------------------------------------------')
    test_set = data_set(Test);
    training_set = data_set(Train);

    % data
    hmm_control = qtcTrainHmm(cnd, control);
    p = [];
    hmm_test=qtcTrainHmm(cnd, training_set);
    res_test=qtcSeqDecode(hmm_test, test_set);

    % control
    res_control = qtcSeqDecode(hmm_control, test_set);
    result = [[res_test.problog]' [res_control.problog]'];
    [m,idx]=max(result');
    p = [p, nnz(idx==1)/length(idx)];
    disp('---------------------------------------------------------------')
end

end

