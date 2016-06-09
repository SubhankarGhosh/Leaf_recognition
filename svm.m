function p=svm(numLabels,dataset,feature)
  resultLabelSet = knnclassify(dataset, dataset, numLabels, 2, 'euclidean');
  numLabels=resultLabelSet;
u=unique(numLabels);
numClasses=length(u);
for k=1:numClasses
    k
    model{k} = svmtrain( dataset,double(numLabels==k));
end

%# get probability estimates of test instances using each model
% prob = zeros(numTest,numLabels); 
for k=1:numClasses
    p(k) = svmclassify(model{k},feature);
%     prob(:,k) = p(:,model{k}.Label==1);    %# probability of class==k
end
p=find(p);
p=min(p);
% %# predict the class with the highest probability
% [~,pred] = max(prob,[],2);
% acc = sum(pred == testLabel) ./ numel(testLabel)    %# accuracy
% C = confusionmat(testLabel, pred)   
end