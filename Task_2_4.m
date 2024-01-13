% Load the Iris dataset
load('fisheriris.mat');
data = meas;
% Convert species to numerical labels
[~, ~, numericSpecies] = unique(species);

% Shuffle and split the dataset
c = cvpartition(length(numericSpecies), 'Holdout', 0.40);
trainData = data(training(c), :);
testData = data(test(c), :);
trainTargets = numericSpecies(training(c));
testTargets = numericSpecies(test(c));

% Define K values
K_values = [5, 7];

% Iterate over K values
for K = K_values
    % Create and train KNN model
    Mdl = fitcknn(trainData, trainTargets, 'NumNeighbors', K);

    % Test the model
    predictedLabels = predict(Mdl, testData);

    % Calculate the confusion matrix
    confusionMat = confusionmat(testTargets, predictedLabels);

    % Calculate accuracy
    accuracy = sum(predictedLabels == testTargets) / numel(testTargets);
    fprintf('Confusion Matrix for K=%d:\n', K);
    disp(confusionMat);
    fprintf('Accuracy for K=%d: %.2f%%\n', K, accuracy * 100);
end

% Discuss the limitations or drawbacks of KNN
% (This part will be a textual explanation based on your observation and analysis)
