clear all; clc; close all 
lowr_path = 'E:\2022.9\9.23\afterica\111\high';
files = lowr([lowr_path,filesep,'*.set']);
cd(lowr_path);
 

Cond = {  '111' }; %% conlowtion name
%Cond = {  '222' }; %% conlowtion name
for Subj = 1:length(files)
    setname = files(Subj).name;
    EEG = pop_loadset('filename',setname,'filepath',lowr_path);
    for Cond_No = 1:length(Cond)
        EEG_new = pop_epoch( EEG, Cond(Cond_No), [-2  7], 'newname', 'Merged datasets pruned with ICA', 'epochinfo', 'yes'); 
        EEG_new = pop_rmbase( EEG_new, [-200     0]);
        EEG_avg(Subj,Cond_No,:,:) = squeeze(mean(EEG_new.data,3));  %% average across trials for EEG_new, EEG_avg lowmension: subj*cond*channel*time
    end
end
save('E:\2022.9\9.23\afterica\111\high\reason_high.mat','EEG_new','EEG_avg','EEG','Cond');  

%%
clear all;clc;
load('E:\2022.9\9.23\afterica\111\low\reason_low.mat');
%test_idx = find((EEG_new.times>=180)&(EEG_new.times<=280)); %% d
%test_idx = find((EEG_new.times>=330)&(EEG_new.times<=440)); %% d
%test_idx = find((EEG_new.times>=600)&(EEG_new.times<=750)); %% d
%test_idx = find((EEG_new.times>=1000)&(EEG_new.times<=1500)); %% d
test_idx = find((EEG_new.times>=2200)&(EEG_new.times<=2800)); %% d
data_low11 = squeeze(mean(EEG_avg(:,1,:,test_idx),4)); %% select the data in [197 217]ms, subj*cond*channel
load('E:\2022.9\9.23\afterica\222\low\reason_low.mat');
data_low22 = squeeze(mean(EEG_avg(:,1,:,test_idx),4)); 
load('E:\2022.9\9.23\afterica\111\high\reason_high.mat');
data_high11 = squeeze(mean(EEG_avg(:,1,:,test_idx),4));
load('E:\2022.9\9.23\afterica\222\high\reason_high.mat');
data_high22 = squeeze(mean(EEG_avg(:,1,:,test_idx),4));


figure;
subplot(141);
topoplot(squeeze(mean(data_low11(:,:),1)),EEG.chanlocs,'maplimits',[-3 3]); colorbar;
subplot(142);
topoplot(squeeze(mean(data_low22(:,:),1)),EEG.chanlocs,'maplimits',[-3 3]); colorbar;
subplot(143);
topoplot(squeeze(mean(data_high11(:,:),1)),EEG.chanlocs,'maplimits',[-3 3]); colorbar;
subplot(144);
topoplot(squeeze(mean(data_high22(:,:),1)),EEG.chanlocs,'maplimits',[-3 3]); colorbar;


%%
%congruent
clear all;clc;
load('E:\2022.9\9.23\afterica\111\high\reason_high.mat');
data_test1 = squeeze(EEG_avg(:,:,28,:));
data_test2 = squeeze(EEG_avg(:,:,17,:));
data_test3 = squeeze(EEG_avg(:,:,29,:));

data_test1 = squeeze(EEG_avg(:,:,30,:));
data_test2 = squeeze(EEG_avg(:,:,18,:));
data_test3 = squeeze(EEG_avg(:,:,31,:));

data_test1 = squeeze(EEG_avg(:,:,32,:));
data_test2 = squeeze(EEG_avg(:,:,19,:));
data_test3 = squeeze(EEG_avg(:,:,33,:));

 i=find((EEG_new.times>=180)&(EEG_new.times<=280));
 data_11 = squeeze(mean(data_test1(:,1,i),3));
 data_12 = squeeze(mean(data_test2(:,1,i),3));
 data_13 = squeeze(mean(data_test3(:,1,i),3));
 data_1 = (data_11+data_12+data_13 )/3;
 
 j=find((EEG_new.times>=330)&(EEG_new.times<=440));
  data_21 = squeeze(mean(data_test1(:,1,j),3));
  data_22 = squeeze(mean(data_test2(:,1,j),3));
  data_23 = squeeze(mean(data_test3(:,1,j),3));
  data_2 = (data_21+data_22+data_23 )/3;
  
  f=find((EEG_new.times>=600)&(EEG_new.times<=750));
  data_31 = squeeze(mean(data_test1(:,1,f),3));
  data_32 = squeeze(mean(data_test2(:,1,f),3));
  data_33 = squeeze(mean(data_test3(:,1,f),3));
  data_3 = (data_31+data_32+data_33 )/3;

   g=find((EEG_new.times>=1000)&(EEG_new.times<=1500));
  data_41 = squeeze(mean(data_test1(:,1,g),3));
  data_42 = squeeze(mean(data_test2(:,1,g),3));
  data_43 = squeeze(mean(data_test3(:,1,g),3));
  data_4 = (data_41+data_42+data_43 )/3;
 
  k=find((EEG_new.times>=2200)&(EEG_new.times<=2800));
  data_51 = squeeze(mean(data_test1(:,1,k),3));
  data_52 = squeeze(mean(data_test2(:,1,k),3));
  data_53 = squeeze(mean(data_test3(:,1,k),3));
  data_5 = (data_51+data_52+data_53 )/3;
  %%
  %incongruent
clear all;clc;
load('E:\2022.9\9.23\afterica\222\high\reason_high.mat');
data_test1 = squeeze(EEG_avg(:,:,28,:));
data_test2 = squeeze(EEG_avg(:,:,17,:));
data_test3 = squeeze(EEG_avg(:,:,29,:));

data_test1 = squeeze(EEG_avg(:,:,30,:));
data_test2 = squeeze(EEG_avg(:,:,18,:));
data_test3 = squeeze(EEG_avg(:,:,31,:));

data_test1 = squeeze(EEG_avg(:,:,32,:));
data_test2 = squeeze(EEG_avg(:,:,19,:));
data_test3 = squeeze(EEG_avg(:,:,33,:));

 i=find((EEG_new.times>=180)&(EEG_new.times<=280));
 data_11 = squeeze(mean(data_test1(:,2,i),3));
 data_12 = squeeze(mean(data_test2(:,2,i),3));
 data_13 = squeeze(mean(data_test3(:,2,i),3));
 data_1 = (data_11+data_12+data_13 )/3;
 
 j=find((EEG_new.times>=330)&(EEG_new.times<=440));
  data_21 = squeeze(mean(data_test1(:,2,j),3));
  data_22 = squeeze(mean(data_test2(:,2,j),3));
  data_23 = squeeze(mean(data_test3(:,2,j),3));
  data_2 = (data_21+data_22+data_23 )/3;
  
  f=find((EEG_new.times>=600)&(EEG_new.times<=750));
  data_31 = squeeze(mean(data_test1(:,2,f),3));
  data_32 = squeeze(mean(data_test2(:,2,f),3));
  data_33 = squeeze(mean(data_test3(:,2,f),3));
  data_3 = (data_31+data_32+data_33 )/3;

   g=find((EEG_new.times>=1000)&(EEG_new.times<=1500));
  data_41 = squeeze(mean(data_test1(:,2,g),3));
  data_42 = squeeze(mean(data_test2(:,2,g),3));
  data_43 = squeeze(mean(data_test3(:,2,g),3));
  data_4 = (data_41+data_42+data_43 )/3;
 
  k=find((EEG_new.times>=2200)&(EEG_new.times<=2800));
  data_51 = squeeze(mean(data_test1(:,2,k),3));
  data_52 = squeeze(mean(data_test2(:,2,k),3));
  data_53 = squeeze(mean(data_test3(:,2,k),3));
  data_5 = (data_51+data_52+data_53 )/3;

%%
%95%CI
clear all; clc; close
load('E:\2022.9\9.23\afterica\111\low\reason_low.mat');
Fz = 17; 
%Cz =  18;
%Pz = 19;
mean_data1 = squeeze(mean(EEG_avg(:,1,Fz,:),1));
stderr_data = std(EEG_avg(:,1,Fz,:), [], 1) / sqrt(size(EEG_avg, 1));
stderr_data1 = squeeze(stderr_data);
load('E:\2022.9\9.23\afterica\111\high\reason_high.mat');
mean_data2 = squeeze(mean(EEG_avg(:,1,Fz,:),1));
stderr_data = std(EEG_avg(:,1,Fz,:), [], 1) / sqrt(size(EEG_avg, 1));
stderr_data2 = squeeze(stderr_data);


figure;
blue_color = [0.2, 0.4, 0.8]; % blue
red_color = [0.8, 0.2, 0.2]; % red
line_style = '--'; 

plot(EEG_new.times, mean_data1,'color', blue_color, 'linestyle', line_style, 'linewidth', 1.5);
hold on;
x_fill = [EEG_new.times, fliplr(EEG_new.times)];
y_upper = mean_data1 + 1.96 * stderr_data1;
y_lower = mean_data1 - 1.96 * stderr_data1;
y_fill = [y_upper', fliplr(y_lower')]; 
patch(x_fill, y_fill, blue_color, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
plot(EEG_new.times, mean_data2,'color', red_color, 'linestyle', line_style, 'linewidth', 1.5);
hold on;
y_upper = mean_data2 + 1.96 * stderr_data2;
y_lower = mean_data2 - 1.96 * stderr_data2;
y_fill = [y_upper', fliplr(y_lower')]; 
patch(x_fill, y_fill, red_color, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
line([min(EEG_new.times), max(EEG_new.times)], [0, 0], 'color', 'k', 'linestyle', '-');
line([0, 0], [-4, 6], 'color', 'k', 'linestyle', '-');

set(gca,'YDir','reverse');  
axis([-200 2800 -4 6]);  
set(gca, 'XTick', -200:200:2800); 
set(gca, 'YTick', -4:1:6);
title('Fz 111','fontsize',16);
xlabel('Latency (ms)','fontsize',16);
ylabel('Amplitude (uV)','fontsize',16);
legend('Congruent (low)', '95% CI congruent (low)', 'Congruent (high)', '95% CI congruent (high)');