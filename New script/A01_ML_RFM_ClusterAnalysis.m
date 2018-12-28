%____________________________ MACHINE LEARNING ___________________________
%(After Preprocessing in python - Cluster Analysis)
% Changing WD
cd '\\nsq023vs\u6\aczc947\Desktop\ML\ML_Project\Cluster Segmentation UCI\Final_Scripts';

Rfm_data = readtable('Rfm_retail.csv'); %RFM matrix with original numeric values

summary(Rfm_data); %returns count, class or var, min, median and max

%Remove the first column and convert table in a double array
Rfm_data_arr = table2array(Rfm_data(:,2:end));

%we need to add basic descr stats (mean, std, ...)
mu = mean(Rfm_data_arr(:,2:end));
sigma = std(Rfm_data_arr(:,2:end)); %evaluating these simple statistics (compared also with median values) we expect that the features are not gaussian-distributed..Let's see their distribution with the corrplot

%corrplot
corrplot(Rfm_data_arr); % We can see that all the three features are right-skewed. We need a data transformation (a log-transformation)

%log transform the rfm_data_arr (pay attention that there are some values
%with '0', and log(0) is undefined, so we need to add a small quantity for
%Recency and Monetary (those variables having some 0 values). We tried with
%0.1, but it is possibile to add a smaller value (0.001,... ) (we tried
%this but chose 0.1)
Rfm_data_log = horzcat(log(Rfm_data_arr(:,2)+0.1),log(Rfm_data_arr(:,3)),log(Rfm_data_arr(:,4)+0.1));

%correlation plot between features
corrplot(Rfm_data_log);
%Frequency and Monetary are strongly correlated (more strongly than before/without
%log norm), while there is a mild inverse correlation between Recency and
%the other two measures



