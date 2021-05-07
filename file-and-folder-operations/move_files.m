for i=1:numel(subjects)
    a=fullfile('/home/nikhil/HCP_mot_results', subjects{i}, 'results_smoothed_data');
    mkdir(char(fullfile('/home/nikhil/HCP_mot_results', subjects{i}, 'results_smoothed_data')), '4m');
    file_list=spm_select('FPList',fullfile('/home/nikhil/HCP_mot_results', subjects{i}, 'results_smoothed_data'), 'any');
    file_list=cellstr(file_list);
    for k=1:length(file_list)
    movefile(file_list{k,1},fullfile('/home/nikhil/HCP_mot_results', subjects{i}, 'results_smoothed_data', '4m'));
    end
end