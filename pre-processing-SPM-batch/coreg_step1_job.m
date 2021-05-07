function matlabbatch = coreg_step1_job(data_path, subjects, sessions)

%% i)manually orient the mean_func with the full_EPI_mean
%% ii) coregister them
%% iii) manually re-orient full_EPI_mean with the structural file
%% iv) coregister them


%% Selection of the mean of the functional files and the structural files


mean_func=cellstr(spm_select('FPListRec', fullfile(data_path, subjects, sessions), '^meanf19.*'));
full_EPI_mean=cellstr(spm_select('FPList', fullfile(data_path, subjects,sessions, 'fullEPI'), '^f19_mean.*'));


%% Coregistration (ii - see above)

 matlabbatch{1}.spm.spatial.coreg.estimate.ref = mean_func;
 matlabbatch{1}.spm.spatial.coreg.estimate.source = full_EPI_mean;
 matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};
 matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
 matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
 matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
 matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];

%% Go ahead with step iii) and iv)



