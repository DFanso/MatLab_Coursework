rng('default');  
load('kmeansdata.mat'); 

numClusters = [3, 4, 5];
silhouetteAvg = zeros(size(numClusters));
bestSilhouette = -Inf; 

options = statset('MaxIter', 1000, 'Display', 'final');

for K = numClusters
    [idx, centroids, sumd] = kmeans(X, K, 'Distance', 'sqEuclidean', 'Replicates', 10, 'Options', options);
    silhouetteValues = silhouette(X, idx, 'sqEuclidean');
    silhouetteAvg(K-2) = mean(silhouetteValues);
    
    figure;
    silhouette(X, idx, 'sqEuclidean');
    title(['Silhouette for K = ', num2str(K)]);
    
    if silhouetteAvg(K-2) > bestSilhouette
        bestSilhouette = silhouetteAvg(K-2);
        bestIdx = K;
        bestClusterIdx = idx;
        bestCentroids = centroids;
    end
end

figure;
hold on;
colors = ['r', 'b', 'g', 'c', 'm'];  % Extended to accommodate up to 5 clusters
for K = 1:bestIdx
    clust = X(bestClusterIdx==K,:);
    scatter(clust(:,1), clust(:,2), 36, colors(K), 'o', 'filled');
end
scatter(bestCentroids(:,1), bestCentroids(:,2), 100, 'k', 'x', 'LineWidth', 3);
legendEntries = arrayfun(@(x) ['Cluster ' num2str(x)], 1:bestIdx, 'UniformOutput', false);
legendEntries{end+1} = 'Centroids';
legend(legendEntries, 'Location', 'NW');
title(['Cluster Assignments and Centroids for K = ', num2str(bestIdx)]);
hold off;

fprintf('The best number of clusters K is %d with an average silhouette score of %.2f\n', bestIdx, bestSilhouette);
