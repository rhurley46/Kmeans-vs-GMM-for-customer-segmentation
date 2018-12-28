%--------kmeans - CORRELATION Distance

nClusters=9; % pick/set number of clusters your going to use
totSum_corr=zeros(nClusters);  % preallocate the result
time_corr = []; % time array
avg_s_corr=zeros(nClusters);
tss_corr = zeros(nClusters);
opts = statset('Display','iter');
for i=2:nClusters
    tic
    [cidx_corr,~,sumd_corr,D_corr]=kmeans(Rfm_data_log,i,'Distance','correlation','Display','iter', 'Replicates',5); 
    [s_corr,h_corr] = silhouette(Rfm_data_log,cidx_corr);
    avg_s_corr(i) = mean(s_corr);
    elapsetime = toc;
    time_corr(i) = sum(elapsetime);
    totSum_corr(i)=sum(sumd_corr);
    S_corr(:,i)= cidx_corr;
    tss_corr(i) = sum(pdist(Rfm_data_log).^2/3863)    
end

%create variables for determing the plot of % var explained
tss_array_corr = tss_corr(:,1)
bss_corr = tss_corr-totSum_corr
bss_array_corr = bss_corr(:,1)

%plot % Var expl
figure
plot(bss_array_corr*100/tss_array_corr, 'b-*')
grid on
title('Elbow method: % Var explained')
xlabel('Number of clusters')
ylabel('Percentage of variance explained')
axis([2 10 95 100])

% Elbow - WCSS
figure
plot(totSum_corr,'b-*')  
grid on
title('Elbow method: WCSS for each k - correlation')
xlabel('Number of clusters')
ylabel('Sum Squared Error Within-Cluster')
axis([2 10 1 100])


%plot the silhoutte score with each iteration
figure
plot(avg_s_corr,'r-*')
grid on
title('Elbow method: AVG Silhouette Score - correlation')
xlabel('Number of clusters')
ylabel('Average Silhoutte')
axis([2 10 0.1 0.9])


%subplots of silh score FOR KMEANS sqEucl
figure
for K=2:nClusters
      
      subplot(3,3,K)     
      cidx_corr = kmeans(Rfm_data_log,K,'Distance','correlation');   
      [s_corr,h_corr] = silhouette(Rfm_data_log,cidx_corr);               
      avg_corr = mean(s_corr);
      x = [avg_corr avg_corr];
      y = [0 5000];
      line(x,y,'Color','red','LineStyle','--')
      title(sprintf('Silhouette for Kmeans clustering (correlation) with n cluster = %d)', K))
      
end
 

%3D scatter for every k
figure
for k = 2:9
    ax(k) = subplot(3,3,k);
    scatter3(Rfm_data_log(:,3),Rfm_data_log(:,1), Rfm_data_log(:,2),k,S_corr(:,k))
end
