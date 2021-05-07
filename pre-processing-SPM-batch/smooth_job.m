 function matlabbatch = smooth_job(data_path, subjects, sessions)

%% Select files to smooth
 nor_files=cellstr(spm_select('FPListRec', fullfile(data_path, subjects, sessions), '^wrf.*'));
 

 
%% Smoothing (uses all the functional scans that have been normalised)

matlabbatch{1}.spm.spatial.smooth.data = nor_files;
matlabbatch{1}.spm.spatial.smooth.fwhm = [3 3 3];
matlabbatch{1}.spm.spatial.smooth.dtype = 0;
matlabbatch{1}.spm.spatial.smooth.im = 0;
matlabbatch{1}.spm.spatial.smooth.prefix = 's';