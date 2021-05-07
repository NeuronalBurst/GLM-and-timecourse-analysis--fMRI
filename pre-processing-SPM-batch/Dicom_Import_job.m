function matlabbatch = Dicom_Import_job(data_path, ana_path, subjects, sessions)

%% Import Dicom files and convert them to the nifti format

runs = {
             'r1',...
            'r2',...
            'r3',...
            'r4',...
             'struct',...
            'fullEPI'
};    

% if strcmp(subjects,'su2')
%       if strcmp(sessions,'se1')
%           runs = {
%             'r1',...
%              'r4',...
%              'struct',...
%             'fullEPI'};
%       
%       elseif strcmp(sessions, 'se5')
%              runs = {
%             'r2',...
%             'r3',...
%             'struct',...
%             'fullEPI'};
%       else
%           runs = {
%              'r1',...
%             'r2',...
%             'r3',...
%             'r4',...
%             'struct',...
%             'fullEPI'};
%       end
% end

% if strcmp(subjects,'su3')
% if strcmp(sessions,'se2')
%           runs = {
%             'r1',...
%              'r2',...             
%              'r3',...
%              'struct',...
%             'fullEPI'};
%       
%       elseif strcmp(sessions, 'se3')
%              runs = {
%             'r1',...
%             'r2',...
%             'r3',...
%             'r4',... 
%             'r5',... 
%             'struct',...
%             'fullEPI'};
%       else
%           runs = {
%              'r1',...
%             'r2',...
%             'r3',...
%             'r4',...
%             'struct',...
%             'fullEPI'};
% end

for k=1:length(runs)
 
    % Create nifti-volume folder for each session in the subject folder ...
     newfolder = fullfile(ana_path, subjects, sessions, runs{k});
     mkdir(newfolder);

    % Read filenames from Dicom-folder
     import_data= cellstr(spm_select('FPList', fullfile(data_path, subjects,sessions, runs{k}), '.*'));
     if strcmp(runs(k), 'r1')||strcmp(runs(k), 'r2')||strcmp(runs(k), 'r3')||strcmp(runs(k), 'r4')||strcmp(runs(k), 'r5')
     import_data=import_data(6:end); % delete first 5 dummy scans
     end


    matlabbatch{k}.spm.util.import.dicom.data = cellstr(import_data);
    matlabbatch{k}.spm.util.import.dicom.root = 'flat';
    matlabbatch{k}.spm.util.import.dicom.outdir = cellstr(newfolder);
    matlabbatch{k}.spm.util.import.dicom.protfilter = '.*';
    matlabbatch{k}.spm.util.import.dicom.convopts.format = 'nii';
    matlabbatch{k}.spm.util.import.dicom.convopts.icedims = 0;          
         
end