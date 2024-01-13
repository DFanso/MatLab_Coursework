% Load the Iris dataset
load('fisheriris.mat');
data = meas;

% Normalize the data
data = (data - mean(data)) ./ std(data);

% Convert species to numerical labels
[~, ~, numericSpecies] = unique(species);

% Shuffle and split the dataset
c = cvpartition(length(numericSpecies), 'Holdout', 0.40);
trainData = data(training(c), :);
testData = data(test(c), :);
trainTargets = numericSpecies(training(c));
testTargets = numericSpecies(test(c));

% Convert targets to categorical for neural network
trainTargetsCategorical = full(ind2vec(trainTargets'));
testTargetsCategorical = full(ind2vec(testTargets'));

% Define hidden layer sizes
hiddenLayerSizes = [10, 15, 20];

% Iterate over hidden layer sizes
for i = 1:length(hiddenLayerSizes)
    % Create and train the neural network
    net = patternnet(hiddenLayerSizes(i));
    net.divideParam.trainRatio = 0.7;
    net.divideParam.valRatio = 0.15;
    net.divideParam.testRatio = 0.15;
    net.trainFcn = 'trainscg';  % Scaled conjugate gradient
    [net, tr] = train(net, trainData', trainTargetsCategorical);

    % View the trained network
    view(net);

    % Test the network
    predictions = net(testData');
    [~, predictedClasses] = max(predictions, [], 1);
    
    % Calculate accuracy
    accuracy = sum(predictedClasses == testTargets') / numel(testTargets);
    fprintf('Accuracy for %d hidden layers: %.2f%%\n', hiddenLayerSizes(i), accuracy * 100);
end
