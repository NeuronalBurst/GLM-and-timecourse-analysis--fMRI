function matlabbatch = realign_job(data_path, subjects, sessions)

%% Selection of the functional files 

% runs = {
%              'r2',...
%             'r1',...
%             'r4',...
%             'r3'
% };
% raw_data=cell(1,numel(sessions));
% for j=1:numel(sessions)
% %  if strcmp(subjects, 'su2')
%      if strcmp(sessions(j), 'se1')       
%         runs = {'r1','r4'};
%                 
%     elseif strcmp(sessions(j),'se2')
%         runs = {'r2','r1','r4','r3'};
% 
%     elseif strcmp(sessions(j),'se3')
%         runs = {'r3','r4','r2','r1'};
% 
%     elseif strcmp(sessions(j),'se4')
%         runs = {'r4','r3','r1','r2'};
%         
%     elseif strcmp(sessions(j),'se5')
%     runs = {'r2','r3'};
% 
%      end
% %  end
% 
% % % if strcmp(subjects, 'su3')
% % 
% %      if strcmp(sessions,'se1')
% %         runs = {'r1','r2','r3','r4'};
% %      elseif  strcmp(sessions, 'se2')       
% %         runs = {'r2','r1','r3'};
% % 
% %     elseif strcmp(sessions,'se3')
% %         runs = {'r3','r4','r2','r1','r5'};
% % 
% %     elseif strcmp(sessions,'se4')
% %         runs = {'r4','r3','r1','r2'};
% %      end
% %      
% %  end

if strcmp(subjects, 'su5')||strcmp(subjects, 'su6')

     if strcmp(sessions, 'se3')       
        runs = {'r3','r4','r2','r1'};
     elseif  strcmp(sessions, 'se4')       
        runs = {'r4','r3','r1','r2'};
     end

end  

raw_data=[];
 for k=1:numel(runs)
                raw_data{k} = cellstr(spm_select('FPList', fullfile(data_path, subjects, sessions, runs{k}), '^f19.*')); 
%                 raw_data_runs=[raw_data_runs; raw_data_temp];
 end
        
% raw_data{j}=raw_data_runs;
% end
%% Realignment of the functional data

matlabbatch{1}.spm.spatial.realign.estwrite.data = raw_data;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 1.0;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
