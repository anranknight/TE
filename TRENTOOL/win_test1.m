%% set paths

addpath('D:\GitHub\TE\TRENTOOL');
addpath('D:\GitHub\TE\fieldtrip');
ft_defaults;

%% define data paths

OutputDataPath = 'D:\GitHub\TE\Results\';
InputDataPath = 'D:\GitHub\TE\Data\Input.mat';

load(InputDataPath);

%% import data
%{
%AR data

load('x_value.mat');
load('AR(10)_value');

for i = 1:150
    data.trial{1,i}(1,:)=x;
    data.trial{1,i}(2,:)=X;
end
%}
%{
%ARMA data
load('x_value.mat');
load('ARMA_value.mat');

for i = 1:150
    data.trial{1,i}(1,:)=x;
    data.trial{1,i}(2,:)=Y;
end
%}
%{
%positive correlation
load('x_value.mat');
load('y_pc.mat');

for i = 1:150
    data.trial{1,i}(1,:)=x;
    data.trial{1,i}(2,:)=y_pc;
end
%}
%{
%negative correlation
load('x_value.mat');
load('y_nc.mat');

for i = 1:150
    data.trial{1,i}(1,:)=x;
    data.trial{1,i}(2,:)=y_nc;
end
%}
%{
%positive correlation with delay
load('x_value.mat');
load('y_pcd.mat');

for i = 1:150
    data.trial{1,i}(1,:)=x;
    data.trial{1,i}(2,:)=y_pcd;
end
%}
%{
%square relationship
load('x_value.mat');
load('y_square.mat');

for i = 1:150
    data.trial{1,i}(1,:)=x;
    data.trial{1,i}(2,:)=y_square;
end
%}
%{
%threshold relationship
load('x_value.mat');
load('y_sig.mat');

for i = 1:150
    data.trial{1,i}(1,:)=x;
    data.trial{1,i}(2,:)=y_sig;
end
%}
%{
%linear mixed
load('X_e.mat');
load('Y_e.mat');

for i = 1:150
    data.trial{1,i}(1,:)=X_e;
    data.trial{1,i}(2,:)=Y_e;
end
%}
%{
%SNR
load('X_e_noi.mat');
load('Y_e_noi.mat');

for i = 1:150
    data.trial{1,i}(1,:)=X_e;
    data.trial{1,i}(2,:)=Y_e;
end
%}
%% define cfg for TEprepare.m
cfgTEP = [];

%% data     
% time of interest
cfgTEP.toi = [min(data.time{1,1}),max(data.time{1,1})];
% channels to be analyzed
cfgTEP.sgncmb = {'A1' 'A2'};

% scanning of interaction delays u
% 这里如何设置？
cfgTEP.predicttimemin_u    = 1;   % minimum u to be scanned
cfgTEP.predicttimemax_u    = 10;   % maximum u to be scanned
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
% --- 注意repPred是否需要更改 (timeSeries)-(dimEmb-1)*tauEmb-u
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
%{
%% plotting

load('D:\GitHub\TE\Data\lorenz_layout.mat');

cfgPLOT = [];

cfgPLOT.layout = lay_Lorenz;
cfgPLOT.electrodes = 'highlights';
cfgPLOT.statstype = 1; 
% 1: corrected; 2: uncorrected ; 3: 1-pval; 4: rawdistance
cfgPLOT.alpha = 0.05;
cfgPLOT.arrowpos = 1;
cfgPLOT.showlabels = 'yes';
cfgPLOT.electrodes = 'on';
cfgPLOT.hlmarker = 'o';
cfgPLOT.hlcolor = [0 0 0];
cfgPLOT. hlmarkersize = 4;
cfgPLOT. arrowcolorpos = [1 0 0];

figure;
% TEplot2D(cfgPLOT,TGA_results_analyzed_GA);
TEplot2D(cfgPLOT,TGA_results_GA);
%}

Sum = sum(TGA_results.TEbyU);
TE = Sum/10;
disp(TE);



