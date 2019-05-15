tic
%% calculate TE for every experiments

TE_Rest = zeros(7,1);
direction = 'D:\EEG\Subject';

for i = 2:8  %不同被试
       Direction = strcat(direction,num2str(i),'\Export\000001_Rest.mat');
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
       TE_Rest(i-1) = TE_value;  %其中：维度1-动作，维度2-组，维度3-被试  
end
mean = mean(TE_Rest);
var  = var(TE_Rest);
save('TE_Rest.mat','TE_Rest');
toc

