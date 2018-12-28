%%MULTIPLOT for Elbow method - Avg silhoutte scores (for every distance
%%used) - KMEANS


figure
for k = 1:5
    ax(k) = subplot(3,2,k);
end

subplot(ax(1)) %plot with sqEuclidean
x = linspace(1,50);
y = sin(x);
plot(avg_s)  
grid on
title('Elbow method: AVG Silhouette Score - sqEuclidean')
xlabel('Number of clusters)')
ylabel('Average Silhoutte')
axis([2 10 0.3 0.9])



subplot(ax(2)) %plot with cityblock
x = linspace(1,50);
y = sin(x);
plot(avg_s_city)
grid on
title('Elbow method: AVG Silhouette Score - cityblock')
xlabel('Number of clusters')
ylabel('Average Silhoutte')
axis([2 10 0.3 0.9])


subplot(ax(3)) %plot cosine distance
x = linspace(1,50);
y = sin(x);
plot(avg_s_cos)  
grid on
title('Elbow method: AVG Silhouette Score - cosine')
xlabel('Number of clusters')
ylabel('Average Silhoutte')
axis([2 10 0.1 0.9])


subplot(ax(4))  %plot with correlation distance
x = linspace(1,50);
y = sin(x);
plot(avg_s_corr)  
grid on
title('Elbow method: AVG Silhouette Score - correlation')
xlabel('Number of clusters')
ylabel('Average Silhoutte')
axis([2 10 0.1 0.9])

subplot(ax(5))  %multiplot with all 4 distances plot together
x = linspace(1,50);
y = sin(x);
hold on
plot(avg_s, '-o');
plot(avg_s_city, '-o');
plot(avg_s_cos, '-o');
plot(avg_s_corr, '-o');
grid on
title('Elbow method: AVG Silhouette Score')
xlabel('Number of clusters')
ylabel('Average Silhoutte')
axis([2 10 0.1 0.9])
legend('sqEucl', 'cityblock', 'cosine', 'correlation')
hold off



