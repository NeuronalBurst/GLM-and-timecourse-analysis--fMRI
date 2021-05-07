for i=3:numel(subjects)
movefile(fullfile('/home/nikhil/HCP_mot_results', subjects{i}, 'results_smoothed_data'), fullfile('/home/nikhil/HCP_mot_results', subjects{i}, 'results_smoothed'));
end


for i=2:numel(subjects)
    for k=1:length(sessions)
        session=sessions{1,k};
        if strcmp(session, 'tfMRI_MOTOR_RL')==1
            
            movefile(fullfile(data_path,subjects{i},rop,session, 'stfMRI_MOTOR_RL.nii'),fullfile(data_path,subjects{i},rop,session,'s4_tfMRI_MOTOR_RL.nii'));
        else 
            movefile(fullfile(data_path,subjects{i},rop,session, 'stfMRI_MOTOR_LR.nii'),fullfile(data_path,subjects{i},rop,session,'s4_tfMRI_MOTOR_LR.nii'));

        end
    end
end


files=spm_select('FPList','/p/himmelbach/nikhil/analysed_data/sub2/sess1/run3', '^TR.*');
for i=1:numel(files)
    movefile(files(i), fullfile('/p/himmelbach/nikhil/analysed_data/sub2/sess1/run3', sprintf('TR2000ms_%04d.nii',i)));
end