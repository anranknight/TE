%% set paths
tic
addpath('D:\GitHub\TE\TRENTOOL');
addpath('D:\GitHub\TE\fieldtrip');
ft_defaults;

%% define data paths

OutputDataPath = 'D:\GitHub\TE\Results\';
InputDataPath = 'D:\GitHub\TE\Data\Input.mat';

%% calculate TE for every experiments

TE = zeros(4,3,7);
direction = 'D:\EEG\Subject';

for i = 2:8  %��ͬ����
   for j = 7:9  %��ͬ����
       for k = 1:3  %��ͬ��
           Direction = strcat(direction,num2str(i),'\Export\00000',num2str(j),'_Filters',num2str(k),'.mat');
           load(InputDataPath);
           load(Direction);
           TE_value = real_data_TE();
           TE(j-6,k,i-1) = TE_value;  %���У�ά��1-������ά��2-�飬ά��3-����
           %load('D:\EEG\Subject2\Export\000007_Filters1.mat');
       end
   end
   
   for j = 10
       for k = 1:3
           Direction = strcat(direction,num2str(i),'\Export\000010_Filters',num2str(k),'.mat');
           load(InputDataPath);
           load(Direction);
           TE_value = real_data_TE();
           TE(j-6,k,i-1) = TE_value;
       end
   end
end
toc

