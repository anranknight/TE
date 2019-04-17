%% set paths

addpath('/Users/anranknight/Documents/GitHub/TE/TRENTOOL');
addpath('/Users/anranknight/Documents/GitHub/TE/fieldtrip');
ft_defaults;

%% define data paths

OutputDataPath = '/Users/anranknight/Documents/GitHub/TE/Results';
InputDataPath = '/Users/anranknight/Documents/GitHub/TE/Data/lorenz_1-2_45ms';

load(InputDataPath);

%% define cfg for TEprepare.m

cfgTEP = [];

%% data 
% time of interest
cfgTEP.toi = [min(data.time{1,1}),max(data.time{1,1})];
% channels to be analyzed
cfgTEP.sgncmb = {'A1' 'A2'};

% scanning of interaction delays u
cfgTEP.predicttimemin_u    = 40;   % minimum u to be scanned
cfgTEP.predicttimemax_u    = 50;   % maximum u to be scanned
cfgTEP.predicttimestepsize = 1; % time steps between u's to be scanned

% estimator
cfgTEP.TEcalctype = 'VW_ds'; 

% ACT estimation and constraints on allowd ACT(autocorelation time)
cfgTEP.actthrvalue = 100; % threshold for ACT
cfgTEP.maxlag      = 1000;
cfgTEP.minnrtrials = 15; % minimum acceptable number of trials

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
