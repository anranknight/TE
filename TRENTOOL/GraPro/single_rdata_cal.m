%% set paths

addpath('D:\GitHub\TE\TRENTOOL');
addpath('D:\GitHub\TE\fieldtrip');
ft_defaults;

%% define data paths and get the input

OutputDataPath = 'D:\GitHub\TE\Results\';
InputDataPath = 'D:\GitHub\TE\Data\Input.mat';
load(InputDataPath);
load('D:\EEG\Subject2\Export\000007_Filters1.mat');
% average
eeg = (Cz+C1+C3+C5+CP1+CP3+CP5+FC1+FC3+FC5)/10;
emg = (ch1+ch2+ch3+ch4)/4;

% change data format
T = 1/SampleRate;
time = 0:T:size(eeg)/SampleRate-T;
% for i = 1:150
%     data.trial{1,i}      = eeg';
%     data.trial{1,i}(2,:) = emg';
%     data.time{1,i}       = time;
% end

%% define cfg for TEprepare.m
cfgTEP = [];

%% data     
% time of interest
cfgTEP.toi = [min(data.time{1,1}),max(data.time{1,1})];
% channels to be analyzed
cfgTEP.sgncmb = {'A1' 'A2'};

% scanning of interaction delays u
% ����������ã�
cfgTEP.predicttimemin_u    = 41;   % minimum u to be scanned
cfgTEP.predicttimemax_u    = 50;   % maximum u to be scanned
cfgTEP.predicttimestepsize = 1; % time steps between u's to be scanned

% estimator
cfgTEP.TEcalctype = 'VW_ds'; 

% ACT estimation and constraints on allowd ACT(autocorelation time)
cfgTEP.actthrvalue = 100; % threshold for ACT
cfgTEP.maxlag      = 1000;
cfgTEP.minnrtrials = 15; % minimum acceptable number of trials  *** changed

% optimizing embedding
cfgTEP.optimizemethod = 'ragwitz' ; % criterion used
cfgTEP.ragdim         = 2:9; % criterion dimension
cfgTEP.ragtaurange    = [0.2 0.4]; % range of tau
cfgTEP.ragtausteps    = 5; % steps for ragwitz tau steps
% --- ע��repPred�Ƿ���Ҫ���� (timeSeries)-(dimEmb-1)*tauEmb-u
cfgTEP.repPred        = 100; % size(data.trial{1,1},2)*(3/4)

% kernel-based TE estimation
cfgTEP.flagNei = 'Mass'; % neighbour analyze type
cfgTEP.sizeNei = 4; % neighbour to analyze

%% define cfg for TEsurrogatestats.m

cfgTESS = [];

% use individual dimensions for embedding
cfgTESS.optdimusage = 'indivdim';

% statistical and shift testing
cfgTESS.tail           = 1;
cfgTESS.numpermutation = 5e4;
cfgTESS.shifttesttype  = 'TEshift>TE';
cfgTESS.surrogatetype  = 'trialshuffling';

% result file name
cfgTESS.fileidout = strcat(OutputDataPath,'Lorenzdata_1->2_');

% calculation - scan over specified values for u

TGA_results = IDR_calculate(cfgTEP,cfgTESS,data);
save([OutputDataPath 'Output.mat'],'TGA_results');
% save('D:\GitHub\TE\Results\TGA_results_1.mat','TGA_results');
%% optional: perform a post hoc correction for cadcade effects and simple common drive effects

cfgGA = [];

cfgGA.threshold = 3;
cfgGA.cmc = 1;

% TGA_results_GA = TEgraphanalysis(cfgGA,TGA_results_analyzed);
TGA_results_GA = TEgraphanalysis(cfgGA,TGA_results);
save([OutputDataPath 'Output_GA.mat'],'TGA_results_GA');


Sum = sum(TGA_results.TEbyU);
TE_value = Sum/10;
%disp(TE);

