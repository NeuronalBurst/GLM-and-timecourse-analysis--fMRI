clearvars;

%% specify path
%Experiment folder
data_path = 'G:/analysed_data';

%subject folders
subjects = {  
%               'sub1',...
%               'sub2',...
               'sub4',...
%                'sub5',...
%                'sub6',...
%                 'sub7'

               
            
            };
        
%sessions
sessions= {
                'sess1',...
                 'sess2',...
                 'sess3',...
                 'sess4'
           };
        

%% Initialise SPM defaults
spm('defaults', 'FMRI');
spm_jobman('initcfg');


for i=1:numel(subjects)
% realigned_data={};
normalised_data={};


for j = 1:numel(sessions)


% display which subject and session is being processed
    

if strcmp(subjects{i},'sub1')&& strcmp(sessions{j},'sess1')
         normalised_data = vertcat(normalised_data, cellstr(spm_select('FPListRec', fullfile(data_path, subjects{i}, sessions{j},'interpol_data'),'^wrTR.*')));
     
 elseif strcmp(subjects{i},'sub1')&& strcmp(sessions{j},'sess2')
 
         normalised_data = vertcat(normalised_data, cellstr(spm_select('FPListRec', fullfile(data_path, subjects{i}, sessions{j},'interpol_data'),'^wrTR.*')));
     
     elseif strcmp(subjects{i},'sub2')&& strcmp(sessions{j},'sess1')
          
            normalised_data = vertcat(normalised_data, cellstr(spm_select('FPListRec', fullfile(data_path, subjects{i}, sessions{j},'interpol_data'),'^wrTR.*')));
          
      
     else
              normalised_data = vertcat(normalised_data, cellstr(spm_select('FPListRec', fullfile(data_path, subjects{i}, sessions{j}),'^wrfSC.*')));
end 

%  if strcmp(subjects{i},'sub1')&& strcmp(sessions{j},'sess1')
%          realigned_data = vertcat(realigned_data, cellstr(spm_select('FPListRec', fullfile(data_path, subjects{i}, sessions{j},'interpol_data'),'^rTR.*')));
%      
%  elseif strcmp(subjects{i},'sub1')&& strcmp(sessions{j},'sess2')
%  
%          realigned_data = vertcat(realigned_data, cellstr(spm_select('FPListRec', fullfile(data_path, subjects{i}, sessions{j},'interpol_data'),'^rTR.*')));
%      
%      elseif strcmp(subjects{i},'sub2')&& strcmp(sessions{j},'sess1')
%           
%             realigned_data = vertcat(realigned_data, cellstr(spm_select('FPListRec', fullfile(data_path, subjects{i}, sessions{j},'interpol_data'),'^rTR.*')));
%           
%       
%      else
%               realigned_data = vertcat(realigned_data, cellstr(spm_select('FPListRec', fullfile(data_path, subjects{i}, sessions{j}),'^rfSC.*')));
% end 
%          



% end 
         
 
end

fprintf('Processing "%s" \n',...
        subjects{i});

matlabbatch{1}.spm.util.cat.vols = normalised_data;
% matlabbatch{1}.spm.util.cat.name = 'sub4D_realigned.nii';
matlabbatch{1}.spm.util.cat.name = 'sub4D.nii';

matlabbatch{1}.spm.util.cat.dtype = 4;

 save(fullfile(data_path, subjects{i}, 'sub4D.mat'), 'matlabbatch');
%   save(fullfile(data_path, subjects{i}, 'sub4D_realigned.mat'), 'matlabbatch');




end
 spm_jobman('serial', matlabbatch, '');




