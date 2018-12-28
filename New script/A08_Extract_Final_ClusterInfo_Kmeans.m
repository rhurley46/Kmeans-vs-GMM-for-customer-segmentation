%%%------- EXTRACT MEANINGFULL INFO FROM CLUSTER ANALYSIS-------------
%% Overall, we have observed that kmeans with sqared Euclidean distance "performed" better compared to the other distances (in terms of average silhouette score, silhouette plot and elbow methods, especially when k is greater than 2)
%% This is due because the features are not highly correlated ,apart from Freq and Monetary (so sqEuclideand should be better than "pearson's corr distance")
%% and where standardised ("unit lenght", metrics that works for "cosine" distance) they are not well (normal) distributed and correlated too.

%%Comparing the average time of kmeans for each distance we have that
%%sqEuclidean and cityblock are faster than the other two
mean(time_kmeans);
mean(time_cos);
mean(time_corr);
mean(time_city);


%k = 4 (This is our final choice of k, with kmeans - sqEuclidean distance)
X1_k4 = Rfm_data(S(:,4)==1,:); %returns a table (from the original data) with CustID,R,F and M values for those belonging to group 1 in the kmeans, k =4
X2_k4 = Rfm_data(S(:,4)==2,:); %returns a table (from the original data) with CustID,R,F and M values for those belonging to group 2 in the kmeans, k =4
X3_k4 = Rfm_data(S(:,4)==3,:); %returns a table (from the original data) with CustID,R,F and M values for those belonging to group 3 in the kmeans, k =4
X4_k4 = Rfm_data(S(:,4)==4,:); %returns a table (from the original data) with CustID,R,F and M values for those belonging to group 4 in the kmeans, k =4


%3D scatter for k=4 (Kmeans - sqEuclidean)
figure
scatter3(Rfm_data_log(:,3),Rfm_data_log(:,1), Rfm_data_log(:,2),4,S(:,4))
title('3D plot Kmeans with 4 clusters')
xlabel('Monetary')
ylabel('Recency')
zlabel('Frequency')


%Extract info (RFM)
summary(X1_k4(:,3:5)); %min,max, median
mean(X1_k4{:,3:end},1); %mean values for each feat (R,F,M)

summary(X2_k4(:,3:5));
mean(X2_k4{:,3:end},1);

summary(X3_k4(:,3:5));
mean(X3_k4{:,3:end},1);

summary(X4_k4(:,3:5));
mean(X4_k4{:,3:end},1);

%%%%%%%%%%%%%%%SUMMARY K=4%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cluster 1
%         # customer = 1118
%                 avg     min     max     med
%       Recency  58.65    10      325     46
%       Freq      4.65    1       38      4
%       Monet     1917.5  409.8   77184   1384.1
%       
%     
% Cluster 2
%         # customer = 763
%                 avg     min     max     med
%       Recency   22.5     1       56      21
%       Freq      1.82     1       7       2
%       Monet     406.9    0       1463    361.96
%       
%       
% Cluster 3   
%       # customer = 610
%                 avg     min     max     med
%       Recency    6.24    0      38      4
%       Freq      12.33    1      196     9
%       Monet     6745.8  398.7   233740  2981.1
%       
%       
% Cluster 4      
%       # customer = 1372
%                 avg     min     max     med
%       Recency  183.4    44      365     179
%       Freq      1.38    1       6       1
%       Monet    340.39   3.75    2188    296.44
%             


% % Comments
% Cluster 3 ("Best and loyal customers")
%     represented by those customer with the lowest recency value (!how recently a cust has purchased),
%     with the highest Frequency value and the highest Monetary value.
%     
% Cluster 1 ( "ex-expensive customers")
%  represented by those customers which are used to go in the past, but not in recent times (58.65 of avg Recency),
%  with also a modest frequency and high-value expenditure (1917.5 avg monetary).
%  One task for the marketing experts should be try to re-take these
%  customers in (win back their customers' trust).For example there are some customers that are not satisfied with their purchases for a specific reason 
% (i.e. bad quality/disappointment of a produc) 
%  
% Cluster 2 ( "seldom/occasional customers")
%     represented by those with a low value in frequency (occasional customers) and a medium value of Recency (22.5)
%     however, when they go shopping, they used to spend a good amount (~400£)
%     
% Cluster 4 ("Lost casual customers")
%     This cluster shows, most probably, those customers that are no longer customers.
%     Highest value of Recency (avg 183.4, median 178 and max of a year)
%     between all groups.
%     Lowest value of Frequency and Monetary throughout the all different groups.