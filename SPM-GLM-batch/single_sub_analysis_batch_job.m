function matlabbatch = single_sub5n6_allReg_addedRT_job(data_path, subjects, sessions)

%% Selection of scans
r_num=1; %run number
run_data={NaN(1,16)}; %optimisation for speed
onsets=struct();
durations=struct();
runs = {'r1','r2','r3','r4'};
load (char(fullfile(data_path, subjects, 'se1','struct','csf_reg.mat')));

for s = 1:numel(sessions)
    
    
    for run_ind=1:length(runs)
        run_data{r_num} = cellstr(spm_select('FPList',fullfile(data_path,subjects,sessions(s),runs{run_ind}),'^swrf.*'));
        
        MovReg_file= cellstr(spm_select('FPList', fullfile(data_path, subjects, sessions{s}, runs(run_ind)), '^rp.*'));
        fileId=fopen(char(MovReg_file));
        R=cell2mat(textscan(fileId,'%f %f %f %f %f %f','Delimiter', '\t'));
        fclose(fileId);
        
        if strcmp(sessions{s},'se1') && strcmp(runs{run_ind},'r1')
            
            R(:,7)=Y(1:numel(run_data{r_num}));
            save(char(fullfile(data_path,subjects,sessions{s},runs{run_ind},'All_reg.mat')),'R');
            len_reg=numel(run_data{r_num}); %regressor length counter
        else
            R(:,7)=Y(len_reg+1:len_reg+numel(run_data{r_num}));
            save(char(fullfile(data_path,subjects,sessions{s},runs{run_ind},'All_reg.mat')),'R');
            len_reg=len_reg+numel(run_data{r_num}); %regressor length counter
        end
        
        AllReg_files{r_num}=cellstr(spm_select('FPList', fullfile(data_path, subjects, sessions{s},runs{run_ind}), '^All_reg.*'));
        
        r_num=r_num+1;
    end
    
    
    %% Extraction of onsets and durations from timing files
    
    onset_files={'R1_onsets',...
        'R2_onsets',...
        'R3_onsets',...
        'R4_onsets'};
    
    for p=1:numel(runs)
        load (char(fullfile('G:\oddoneout_data', subjects, sessions(s),'timing_files',onset_files(p))));
        
        %% For Run 1
        
        
            temp1_1=[];
            stim_onsets_temp1_1=[];
            temp1_2=[];
            stim_onsets_temp1_2=[];
            temp2_1=[];
            stim_onsets_temp2_1=[];
            temp2_2=[];
            stim_onsets_temp2_2=[];
            temp3_1=[];
            stim_onsets_temp3_1=[];
            temp3_2=[];
            stim_onsets_temp3_2=[];
            temp4_1=[];
            stim_onsets_temp4_1=[];
            temp4_2=[];
            stim_onsets_temp4_2=[];
            
            
            switch char(onset_files(p))
                
                case 'R1_onsets'
                    
                    stim_onsets=R1_onsets.stim_onset-10;
                    bp_onsets=R1_onsets.bp_onset-10;
                    
                    RT_all=R1_onsets.RT;
                    
                    temp_bp=NaN(1,112);
                    n=1;
                    bp_onset_indices=[];
                    for k=1:length(R1_onsets.odd_trial)
                        if R1_onsets.odd_trial(k)==1 && R1_onsets.bp(k)==1
                            temp_bp(k)=bp_onsets(k);
                            bp_onset_indices(n)=k;
                            n=n+1;
                        end
                    end
                    
                    stim_onsets1=stim_onsets;
                    stim_onsets1(bp_onset_indices)=NaN;
                    
                    
                    j=1:4:length(stim_onsets1);
                    k=j(1:2:end);
                    for i=1:numel(k)
                        temp1_1(j(i):j(i+1)-1)=temp_bp(k(i):k(i)+3);
                        stim_onsets_temp1_1(j(i):j(i+1)-1)=stim_onsets1(k(i):k(i)+3);
                        RT_all_1_1(j(i):j(i+1)-1,1)=RT_all(k(i):k(i)+3);
                    end
                    
                    RT_avg_1_1=mean(RT_all_1_1(~isnan(RT_all_1_1)));
                    
                    onsets.sess(s).run(p).block1_1=temp1_1(~isnan(temp1_1));
                    durations.sess(s).run(p).block1_1=zeros(length(onsets.sess(s).run(p).block1_1),1);
                    
                    onsets.sess(s).run(p).block1_2=stim_onsets_temp1_1(~isnan(stim_onsets_temp1_1))+RT_avg_1_1;
                    durations.sess(s).run(p).block1_2=zeros(length(onsets.sess(s).run(p).block1_2),1);
                    
                    k=j(2:2:end);
                    for i=1:numel(k)
                        temp1_2(j(i):j(i+1)-1)=temp_bp(k(i):k(i)+3);
                        stim_onsets_temp1_2(j(i):j(i+1)-1)=stim_onsets1(k(i):k(i)+3);
                        RT_all_1_2(j(i):j(i+1)-1,1)=RT_all(k(i):k(i)+3);
                    end
                    
                    RT_avg_1_2=mean(RT_all_1_2(~isnan(RT_all_1_2)));

                    
                    onsets.sess(s).run(p).block2_1=temp1_2(~isnan(temp1_2));
                    durations.sess(s).run(p).block2_1=zeros(length(onsets.sess(s).run(p).block2_1),1);
                    
                    onsets.sess(s).run(p).block2_2=stim_onsets_temp1_2(~isnan(stim_onsets_temp1_2))+RT_avg_1_2;
                    durations.sess(s).run(p).block2_2=zeros(length(onsets.sess(s).run(p).block2_2),1);
                    
                    onsets.sess(s).run(p).RT_avg_block1=RT_avg_1_1;
                    onsets.sess(s).run(p).RT_avg_block2=RT_avg_1_2;
                    
                    case 'R2_onsets'
                    
                    stim_onsets=R2_onsets.stim_onset-10;
                    
                    co_onsets=NaN(1,112);
                    n=1;
                    co_onset_indices=[];
                    for k=1:length(R2_onsets.odd_trial)
                        if R2_onsets.odd_trial(k)==1
                            co_onsets(k)=stim_onsets(k);
                            co_onset_indices(n)=k;
                            n=n+1;
                        end
                    end
                    
                    stim_onsets1=stim_onsets;
                    stim_onsets1(co_onset_indices)=NaN;
                    
                    j=1:4:length(stim_onsets1);
                    k=j(1:2:end);
                    for i=1:numel(k)
                        temp2_1(j(i):j(i+1)-1)=co_onsets(k(i):k(i)+3);
                        stim_onsets_temp2_1(j(i):j(i+1)-1)=stim_onsets1(k(i):k(i)+3);
                    end
                    
                    onsets.sess(s).run(p).block1_1=temp2_1(~isnan(temp2_1))+RT_avg_1_1;
                    durations.sess(s).run(p).block1_1=zeros(length(onsets.sess(s).run(p).block1_1),1);
                    
                    onsets.sess(s).run(p).block1_2=stim_onsets_temp2_1(~isnan(stim_onsets_temp2_1))+RT_avg_1_1;
                    durations.sess(s).run(p).block1_2=zeros(length(onsets.sess(s).run(p).block1_2),1);
                    
                    
                    k=j(2:2:end);
                    for i=1:numel(k)
                        temp2_2(j(i):j(i+1)-1)=co_onsets(k(i):k(i)+3);
                        stim_onsets_temp2_2(j(i):j(i+1)-1)=stim_onsets1(k(i):k(i)+3);
                    end
                    
                    
                    onsets.sess(s).run(p).block2_1=temp2_2(~isnan(temp2_2))+RT_avg_1_2;
                    durations.sess(s).run(p).block2_1=zeros(length(onsets.sess(s).run(p).block2_1),1);
                    
                    onsets.sess(s).run(p).block2_2=stim_onsets_temp2_2(~isnan(stim_onsets_temp2_2))+RT_avg_1_2;
                    durations.sess(s).run(p).block2_2=zeros(length(onsets.sess(s).run(p).block2_2),1);
                    
                    
                case 'R3_onsets'
                    
                    stim_onsets=R3_onsets.stim_onset-10;
                    bp_onsets=R3_onsets.bp_onset-10;
                    cue_onsets=cue_onsets-10;
                    
                    RT_all=R3_onsets.RT(~isnan(R3_onsets.RT));
                    RT_avg=mean(RT_all);
                    
                    bp_onset_indices=[];
                    n=1;
                    for k=1:length(R3_onsets.odd_trial)
                        if R3_onsets.odd_trial(k)==1 && R3_onsets.bp(k)==1
                            onsets.sess(s).run(p).block1_1(n)=bp_onsets(k);
                            bp_onset_indices(n)=k;
                            n=n+1;
                        end
                    end
                    
                    durations.sess(s).run(p).block1_1=zeros(length(onsets.sess(s).run(p).block1_1),1);

                    
                    stim_onsets(bp_onset_indices)=NaN;
                    
                    j=1:4:length(stim_onsets);
                    k=j(1:2:end);
                    for i=1:numel(k)
                        temp3_1(j(i):j(i+1)-1)=stim_onsets(k(i):k(i)+3);
                    end
                    
                    
                    onsets.sess(s).run(p).block1_2=temp3_1(~isnan(temp3_1))+RT_avg;
                    durations.sess(s).run(p).block1_2=zeros(length(onsets.sess(s).run(p).block1_2),1);
                    
                    
                    n=1;
                    co_onset_indices=[];
                    for k=1:length(R3_onsets.odd_trial)
                        if R3_onsets.odd_trial(k)==1 && isnan(R3_onsets.bp(k))
                            onsets.sess(s).run(p).block2_1(n)=stim_onsets(k)+RT_avg;
                            co_onset_indices(n)=k;
                            n=n+1;
                        end
                    end
                    
                    durations.sess(s).run(p).block2_1=zeros(length(onsets.sess(s).run(p).block2_1),1);
                    
                    stim_onsets(co_onset_indices)=NaN;
                    
                    k=j(2:2:end);
                    for i=1:numel(k)
                        temp3_2(j(i):j(i+1)-1)=stim_onsets(k(i):k(i)+3);
                    end
                    
                    
                    onsets.sess(s).run(p).block2_2=temp3_2(~isnan(temp3_2))+RT_avg;
                    durations.sess(s).run(p).block2_2=zeros(length(onsets.sess(s).run(p).block2_2),1);
                    
                    % regressor for cues
                    onsets.sess(s).run(p).cue = cue_onsets+RT_avg;
                    durations.sess(s).run(p).cue = zeros(length(cue_onsets),1);
                    
                    onsets.sess(s).run(p).RT_avg=RT_avg;
                    
                case 'R4_onsets'
                    
                    stim_onsets=R4_onsets.stim_onset-10;
                    bp_onsets=R4_onsets.bp_onset-10;
                    cue_onsets=cue_onsets-10;
                    
                    RT_all=R4_onsets.RT(~isnan(R4_onsets.RT));
                    RT_avg=mean(RT_all);
                    
                    bp_onset_indices=[];
                    n=1;
                    for k=1:length(R4_onsets.odd_trial)
                        if R4_onsets.odd_trial(k)==1 && R4_onsets.bp(k)==1
                            onsets.sess(s).run(p).block1_1(n)=bp_onsets(k);
                            bp_onset_indices(n)=k;
                            n=n+1;
                        end
                    end
                    
                    durations.sess(s).run(p).block1_1=zeros(length(onsets.sess(s).run(p).block1_1),1);
                    
                    stim_onsets(bp_onset_indices)=NaN;
                    
                    j=1:4:length(stim_onsets);
                    k=j(1:2:end);
                    for i=1:numel(k)
                        temp4_1(j(i):j(i+1)-1)=stim_onsets(k(i):k(i)+3);
                        
                    end
                    
                    onsets.sess(s).run(p).block1_2=temp4_1(~isnan(temp4_1))+RT_avg;
                    durations.sess(s).run(p).block1_2=zeros(length(onsets.sess(s).run(p).block1_2),1);
                    
                    
                    n=1;
                    co_onset_indices=[];
                    for k=1:length(R4_onsets.odd_trial)
                        if R4_onsets.odd_trial(k)==1 && isnan(R4_onsets.bp(k))
                            onsets.sess(s).run(p).block2_1(n)=stim_onsets(k)+RT_avg;
                            co_onset_indices(n)=k;
                            n=n+1;
                        end
                    end
                    
                    durations.sess(s).run(p).block2_1=zeros(length(onsets.sess(s).run(p).block2_1),1);
                    
                    stim_onsets(co_onset_indices)=NaN;
                    
                    k=j(2:2:end);
                    for i=1:numel(k)
                        temp4_2(j(i):j(i+1)-1)=stim_onsets(k(i):k(i)+3);
                    end
                    
                    
                    onsets.sess(s).run(p).block2_2=temp4_2(~isnan(temp4_2))+RT_avg;
                    durations.sess(s).run(p).block2_2=zeros(length(onsets.sess(s).run(p).block2_2),1);
                    
                    % regressor for cues
                    onsets.sess(s).run(p).cue = cue_onsets+RT_avg;
                    durations.sess(s).run(p).cue = zeros(length(cue_onsets),1);
                    
                    onsets.sess(s).run(p).RT_avg=RT_avg;        
        end
        
    end
end



%% First level analysis
results_dir=fullfile('F:\oddoneout', subjects,'results_allSess_allReg_addedRT');
mkdir(char(results_dir));

save(fullfile(results_dir,'onsets.mat'),'onsets');

matlabbatch{1}.spm.stats.fmri_spec.dir = cellstr(results_dir);
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;

% Loop over sessions

cond_names={
    'VBP','VST','SBP','SST','NaN';...% sess1 
    'VCO','VST','SCO','SST','NaN';...
    'VBP','VST','VCO','VST','cue';...
    'SBP','SST','SCO','SST','cue';...
    'VBP','VST','SBP','SST','NaN';...% sess2
    'VCO','VST','SCO','SST','NaN';...
    'VBP','VST','VCO','VST','cue';...
    'SBP','SST','SCO','SST','cue';...
    'VBP','VST','SBP','SST','NaN';...% sess3
    'VCO','VST','SCO','SST','NaN';...
    'VBP','VST','VCO','VST','cue';...
    'SBP','SST','SCO','SST','cue';...
    'VBP','VST','SBP','SST','NaN';...% sess4
    'VCO','VST','SCO','SST','NaN';...
    'VBP','VST','VCO','VST','cue';...
    'SBP','SST','SCO','SST','cue';...
    };

s=1;
r=1;
for p=1:length(run_data)
    if p==1||p==2||p==5||p==6||p==9||p==10||p==13||p==14
        
        if p==5
            s=2;
            r=1;
        elseif p==9
            s=3;
            r=1;
        elseif p==13
            s=4;
            r=1;
        end
        
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).scans = run_data{p};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(1).name = cond_names{p,1};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(1).onset = onsets.sess(s).run(r).block1_1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(1).duration = durations.sess(s).run(r).block1_1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(1).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(1).orth = 1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(2).name = cond_names{p,2};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(2).onset = onsets.sess(s).run(r).block1_2;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(2).duration = durations.sess(s).run(r).block1_2;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(2).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(2).orth = 1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(3).name = cond_names{p,3};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(3).onset = onsets.sess(s).run(r).block2_1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(3).duration = durations.sess(s).run(r).block2_1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(3).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(3).orth = 1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(4).name = cond_names{p,4};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(4).onset = onsets.sess(s).run(r).block2_2;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(4).duration = durations.sess(s).run(r).block2_2;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(4).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(4).orth = 1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).multi = {''};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).regress = struct('name', {}, 'val', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).multi_reg = AllReg_files{p};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).hpf = 128;
        r=r+1;
    else
        
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).scans = run_data{p};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(1).name = cond_names{p,1};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(1).onset = onsets.sess(s).run(r).block1_1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(1).duration = durations.sess(s).run(r).block1_1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(1).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(1).orth = 1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(2).name = cond_names{p,2};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(2).onset = onsets.sess(s).run(r).block1_2;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(2).duration = durations.sess(s).run(r).block1_2;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(2).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(2).orth = 1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(3).name = cond_names{p,3};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(3).onset = onsets.sess(s).run(r).block2_1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(3).duration = durations.sess(s).run(r).block2_1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(3).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(3).orth = 1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(4).name = cond_names{p,4};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(4).onset = onsets.sess(s).run(r).block2_2;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(4).duration = durations.sess(s).run(r).block2_2;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(4).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(4).orth = 1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(5).name = cond_names{p,5};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(5).onset = onsets.sess(s).run(r).cue;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(5).duration = durations.sess(s).run(r).cue;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(5).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(5).pmod = struct('name', {}, 'param', {}, 'poly', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).cond(5).orth = 1;
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).multi = {''};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).regress = struct('name', {}, 'val', {});
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).multi_reg = AllReg_files{p};
        matlabbatch{1}.spm.stats.fmri_spec.sess(p).hpf = 128;
        r=r+1;
    end
end
%% Model specification

matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

%% Estimation of the model

matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

%% Specification of contrasts

cond_pos={
    'VBP','VST','SBP','SST','reg','reg','reg','reg','reg','reg','reg',...% sess1
    'VCO','VST','SCO','SST','reg','reg','reg','reg','reg','reg','reg',...
    'VBP','VST','VCO','VST','cue','reg','reg','reg','reg','reg','reg','reg',...
    'SBP','SST','SCO','SST','cue','reg','reg','reg','reg','reg','reg','reg',...
    'VBP','VST','SBP','SST','reg','reg','reg','reg','reg','reg','reg',...% sess2
    'VCO','VST','SCO','SST','reg','reg','reg','reg','reg','reg','reg',...
    'VBP','VST','VCO','VST','cue','reg','reg','reg','reg','reg','reg','reg',...
    'SBP','SST','SCO','SST','cue','reg','reg','reg','reg','reg','reg','reg',...
    'VBP','VST','SBP','SST','reg','reg','reg','reg','reg','reg','reg',...% sess3
    'VCO','VST','SCO','SST','reg','reg','reg','reg','reg','reg','reg',...
    'VBP','VST','VCO','VST','cue','reg','reg','reg','reg','reg','reg','reg',...
    'SBP','SST','SCO','SST','cue','reg','reg','reg','reg','reg','reg','reg',...
    'VBP','VST','SBP','SST','reg','reg','reg','reg','reg','reg','reg',...% sess4
    'VCO','VST','SCO','SST','reg','reg','reg','reg','reg','reg','reg',...
    'VBP','VST','VCO','VST','cue','reg','reg','reg','reg','reg','reg','reg',...
    'SBP','SST','SCO','SST','cue','reg','reg','reg','reg','reg','reg','reg'...
    };


vbp_pos=[];
vst_pos=[];
sbp_pos=[];
sst_pos=[];
vco_pos=[];
sco_pos=[];
cue_pos=[];

for n=1:length(cond_pos)
    if strcmp(cond_pos(n),'VBP')
        vbp_pos=[vbp_pos n];
    elseif strcmp(cond_pos(n),'VST')
        vst_pos=[vst_pos n];
    elseif strcmp(cond_pos(n),'SBP')
        sbp_pos=[sbp_pos n];
    elseif strcmp(cond_pos(n),'SST')
        sst_pos=[sst_pos n];
    elseif strcmp(cond_pos(n),'VCO')
        vco_pos=[vco_pos n];
    elseif strcmp(cond_pos(n),'SCO')
        sco_pos=[sco_pos n];
    elseif strcmp(cond_pos(n),'cue')
        cue_pos=[cue_pos n];
    end
end

vector=zeros(1,length(cond_pos));
vector(vbp_pos)=1/length(vbp_pos);
vector_vbp=vector;

vector=zeros(1,length(cond_pos));
vector(vst_pos)=1/length(vst_pos);
vector_vst=vector;

vector=zeros(1,length(cond_pos));
vector(sbp_pos)=1/length(sbp_pos);
vector_sbp=vector;

vector=zeros(1,length(cond_pos));
vector(sst_pos)=1/length(sst_pos);
vector_sst=vector;

vector=zeros(1,length(cond_pos));
vector(vco_pos)=1/length(vco_pos);
vector_vco=vector;

vector=zeros(1,length(cond_pos));
vector(sco_pos)=1/length(sco_pos);
vector_sco=vector;

vector=zeros(1,length(cond_pos));
vector(cue_pos)=1/length(cue_pos);
vector_cue=vector;

matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));

matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'VBP';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = vector_vbp;
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'SBP';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = vector_sbp;
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'VCO';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.weights = vector_vco;
matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{4}.tcon.name = 'SCO';
matlabbatch{3}.spm.stats.con.consess{4}.tcon.weights = vector_sco;
matlabbatch{3}.spm.stats.con.consess{4}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{5}.tcon.name = 'VST';
matlabbatch{3}.spm.stats.con.consess{5}.tcon.weights = vector_vst;
matlabbatch{3}.spm.stats.con.consess{5}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{6}.tcon.name = 'SST';
matlabbatch{3}.spm.stats.con.consess{6}.tcon.weights = vector_sst;
matlabbatch{3}.spm.stats.con.consess{6}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{7}.tcon.name = 'cue';
matlabbatch{3}.spm.stats.con.consess{7}.tcon.weights = vector_cue;
matlabbatch{3}.spm.stats.con.consess{7}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{8}.tcon.name = 'all_bp';
matlabbatch{3}.spm.stats.con.consess{8}.tcon.weights = (vector_vbp+vector_sbp)/2;
matlabbatch{3}.spm.stats.con.consess{8}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{9}.tcon.name = 'all_counting';
matlabbatch{3}.spm.stats.con.consess{9}.tcon.weights = (vector_vco+vector_sco)/2;
matlabbatch{3}.spm.stats.con.consess{9}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{10}.tcon.name = 'all_VisualOdd';
matlabbatch{3}.spm.stats.con.consess{10}.tcon.weights = (vector_vbp+vector_vco)/2;
matlabbatch{3}.spm.stats.con.consess{10}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{11}.tcon.name = 'all_SomaticOdd';
matlabbatch{3}.spm.stats.con.consess{11}.tcon.weights = (vector_sbp+vector_sco)/2;
matlabbatch{3}.spm.stats.con.consess{11}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{12}.tcon.name = 'all_nor_stims';
matlabbatch{3}.spm.stats.con.consess{12}.tcon.weights = (vector_vst+vector_sst)/2;
matlabbatch{3}.spm.stats.con.consess{12}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{13}.tcon.name = 'allOddStim';
matlabbatch{3}.spm.stats.con.consess{13}.tcon.weights = (vector_vbp+vector_sbp+vector_vco+vector_sco)/4;
matlabbatch{3}.spm.stats.con.consess{13}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{14}.tcon.name = 'VBP>VCO';
matlabbatch{3}.spm.stats.con.consess{14}.tcon.weights = vector_vbp + (-1*vector_vco);
matlabbatch{3}.spm.stats.con.consess{14}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{15}.tcon.name = 'VCO>VBP';
matlabbatch{3}.spm.stats.con.consess{15}.tcon.weights = vector_vco + (-1*vector_vbp);
matlabbatch{3}.spm.stats.con.consess{15}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{16}.tcon.name = 'SBP>SCO';
matlabbatch{3}.spm.stats.con.consess{16}.tcon.weights = vector_sbp + (-1*vector_sco);
matlabbatch{3}.spm.stats.con.consess{16}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{17}.tcon.name = 'SCO>SBP';
matlabbatch{3}.spm.stats.con.consess{17}.tcon.weights = vector_sco + (-1*vector_sbp);
matlabbatch{3}.spm.stats.con.consess{17}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{18}.tcon.name = 'VBP>VST';
matlabbatch{3}.spm.stats.con.consess{18}.tcon.weights = vector_vbp + (-1*vector_vst);
matlabbatch{3}.spm.stats.con.consess{18}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{19}.tcon.name = 'VCO>VST';
matlabbatch{3}.spm.stats.con.consess{19}.tcon.weights = vector_vco + (-1*vector_vst);
matlabbatch{3}.spm.stats.con.consess{19}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{20}.tcon.name = 'SBP>SST';
matlabbatch{3}.spm.stats.con.consess{20}.tcon.weights = vector_sbp + (-1*vector_sst);
matlabbatch{3}.spm.stats.con.consess{20}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{21}.tcon.name = 'SCO>SST';
matlabbatch{3}.spm.stats.con.consess{21}.tcon.weights = vector_sco + (-1*vector_sst);
matlabbatch{3}.spm.stats.con.consess{21}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{22}.tcon.name = 'VisualOdd>SomaticOdd';
matlabbatch{3}.spm.stats.con.consess{22}.tcon.weights = (vector_vbp + vector_vco) + (-1*(vector_sbp + vector_sco));
matlabbatch{3}.spm.stats.con.consess{22}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{23}.tcon.name = 'SomaticOdd>VisualOdd';
matlabbatch{3}.spm.stats.con.consess{23}.tcon.weights = (vector_sbp + vector_sco) + (-1*(vector_vbp + vector_vco));
matlabbatch{3}.spm.stats.con.consess{23}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{24}.tcon.name = 'VisualOdd > VST';
matlabbatch{3}.spm.stats.con.consess{24}.tcon.weights = (vector_vbp + vector_vco) + (-1*(vector_vst + vector_sst));
matlabbatch{3}.spm.stats.con.consess{24}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{25}.tcon.name = 'SomaticOdd > SST';
matlabbatch{3}.spm.stats.con.consess{25}.tcon.weights = (vector_sbp + vector_sco) + (-1*(vector_vst + vector_sst));
matlabbatch{3}.spm.stats.con.consess{25}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{26}.tcon.name = 'BP>CO';
matlabbatch{3}.spm.stats.con.consess{26}.tcon.weights = (vector_vbp + vector_sbp) + (-1*(vector_vco + vector_sco));
matlabbatch{3}.spm.stats.con.consess{26}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{27}.tcon.name = 'CO>BP';
matlabbatch{3}.spm.stats.con.consess{27}.tcon.weights = (vector_vco + vector_sco) + (-1*(vector_vbp + vector_sbp));
matlabbatch{3}.spm.stats.con.consess{27}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{28}.tcon.name = 'BP > VST+SST';
matlabbatch{3}.spm.stats.con.consess{28}.tcon.weights = (vector_vbp + vector_sbp) + (-1*(vector_vst + vector_sst));
matlabbatch{3}.spm.stats.con.consess{28}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{29}.tcon.name = 'CO > VST+SST';
matlabbatch{3}.spm.stats.con.consess{29}.tcon.weights = (vector_vco + vector_sco) + (-1*(vector_vst + vector_sst));
matlabbatch{3}.spm.stats.con.consess{29}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{30}.tcon.name = 'BP+CO > VST+SST';
matlabbatch{3}.spm.stats.con.consess{30}.tcon.weights = (vector_vbp + vector_sbp + vector_vco + vector_sco) + (-1*(vector_vst + vector_sst));
matlabbatch{3}.spm.stats.con.consess{30}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{31}.fcon.name = 'Omnibus';
matlabbatch{3}.spm.stats.con.consess{31}.fcon.weights = [
vector_vbp;...
vector_vco;...
vector_vst;...
vector_sbp;...
vector_sco;...
vector_sst;...
vector_cue
    ];
matlabbatch{3}.spm.stats.con.consess{31}.fcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{32}.fcon.name = 'Omnibus_bp_co';
matlabbatch{3}.spm.stats.con.consess{32}.fcon.weights = [
    (vector_vbp+vector_sbp)/2;...
    (vector_vco+vector_sco)/2;...
    vector_vst;...
    vector_sst;...
    vector_cue...
    ];
matlabbatch{3}.spm.stats.con.consess{32}.fcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.consess{33}.fcon.name = 'Omnibus_visOdd_somOdd';
matlabbatch{3}.spm.stats.con.consess{33}.fcon.weights = [
    (vector_vbp+vector_vco)/2;...
    (vector_sbp+vector_sco)/2;...
    vector_vst;...
    vector_sst;...
    vector_cue...
    ];
matlabbatch{3}.spm.stats.con.consess{33}.fcon.sessrep = 'none';


matlabbatch{3}.spm.stats.con.consess{34}.fcon.name = 'Omnibus_allOdd';
matlabbatch{3}.spm.stats.con.consess{34}.fcon.weights = [
    (vector_vbp+vector_sbp+vector_vco+vector_sco)/4;...
    vector_vst;...
    vector_sst;...
    vector_cue...
    ];
matlabbatch{3}.spm.stats.con.consess{34}.fcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.delete = 0;