%% Group analysis for HCP tfMRI Social Cognition task
% smoothing level of 3mm

clear all; 
addpath('G:\Mat_script_all_subs\lab_data');

rootDir = 'F:\HCP';
subjects = {'129331','129129','129028','128632','128127','128026','127933',...
    '127630','126628','126325','124826','124624','124422','124220','123925',...
    '123521','123420','123117','122822','122620','122317','121921','121618',...
    '121416','120717','120515','120212','120111','119126','118932','116726',...
    '115825','115320','114621','114419','114217','113922','113619','113215',...
    '112920','112516','112314','112112','111716','111413','111312','111009',...
    '110613','110411','110007','109830','109123','108828','108525','108323',...
    '108222','108121','107725','107422','107321','107018','118730','118124',...
    '117930','117122','118528','117324','116524','106521','106319','106016',...
    '105620','105216','105115','105014','104820','104012','103818','103515',...
    '103414','103111','102816','102513','101915','101309','101107','101006',...
    '100408','100307','100206',...
    '100610','102311','104416','105923','111514','114823','115017','118225',...
    '125525','128935','131722','137128','140117','146129','146432','155938',...
    '156334','157336','158035','158136','162935','164131','171633','176542',...
    '178142','181232','182436','182739','185442','187345','191841','192641',...
    '198653','200311','201515','203418','283543','318637','352738','380036'};



%% SPM defaults
spm('defaults', 'FMRI');
spm_jobman('initcfg');




%% call contrast files
% condition 1
con_files_cue = spm_select('FPListRec', fullfile(rootDir,subjects,'results_MOT_MovReg'), '^con_0001.nii');
results_dir_cue=fullfile(rootDir,'group_results_MOT_MovReg','cue');

mkdir(results_dir_cue);

 
matlabbatch{1}.spm.stats.factorial_design.dir = cellstr(results_dir_cue);
matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = cellstr(con_files_cue);
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;

matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'cue';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = 1;
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.delete = 0;

matlabbatch{4}.spm.stats.results.spmmat(1) = cfg_dep('Contrast Manager: SPM.mat File', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{4}.spm.stats.results.conspec.titlestr = 'cue';
matlabbatch{4}.spm.stats.results.conspec.contrasts = Inf;
matlabbatch{4}.spm.stats.results.conspec.threshdesc = 'none';
matlabbatch{4}.spm.stats.results.conspec.thresh = 0.001;
matlabbatch{4}.spm.stats.results.conspec.extent = 0;
matlabbatch{4}.spm.stats.results.conspec.conjunction = 1;
matlabbatch{4}.spm.stats.results.conspec.mask.none = 1;
matlabbatch{4}.spm.stats.results.units = 1;
matlabbatch{4}.spm.stats.results.print = 'ps';
matlabbatch{4}.spm.stats.results.write.none = 1;



con_files_lh = spm_select('FPListRec', fullfile(rootDir,subjects,'results_MOT_MovReg'), '^con_0002.*');
results_dir_lh=fullfile(rootDir,'group_results_MOT_MovReg','lh');

mkdir(results_dir_lh);

 
matlabbatch{5}.spm.stats.factorial_design.dir = cellstr(results_dir_lh);
matlabbatch{5}.spm.stats.factorial_design.des.t1.scans = cellstr(con_files_lh);
matlabbatch{5}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{5}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{5}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{5}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{5}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{5}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{5}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{5}.spm.stats.factorial_design.globalm.glonorm = 1;

matlabbatch{6}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{6}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{6}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{7}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{7}.spm.stats.con.consess{1}.tcon.name = 'lh';
matlabbatch{7}.spm.stats.con.consess{1}.tcon.weights = 1;
matlabbatch{7}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{7}.spm.stats.con.delete = 0;

matlabbatch{8}.spm.stats.results.spmmat(1) = cfg_dep('Contrast Manager: SPM.mat File', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{8}.spm.stats.results.conspec.titlestr = 'lh';
matlabbatch{8}.spm.stats.results.conspec.contrasts = Inf;
matlabbatch{8}.spm.stats.results.conspec.threshdesc = 'none';
matlabbatch{8}.spm.stats.results.conspec.thresh = 0.001;
matlabbatch{8}.spm.stats.results.conspec.extent = 0;
matlabbatch{8}.spm.stats.results.conspec.conjunction = 1;
matlabbatch{8}.spm.stats.results.conspec.mask.none = 1;
matlabbatch{8}.spm.stats.results.units = 1;
matlabbatch{8}.spm.stats.results.print = 'ps';
matlabbatch{8}.spm.stats.results.write.none = 1;



con_files_rh = spm_select('FPListRec', fullfile(rootDir,subjects,'results_MOT_MovReg'), '^con_0006.*');
results_dir_rh=fullfile(rootDir,'group_results_MOT_MovReg','rh');

mkdir(results_dir_rh);


matlabbatch{9}.spm.stats.factorial_design.dir = cellstr(results_dir_rh);
matlabbatch{9}.spm.stats.factorial_design.des.t1.scans = cellstr(con_files_rh);
matlabbatch{9}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{9}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{9}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{9}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{9}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{9}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{9}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{9}.spm.stats.factorial_design.globalm.glonorm = 1;

matlabbatch{10}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{10}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{10}.spm.stats.fmri_est.method.Classical = 1;

matlabbatch{11}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{10}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{11}.spm.stats.con.consess = {};
matlabbatch{11}.spm.stats.con.consess{1}.tcon.name = 'rh';
matlabbatch{11}.spm.stats.con.consess{1}.tcon.weights = 1;
matlabbatch{11}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{11}.spm.stats.con.delete = 0;

matlabbatch{12}.spm.stats.results.spmmat(1) = cfg_dep('Contrast Manager: SPM.mat File', substruct('.','val', '{}',{11}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{12}.spm.stats.results.conspec.titlestr = 'rh';
matlabbatch{12}.spm.stats.results.conspec.contrasts = Inf;
matlabbatch{12}.spm.stats.results.conspec.threshdesc = 'none';
matlabbatch{12}.spm.stats.results.conspec.thresh = 0.001;
matlabbatch{12}.spm.stats.results.conspec.extent = 0;
matlabbatch{12}.spm.stats.results.conspec.conjunction = 1;
matlabbatch{12}.spm.stats.results.conspec.mask.none = 1;
matlabbatch{12}.spm.stats.results.units = 1;
matlabbatch{12}.spm.stats.results.print = 'ps';
matlabbatch{12}.spm.stats.results.write.none = 1;

%% Initialising SPM defaults
spm('defaults', 'FMRI');
spm_jobman('initcfg');

%% Save a copy of the script and run job
save(fullfile(rootDir, 'group_analysis_MOT_MovReg.mat'), 'matlabbatch');
spm_jobman('serial', matlabbatch, '');

