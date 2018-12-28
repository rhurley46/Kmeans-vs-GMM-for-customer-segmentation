%---------------------KMEANS-----------------------------------%

% For k-means, you have to set k to the number of clusters you want, but figuring out how many clusters is not obvious from the beginning. We will try different cluster numbers
% and check their silhouette coefficient score, silhouette plots and other measures (SSE and % of variance explained).
% Cluster analysis with kmeans will be carried out also comparing 4
% different distances:
% - squared Euclidean: Squared Euclidean distance (default). Each centroid is the mean of the points in that cluster.
% - cityblock: Sum of absolute differences, i.e., the L1 distance. Each centroid is the component-wise median of the points in that cluster.
% - cosine: One minus the cosine of the included angle between points (treated as vectors). Each centroid is the mean of the points in that cluster, after normalizing those points to unit Euclidean length.
% - correlation: One minus the sample correlation between points (treated as sequences of values). Each centroid is the component-wise mean of the points in that cluster, after centering and normalizing those points to zero mean and unit standard deviation.
% The silhouette coefficient for a data point measures how similar it is to its assigned cluster from -1 (dissimilar) to 1 (similar). 
% 
% Note: K-means is sensitive to initializations because they are critical to qualifty of optima found.
% By default (on Matlab) kmeans uses the k-means++ algorithm for cluster center initialization.



%-----Kmeans Analysis - distance = sqEuclidean------------------



nClusters=9; % pick/set number of clusters your going to use
totSum=zeros(nClusters);  % preallocate the result
time_kmeans = []; % time array
avg_s=zeros(nClusters);
tss = zeros(nClusters);
opts = statset('Display','iter');

for i=2:nClusters
    tic
    [cidx,~,sumd,D]=kmeans(Rfm_data_log,i,'Display','iter', 'Replicates', 5);  % add "Replicates" in order to avoid local minima
    [s,h] = silhouette(Rfm_data_log,cidx);
    avg_s(i) = mean(s);
    elapsetime = toc;
    time_kmeans(i) = sum(elapsetime);
    totSum(i)=sum(sumd);  %sumd is the "within-cluster sums of point-to-centroid distances in the k-by-1 vector sumd" (matlab)
    tss(i) = sum(pdist(Rfm_data_log).^2/3863)
     
    S(:,i)= cidx;
end

%create variables for determing the plot of % var explained
tss_array = tss(:,1)
bss = tss-totSum
bss_array = bss(:,1)

%plot % Var expl
figure
plot(bss_array*100/tss_array, 'b-*')
grid on
title('Elbow method: % Var explained')
xlabel('Number of clusters')
ylabel('Percentage of variance explained')
axis([2 10 45 90])

% Elbow - WCSS (within cluster sum of square)
figure
plot(totSum, 'b-*')  % plot of totals versus number of cluster (same as index). Since totSum derives from "sumd" this plot the WCSS
grid on
title('Elbow method: WCSS for each k')
xlabel('Number of clusters')
ylabel('Sum Squared Error Within-Cluster')
axis([2 10 2000 10000])


%plot the silhoutte score within each iteration
figure
plot(avg_s, 'r-*')
grid on
title('Elbow method: AVG Silhouette Score - sqEuclidean')
xlabel('Number of clusters)')
ylabel('Average Silhoutte')
axis([2 10 0.3 0.9])


%subplots of silh score FOR KMEANS sqEucl
figure
for K=2:nClusters
        
      subplot(3,3,K)     
      cidx = kmeans(Rfm_data_log,K);    
      [s,h] = silhouette(Rfm_data_log,cidx);               
      avg = mean(s);
      x = [avg avg];
      y = [0 5000];
      line(x,y,'Color','red','LineStyle','--')
      title(sprintf('Silhouette for Kmeans clustering (sqeuclidean) with n cluster = %d)', K))
      
end
 
%3D scatter for every k
figure
for k = 2:9
    ax(k) = subplot(3,3,k);
    scatter3(Rfm_data_log(:,3),Rfm_data_log(:,1), Rfm_data_log(:,2),k,S(:,k))
end
