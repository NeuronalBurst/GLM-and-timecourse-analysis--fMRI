clearvars;

marsbar('on')

% MarsBaR version check
v = str2num(marsbar('ver'));
if v < 0.35
  error('Batch script only works for MarsBaR >= 0.35');
end

%% specify path
%Experiment folder
data_path = '/p/himmelbach/nikhil/analysed_data';


%subject folders
subjects = {  
             'sub1',...
               'sub2',...
               'sub4',...
               'sub5',...
               'sub6',...
                'sub7'
            
            };
        
       for i=1:numel(subjects)
           file_path=(fullfile(data_path,subjects{i},'sess1','struct','ewc3sSCmod.nii'));
           roi_path=(fullfile(data_path,subjects{i},'sess1','struct'));
           mars_img2rois(file_path, roi_path,'ewc3sSCmod');
       end