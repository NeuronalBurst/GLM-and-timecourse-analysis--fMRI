
function matlabbatch = coreg_step2_job(data_path, subjects, sessions)

%% iii) manually re-orient full_EPI_mean with the structural
%% iv) coregister them


%% Selection of the mean of the functional files and the structural files
 
 struct = cellstr(spm_select('FPList', fullfile(data_path, subjects, sessions, 'struct'), '^s19.*'));
full_EPI_mean=cellstr(spm_select('FPList', fullfile(data_path, subjects,sessions, 'fullEPI'), '^f19_mean.*'));



    
%% Coregistration (iv - see above)

matlabbatch{1}.spm.spatial.coreg.estimate.ref = full_EPI_mean;
matlabbatch{1}.spm.spatial.coreg.estimate.source = struct;
matlabbatch{1}.spm.spatial.coreg.estimate.other = {''};
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2 1];
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];

%% Manual check 



