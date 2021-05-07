clear all
%% specify path
%Experiment folder
data_path ='F:\oddoneout';

%subject folders
subjects = {
%                  'su2',...
%                  'su3',...
%                 'su5'
                'su6'
            };
        
% sessions
sessions= {
                'se1',...
                      'se2',...
                      'se3',...
                     'se4',...
%                 'se5' 
                };
            
        
%% Initialise SPM defaults
spm('defaults', 'FMRI');
spm_jobman('initcfg');

for i=1:numel(subjects)
%     switch subjects{i}
%         case 'sub1'
%              sessions= {'sess3',...
%            'sess4',...
%            'sess5',...
%            'sess6'};
%        
%         case 'sub3'
%             sessions= {'sess2',...
%            'sess3',...
%            'sess4'};
%         
%             
%         case 'sub4'
%             sessions= {'sess1',...
%            'sess2',...
%            'sess3',...
%            'sess4'};
%             
%         case 'sub5'
%               sessions= {'sess1',...
%            'sess2',...
%            'sess4',...
%            'sess5'};
%     end
for j = 1:numel(sessions)


% display which subject and session is being processed
    fprintf('Processing "%s" "%s" \n',...
        subjects{i}, sessions{j});
    
matlabbatch = smooth_job(data_path, subjects{i}, sessions{j});
   
%% Save and run job
    % -----------------------
    % This line saves the batch job file as if you would have set it
    % manually in the subject folder. It is a documentation of what you
    % have done here.
      save(fullfile(data_path, subjects{i}, sessions{j}, 'smooth.mat'), 'matlabbatch');

    % This executes the batch as it is specified in the structure
    % matlabbatch ...
     spm_jobman('serial', matlabbatch, '');
     clear matlabbatch;
%end
end
end
    
