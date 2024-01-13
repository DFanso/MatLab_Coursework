% Load the 'fisheriris.mat' data
load('fisheriris.mat');

% Extracting the data
data = meas;

% Calculating the required statistics
N = size(data, 1); % Total number of rows

% Calculating Mean, Standard Deviation, Maximum, Minimum, and RMS
means = mean(data);
std_devs = std(data);
max_vals = max(data);
min_vals = min(data);
rms_vals = sqrt(mean(data.^2));

% Displaying the results
fprintf('Total Number of Rows (N): %d\n', N);
fprintf('Means: %f %f %f %f\n', means);
fprintf('Standard Deviations: %f %f %f %f\n', std_devs);
fprintf('Maximum Values: %f %f %f %f\n', max_vals);
fprintf('Minimum Values: %f %f %f %f\n', min_vals);
fprintf('Root Mean Squares: %f %f %f %f\n', rms_vals);
