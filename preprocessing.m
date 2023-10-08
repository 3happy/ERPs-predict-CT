% Preprocessing of EEG data
clear all;clc;
ori_path = 'E:\pre_analysis\reason_pre\raw_data';
files = dir([ori_path,filesep,'*.vhdr']);
dir_path = 'E:\2022.9\9.22';
for subj = 1:length(files)
    EEG = pop_loadbv(ori_path,files(subj).name, [], []);
    EEG=pop_chanedit(EEG, 'append',64,'changefield',{65 'labels' 'FCz'},'lookup','D:\toolbox\eeglab13_0_0b\plugins\dipfit2.2\standard_BESA\standard-10-5-cap385.elp','setref',{'1:65' 'FCz'});
    EEG = pop_select( EEG,'nochannel',{'IO' 'FT9' 'FT10'});
    EEG = pop_eegfiltnew(EEG, 0.1, 30, 16500, 0, [], 0);
    EEG = pop_eegfiltnew(EEG, 48, 52, 826, 1, [], 0);

%111 congruent condition; 222 incongruent condition
for j=1:length(EEG.event)-1
       if (strcmp(EEG.event(1,j).type,'S  8') &&(strcmp(EEG.event(1,j+1).type,'S  1')||strcmp(EEG.event(1,j+1).type,'S  2')) && strcmp(EEG.event(1,j+2).type,'S  6'))
            EEG.event(1,j).type = '111';
        end
    end
    for j=1:length(EEG.event)-1
        if (strcmp(EEG.event(1,j).type,'S  8') && (strcmp(EEG.event(1,j+1).type,'S  3')||strcmp(EEG.event(1,j+1).type,'S  4'))&& strcmp(EEG.event(1,j+2).type,'S  6'))
            EEG.event(1,j).type = '222';
        end
    end

    EEG = pop_epoch( EEG, { '111','222' }, [-2 7], 'epochinfo', 'yes');
    EEG = pop_rmbase( EEG, [-200     0]); % 剪基线
    EEG = pop_saveset( EEG, 'filename',['epoch_',files(subj).name,'.set'],'filepath',dir_path);
end
%% Manually trimming artifact segments, interpolating bad channels, and saving as files starting with 'Rej'
%% run ICA
clear all; clc;
dir_path = 'E:\2022.9\9.23';cd(dir_path);
files = dir([dir_path,filesep,'*.set']);
for subj = 1:length(files)
    % 载入数据
    EEG = pop_loadset('filename',files(subj).name,'filepath',dir_path);
    % 运行ICA
    EEG = pop_runica(EEG, 'extended',1,'pca',50,'interupt','on');
    % 保存为ICA开头的文件
    EEG = pop_saveset( EEG, 'filename',['ICA_',files(subj).name],'filepath',dir_path);
end

%% Manually removing ICA components.
%%
clear all; clc;
dir_path = 'E:\2022.9\9.23\afterica';cd(dir_path);
files = dir([dir_path,filesep,'*.set']);
for subj = 1:length(files)
    % 载入数据
    EEG = pop_loadset('filename',files(subj).name,'filepath',dir_path);
    % 运行ICA
    EEG = pop_eegthresh(EEG,1,[1:61] ,-80,80,-1,1.999,1,1);
    EEG = pop_reref( EEG, [28 29] ,'refloc',struct('labels',{'FCz'},'type',{''},'theta',{0},'radius',{0.12662},'X',{32.9279},'Y',{0},'Z',{78.363},'sph_theta',{0},'sph_phi',{67.208},'sph_radius',{85},'urchan',{65},'ref',{'FCz'},'datachan',{0}));
    a = pop_epoch( EEG, {  '111'  }, [-2  7], 'newname', ' pruned with ICA epochs', 'epochinfo', 'yes');
    b = pop_epoch( EEG, {  '222'  }, [-2  7], 'newname', ' pruned with ICA epochs', 'epochinfo', 'yes');
    EEG = pop_saveset( a, 'filename',['111',files(subj).name],'filepath',dir_path);
    EEG = pop_saveset( b, 'filename',['222',files(subj).name],'filepath',dir_path);
end

