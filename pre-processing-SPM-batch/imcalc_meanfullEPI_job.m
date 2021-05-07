function matlabbatch = imcalc_meanfullEPI_job(data_path, subjects, sessions)

%% Generate mean full brain EPI image


dir=fullfile(data_path, subjects, sessions, 'fullEPI');

files=cellstr(spm_select('FPList', dir, '^f19.*'));


matlabbatch{1}.spm.util.imcalc.input = files;
matlabbatch{1}.spm.util.imcalc.output = 'f19_mean_EPI';
matlabbatch{1}.spm.util.imcalc.outdir = cellstr(dir);
matlabbatch{1}.spm.util.imcalc.expression = '(i1+i2+i3+i4+i5)/5';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;