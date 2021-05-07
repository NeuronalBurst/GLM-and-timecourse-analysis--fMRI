clear all
%% specify path
%Experiment folder
data_path ='F:\oddoneout';

%subject folders
subjects = {
%                  'su2',...
%                  'su3',...
                'su5',...
                'su6'


            };
        
% sessions
sessions= {
%                 'se1',...
%                       'se2',...
                      'se3',...
                     'se4'
%                      'se5'
                };
        

        
%% Initialise SPM defaults
spm('defaults', 'FMRI');
spm_jobman('initcfg');

for i=1:numel(subjects)
for j = 1:numel(sessions)
% set up SPM-readable structure array
% display which subject and session is being processed
    fprintf('Processing "%s" "%s" \n',...
        subjects{i}, sessions{j});
    
%     mkdir(fullfile(ana_path, subjects{i}), sessions{j});
    
    matlabbatch = imcalc_meanfullEPI_job(data_path, subjects{i}, sessions{j});

    %% Save and run job
    % -----------------------
    % This line saves the batch job file as if you would have set it
    % manually in the subject folder. It is a documentation of what you
    % have done here.
%    save(fullfile(data_path, subjects{i}, sessions{j},'interpol_data', 'imcalc.mat'), 'matlabbatch');
        save(fullfile(data_path, subjects{i}, sessions{j}, 'imcalc_meanfullEPI.mat'), 'matlabbatch');

    % This executes the batch as it is specified in the structure
    % matlabbatch ...
    spm_jobman('serial', matlabbatch, '');
%     clear matlabbatch;

end
end