*******MACHINE LEARNING COURSEWORK*******

Readme file: "Online Retail Data" (UCI dataset):

**Matlab Scripts:
- Scripts are ordered chronologically (A01____, A02,___, etc..), and therefore should be run sequentially. 

Explanation of each matlab scripts:

A01_ML_RFM_ClusterAnalysis: Loads data (following preprocessing in python) gives data overview.

A02_Kmeans_SqEuclidean: Kmeans analysis with distace parameter = 'squaredEuclidean'

A03_Kmeans_cityblock: Kmeans analysis with distace parameter = 'cityblock'

A04_Kmeans_correlation: Kmeans analysis with distace parameter = 'correlation' (Pearson's correlation)

A05_Kmeans_cosine: Kmeans analysis with distace parameter = 'cosine'

A06_Avg_silh_plot_kmeans_all_dist: Graphic evaluation (average silhouette score) of the multiple kmeans algorithms 

A07_eval_cluster_Kmeans: Evaluation of the optimum "k" using "evalcluster" function (with silhouette scoer as the fixed criteria)

A08_Extract_Final_ClusterInfo_Kmeans: Final analysis and overview of customers segmentation with our optimal Kmeans model

A09_GMM:  Gaussian Mixture Models analysis

A10_GMM_plot:  Graphic and probabilistic evaluation of the customer segmentation using GMM

--------------------------------------------------------------------------------------------------------

**** Excel files and jupyter notebook****

1) 'Online Retail.xlsx': original dataset (directly downloadable on https://archive.ics.uci.edu/ml/datasets/online+retail) *not for direct use on matlab*

2) 'Rfm_retail.csv': Preprocessed dataset (jupyter's notebook output) *for use in 'A01_' onwards.

3) 'Online_Retail_DataPreProcessing_final.ipynb': Preprocessing phase on jupyter notebook