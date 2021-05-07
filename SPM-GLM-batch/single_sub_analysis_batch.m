clear all
addpath('G:\Mat_script_all_subs\oddoneout');

%% specify path
%Experiment folder
data_path ='F:\oddoneout';

%subject folders
subjects = {
                 'su5',...
                 'su6'

            };
        
% sessions
sessions= {
                'se1',...
                     'se2',...
                      'se3',...
                     'se4',...
                };
 
%% Initialise SPM defaults
spm('defaults', 'FMRI');
spm_jobman('initcfg');

for i=1:numel(subjects)


% display which subject and session is being processed
    fprintf('Processing subject "%s" \n',...
        subjects{i});
    
matlabbatch = single_sub5n6_allReg_addedRT_job(data_path, subjects{i}, sessions);

    %% Save and run job
    % -----------------------
    % This line saves the batch job file as if you would have set it
    % manually in the subject folder. It is a documentation of what you
    % have done here.
    save(fullfile(data_path, subjects{i},'single_sub5n6_allReg_addedRT.mat'), 'matlabbatch');
    
    % This executes the batch as it is specified in the structure
    % matlabbatch ...
    spm_jobman('serial', matlabbatch, '');
    clear matlabbatch;
end

