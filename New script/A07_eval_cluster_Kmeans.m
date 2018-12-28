
%% Another methodology in order to evaluate cluster analysis, choosing the optimal k for each distance used is by
%% the evalcluster function with the fixed "criterion" as the silhouette.

%% We start the Klist ('List of number of cluster to evaluate') at '3' because we are not interest in a "binary" segmentation 
%% between "good" and "bad" customers (thus no interest in grouping into 2 groups)

eva_kmeans_silh_euc = evalclusters(Rfm_data_log, 'kmeans', 'silhouette', 'Distance','sqEuclidean', 'KList', [3:9])

eva_kmeans_silh_city = evalclusters(Rfm_data_log, 'kmeans', 'silhouette', 'Distance','cityblock', 'KList', [3:9])

eva_kmeans_silh_cosine = evalclusters(Rfm_data_log, 'kmeans', 'silhouette', 'Distance','cosine', 'KList', [3:9])

eva_kmeans_silh_corr = evalclusters(Rfm_data_log, 'kmeans', 'silhouette', 'Distance','correlation', 'KList', [3:9])

%% From the 'evaluation' results we see that:
%% for sqEuclidean distance our Optimal K is 4, while for all of the others is 3 (and we are expecting these results by the previous observations and analysis)