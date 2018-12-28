%-----kmeans - COSINE Distance

nClusters=9; % pick/set number of clusters your going to use
totSum_cos=zeros(nClusters);  % preallocate the result
time_cos = []; % time array
avg_s_cos=zeros(nClusters);
tss_cos = zeros(nClusters);
opts = statset('Display','iter');
for i=2:nClusters
    tic
    [cidx_cos,~,sumd_cos,D_cos]=kmeans(Rfm_data_log,i,'Distance','cosine','Display','iter', 'Replicates', 5); 
    [s_cos,h_cos] = silhouette(Rfm_data_log,cidx_cos);
    avg_s_cos(i) = mean(s_cos);
    elapsetime = toc;
    time_cos(i) = sum(elapsetime);
    totSum_cos(i)=sum(sumd_cos);
    S_cos(:,i)= cidx_cos;
    tss_cos(i) = sum(pdist(Rfm_data_log).^2/3863)    
end

%create variables for determing the plot of % var explained
tss_array_cos = tss_cos(:,1)
bss_cos = tss_cos-totSum_cos
bss_array_cos = bss_cos(:,1)

%plot % Var expl
figure
plot(bss_array_cos*100/tss_array_cos, 'b-*')
grid on
title('Elbow method: % Var explained')
xlabel('Number of clusters')
ylabel('Percentage of variance explained')
axis([2 10 95 100])

% Elbow - WCSS
figure
plot(totSum_cos, 'b-*')  % plot of totals versus number of cluster
grid on
title('Elbow method: WCSS for each k - cosine')
xlabel('Number of clusters')
ylabel('Sum Squared Error Within-Cluster')
axis([2 10 1 100])


%plot the silhoutte score with each iteration
figure
plot(avg_s_cos,'r-*')
grid on
title('Elbow method: AVG Silhouette Score - cosine')
xlabel('Number of clusters')
ylabel('Average Silhoutte')
axis([2 10 0.1 0.9])


%subplots of silh score FOR KMEANS sqEucl
figure
for K=2:nClusters
      
      subplot(3,3,K)     
      cidx_cos = kmeans(Rfm_data_log,K,'Distance','cosine','Display','iter');    
      [s_cos,h_cos] = silhouette(Rfm_data_log,cidx_cos);               
      avg_cos = mean(s_cos);
      x = [avg_cos avg_cos];
      y = [0 5000];
      line(x,y,'Color','red','LineStyle','--')
      title(sprintf('Silhouette for Kmeans clustering (cosine) with n cluster = %d)', K))
      
end
 

%3D scatter for every k
figure
for k = 2:9
    ax(k) = subplot(3,3,k);
    scatter3(Rfm_data_log(:,3),Rfm_data_log(:,1), Rfm_data_log(:,2),k,S_cos(:,k))
end
