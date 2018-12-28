%----------kmeans - CITYBLOCK Distance---------------------

nClusters=9; % pick/set number of clusters your going to use
totSum_city=zeros(nClusters);  % preallocate the result
time_city = []; % time array
avg_s_city=zeros(nClusters);
tss_city = zeros(nClusters);
opts = statset('Display','iter');

for i=2:nClusters
    tic
    [cidx_city,~,sumd_city,D_city]=kmeans(Rfm_data_log,i,'Distance','cityblock','Display','iter', 'Replicates', 5); 
    [s_city,h_city] = silhouette(Rfm_data_log,cidx_city);
    avg_s_city(i) = mean(s_city);
    elapsetime = toc;
    time_city(i) = sum(elapsetime);
    totSum_city(i)=sum(sumd_city);
    S_city(:,i)= cidx_city;
    tss_city(i) = sum(pdist(Rfm_data_log).^2/3863)    
end

%create variables for determing the plot of % var explained

tss_array_city = tss_city(:,1)
bss_city = tss_city-totSum_city
bss_array_city = bss_city(:,1)

%plot % Var expl
figure
plot(bss_array_city*100/tss_array_city, 'b-*')
grid on
title('Elbow method: % Var explained')
xlabel('Number of clusters')
ylabel('Percentage of variance explained')
axis([2 10 45 90])

% Elbow - WCSS
figure
plot(totSum_city, 'b-*')  
grid on
title('Elbow method: WCSS for each k - cityblock')
xlabel('Number of clusters')
ylabel('Sum Squared Error Within-Cluster')
axis([2 10 2000 10000])


%plot the silhoutte score with each iteration
figure
plot(avg_s_city, 'r-*')
grid on
title('Elbow method: AVG Silhouette Score - cityblock')
xlabel('Number of clusters')
ylabel('Average Silhoutte')
axis([2 10 0.3 0.9])


%subplots of silh score 
figure
for K=2:nClusters
       
      subplot(3,3,K)     
      cidx_city = kmeans(Rfm_data_log,K,'Distance','cityblock');   
      [s_city,h_city] = silhouette(Rfm_data_log,cidx_city);               
      avg_city = mean(s_city);
      x = [avg_city avg_city];
      y = [0 5000];
      line(x,y,'Color','red','LineStyle','--')
      title(sprintf('Silhouette for Kmeans clustering (cityblock) with n cluster = %d)', K))
      
end
 
%3D scatter for every k
figure
for k = 2:9
    ax(k) = subplot(3,3,k);
    scatter3(Rfm_data_log(:,3),Rfm_data_log(:,1), Rfm_data_log(:,2),k,S_city(:,k))
end
