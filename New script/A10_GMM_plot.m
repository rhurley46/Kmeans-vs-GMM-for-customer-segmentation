%%GMM plots

%  plot the columns of MT1 in order to have a 10*k lines on the avg_silh
hold on
for i = 1:10
      
    plot(MT1(:,i),'r-o'); 
    grid on
    title('Elbow method: AVG Silhouette Score - GMM for 10 iter')
    xlabel('Number of clusters')
    ylabel('Average Silhoutte')
    axis([1 9 0.1 0.9])
   
end
hold off

%silhouette plot (for k components)
figure
for K=2:nClusters
    rng(3);
    subplot(3,3,K)     
    aaa2=fitgmdist(Rfm_data_log,K,'RegularizationValue', 0.1, 'Start', 'plus')
    idx_gmm = cluster(aaa2,Rfm_data_log) 
    [s_gmm,h_gmm] = silhouette(Rfm_data_log,idx_gmm);             
    avg_s_gmm2 = mean(s_gmm);
    x = [avg_s_gmm2 avg_s_gmm2];
    y = [0 5000];
    line(x,y,'Color','red','LineStyle','--')
    title(sprintf('Silhouette for GMM clustering with %d clusters', K))
      
end


% 3D scatterplot for every k(component of GMM)
figure
for k = 2:9
    
    ax(k) = subplot(3,3,k);
    scatter3(Rfm_data_log(:,2),Rfm_data_log(:,3), Rfm_data_log(:,1),k,S_gmm(:,k))
   
end
 


%% Group data using GMM & return probabilities visualising final groups

%create or separate p_gmm columns (respectively increasing k)
p_gmm_k2 = p_gmm(:,1:2)

p_gmm_k3 = p_gmm(:,1:3)

p_gmm_k4 = p_gmm(:,1:4)

p_gmm_k9 = p_gmm(:,1:9)

%Visualise group separatione
% k=2
figure
gpsort_k2 = sortrows(p_gmm_k2,1);  %sort the prob, by the way we do not have an "easy/well separated" dataset, so sometimes "overlapping" happens
plot(gpsort_k2)
xlabel('Point Ranking')
ylabel('Cluster Membership Probability')
legend('Cluster 1','Cluster 2')
title('Cluster Membership, k=2')

% k=3
figure
gpsort_k3 = sortrows(p_gmm_k3,1);  %sort the prob, by the way we do not have an "easy/well separated" dataset, so sometimes "overlapping" happens
plot(gpsort_k3)
xlabel('Point Ranking')
ylabel('Cluster Membership Probability')
legend('Cluster 1','Cluster 2','Cluster 3')
title('Cluster Membership, k=3')


%k=4
figure
gpsort_k4 = sortrows(p_gmm_k4,1);  %sort the prob, by the way we do not have an "easy/well separated" dataset, so sometimes "overlapping" happens
plot(gpsort_k4)
xlabel('Point Ranking')
ylabel('Cluster Membership Probability')
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4')
title('Cluster Membership, k=4')

%k=9
figure
gpsort_k9 = sortrows(p_gmm_k9,1);  %sort the prob, by the way we do not have an "easy/well separated" dataset, so sometimes "overlapping" happens
plot(gpsort_k9)
xlabel('Point Ranking')
ylabel('Cluster Membership Probability')
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Cluster 6','Cluster 7','Cluster 8','Cluster 9')
title('Cluster Membership, k=9')

%% As we can see, there is not a clear "separation" or "membership" for most of the observations. Only few has a high probability (>.85) to belong to a specific component
