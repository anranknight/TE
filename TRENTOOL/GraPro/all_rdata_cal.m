tic
%% calculate TE for every experiments

TE = zeros(4,3,7);
direction = 'D:\EEG\Subject';

for i = 2:8  %不同被试
   for j = 7:10  %不同动作
       for k = 1:3  %不同组
           if j == 10
               Direction = strcat(direction,num2str(i),'\Export\000010_Filters',num2str(k),'.mat');
           else
               Direction = strcat(direction,num2str(i),'\Export\00000',num2str(j),'_Filters',num2str(k),'.mat');
           end
           load(Direction);
           %load('D:\EEG\Subject2\Export\000007_Filters1.mat');
           load('D:\GitHub\TE\Data\Input.mat');
           Data.fsample = data.fsample;
           Data.label   = data.label;
           %Data.samplerate
           % average
           eeg = (Cz+C1+C3+C5+CP1+CP3+CP5+FC1+FC3+FC5)/10;
           emg = (ch1+ch2+ch3+ch4)/4;
           %change the format
           T = 1/SampleRate;
           time = 0:T:0.499;
           size = length(eeg);
           size = fix(size/500);
           eeg = eeg';
           emg = emg';
           for m = 1:size
               a = 500*(m-1)+1;
               b = 500*m;
               Data.trial{1,m}      = eeg(a:b);
               Data.trial{1,m}(2,:) = emg(a:b);
               Data.time{1,m}       = time;
           end     
           %calculate
           TE_value = real_data_TE(Data);
           TE(j-6,k,i-1) = TE_value;  %其中：维度1-动作，维度2-组，维度3-被试  
       end
   end
end
toc

