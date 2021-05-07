% for i=1:numel(sessions)
%     file_list=cellstr(spm_select('FPListRec','/p/himmelbach/nikhil/analysed_data/sub1/sess2', '^SPM.mat'));
% %     file_list=cellstr(file_list);
%      for k=1:length(file_list)
%      delete(file_list{k,1});
%      %delete(file_list);
%      end
% end

subjects = {
               'sub1',...
                 'sub2',...
               'sub4',...
               'sub5',...
               'sub6',...
                'sub7'
            };
        
sessions= {
                     'sess1',...   
                     'sess2',...
                      'sess3',...
                     'sess4'
                };
            

for i=1:numel(subjects)
for j=1:numel(sessions)
    
    runs = {
             'run1',...
            'run2',...
            'run3',...
            'run4'};
    
    if strcmp(subjects{i},'sub2')
      if strcmp(sessions{j},'sess1')
          runs = {
            'run1',...
             'run2'
            };
      end
      if strcmp(sessions{j}, 'sess4')
             runs = {
             'run1',...
            'run2',...
            'run3',...
            'run4',...
            'run5',...
            'run6'
           };
      end
    end
for k=1:numel(runs)    
    file_list=cellstr(spm_select('FPList',fullfile('/p/himmelbach/nikhil/analysed_data',subjects{i}, sessions{j}, runs{k}), '^fSC.*'));
%     file_list=cellstr(file_list);
     for l=1:5
     delete(file_list{l,1});
     %delete(file_list);
     end
end
end
end

