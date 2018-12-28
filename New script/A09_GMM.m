%%%------ Guassian Mixture Models CLUSTER ANALYSIS---------


T = table();
nClusters=9;
avg_s_gmm2=zeros(nClusters);
opts = statset('Display','iter', 'MaxIter',10000);
rng(3); % Reset seed for common start values
for j=1:10
    for i=2:nClusters
        gmmod=fitgmdist(Rfm_data_log,i,'RegularizationValue', 0.1,'Options',opts, 'Start', 'plus');  %start = 'plus' the software selects k observations from X using the kmeans++ algorithm. 
        [idx_gmm,~,p_gmm] = cluster(gmmod,Rfm_data_log); %so, it returns the final "clusterization" of the 3863obs
        [s_gmm,h_gmm] = silhouette(Rfm_data_log,idx_gmm);
        avg_s_gmm2(i) = mean(s_gmm);
        T = [T; table(avg_s_gmm2(i))];
              
          
        S_gmm(:,i)= idx_gmm;  %stores the results (obs-clust association) for every obs
    end
    
end

T_array = table2array(T); 
MT1 = reshape(T_array,8, []); %Finally, we had a 8*10 table containing avg silhouette score for every k(2:9, rows)
                              % and for every iteration j(columns)


% Print the average silhoutte scores for the total iterations (for every
% k/component)
for k = 1:8
    avg_silh_gmm = mean(MT1(k,:));
    sprintf("for k = %d", k+1) 
    sprintf("silhoutte score = %d", avg_silh_gmm) 
end

% as it can be seen, the average silhouette score decreases as number of
% clusters increases


% Once calculated/fitted the "gmmod" (GMM dist computed by fitgmdist)
% we can evaluate the Posterior probabilities, with the following code:

[P, nlogL] = posterior(gmmod, Rfm_data_log);

%plot the silhoutte average score with the last iteration (for every k component)
figure
plot(avg_s_gmm2,'r-*')
grid on
title('Elbow method: AVG Silhouette Score - GMM')
xlabel('Number of cluster (2 to 9)')
ylabel('Average Silhoutte')
axis([2 10 0.1 0.9])


