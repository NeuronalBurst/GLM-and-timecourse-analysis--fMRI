clearvars;
%Experiment folder
data_path = '/p/himmelbach/nikhil/analysed_data';

%subject folders
subjects = {
     'sub1'

    };

%sessions
sessions= {
    'sess1',...
    'sess2',...
    'sess3',...
    'sess4'
    };

%runs
runs = {
            'run1',...
             'run2',...
              'run3',...
              'run4',...
            };
        
r_num=1;
run_data={zeros(1,16)}; %optimisation for speed
regress_file={zeros(1,16)};
for s = 1:numel(sessions)
    
    if strcmp(sessions{s},'sess1')||strcmp(sessions{s},'sess2')
        
        for r_ind=1:length(runs)
            run_data{r_num} = cellstr(spm_select('FPList',fullfile(data_path,subjects,sessions{s},'interpol_data', runs{r_ind}), '^swrTR.*'));
            
            %edit the regressor file to delete the first 5 rows
            
            regress_file(r_num)= cellstr(spm_select('FPList', fullfile(data_path, subjects, sessions{s},'interpol_data',runs{r_ind}), '^erp.*'));
            
            if isempty(regress_file{r_num})
                regress_file_temp= spm_select('List', fullfile(data_path, subjects, sessions{s},'interpol_data',runs{r_ind}), '^rp.*');
                
                fid = fopen(char(fullfile(data_path, subjects, sessions{s},'interpol_data',runs{r_ind}, regress_file_temp)), 'r') ;    % Open source file.
                for i=1:5
                    fgetl(fid) ; % Read/discard line.
                end
                buffer = fread(fid, Inf) ;  % Read rest of the file.
                fclose(fid);
                
                fid = fopen(char(fullfile(data_path, subjects, sessions{s},'interpol_data',runs{r_ind},(sprintf('%s%s','e',regress_file_temp)))), 'w')  ;   % Open destination file.
                fwrite(fid, buffer);                         % Save to the file.
                fclose(fid) ;
                
                regress_file(r_num)= cellstr(spm_select('FPList', fullfile(data_path, subjects, sessions{s},'interpol_data', runs{r_ind}), '^erp.*'));
            end
            r_num=r_num+1;
        end
        
    else
        
        for r_ind=1:length(runs)
            
            run_data{r_num} = cellstr(spm_select('FPList',fullfile(data_path,subjects,sessions{s}, runs{r_ind}), '^swrfSC.*'));
            
            %edit the regresser file to delete the first 5 rows
            
            regress_file(r_num)= cellstr(spm_select('FPList', fullfile(data_path, subjects, sessions{s}, runs{r_ind}), '^erp.*'));
            if isempty(regress_file{r_num})
                regress_file_temp= spm_select('List', fullfile(data_path, subjects, sessions{s},runs{r_ind}), '^rp.*');
                
                fid = fopen(char(fullfile(data_path, subjects, sessions{s},runs{r_ind}, regress_file_temp)), 'r') ;    % Open source file.
                for i=1:5
                    fgetl(fid) ; % Read/discard line.
                end
                buffer = fread(fid, Inf) ;  % Read rest of the file.
                fclose(fid);
                
                fid = fopen(char(fullfile(data_path, subjects, sessions{s},runs{r_ind},(sprintf('%s%s','e',regress_file_temp)))), 'w')  ;   % Open destination file.
                fwrite(fid, buffer);                         % Save to the file.
                fclose(fid) ;
                
                regress_file(r_num)= cellstr(spm_select('FPList', fullfile(data_path, subjects, sessions{s}, runs{r_ind}), '^erp.*'));
            end
            r_num=r_num+1;
        end
    end
end