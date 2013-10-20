function [ class_rate ] = crossValidation( data_set, control, mode, KorP )
%CROSSVALIDATION Summary of this function goes here
%   Detailed explanation goes here

cnd = qtcCND;
tmp_rate = [];

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
    for i=1:max(indices)
        disp(['Run: ',num2str(i)])
        disp('---------------------------------------------------------------')
        test_set = data_set(indices == i);
        training_set = data_set(indices ~= i);
        
        % data
        hmm=qtcTrainHmm(cnd, training_set);
        res_test=qtcSeqDecode(hmm, test_set);
        res_train=qtcSeqDecode(hmm, training_set);
        
        % control
        res_contr = qtcSeqDecode(hmm, control);
        
        % evaluation
        sample = [res_test.problog]';
        training = [[res_train.problog]'; [res_contr.problog]'];
        group = [ones(length(res_train),1);repmat(2,length(res_contr),1)];
        [class, error]=classify(sample,training,group);
        cr = nnz(class == 1)/length(test_set);
        disp(['classification rate = ',num2str(cr)])
        tmp_rate = [tmp_rate; cr]; 
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
        disp('k = 0.5')
    end
    disp('---------------------------------------------------------------')
    test_set = data_set(Test);
    training_set = data_set(Train);

    % data
    hmm=qtcTrainHmm(cnd, training_set);
    res_test=qtcSeqDecode(hmm, test_set);
    res_train=qtcSeqDecode(hmm, training_set);

    % control
    res_contr = qtcSeqDecode(hmm, control);

    % evaluation
    sample = [res_test.problog]';
    training = [[res_train.problog]'; [res_contr.problog]'];
    group = [ones(length(res_train),1);repmat(2,length(res_contr),1)];
    [class, error]=classify(sample,training,group);
    tmp_rate = nnz(class == 1)/length(test_set);
end

class_rate = mean(tmp_rate);
disp('---------------------------------------------------------------')
disp(['classification rate = ',num2str(class_rate)])

end

