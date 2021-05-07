r_num=1;
run_data={zeros(1,10)}; %optimisation for speed

for s=1:3
if strcmp(sessions(s),'sess1')
   runs = {
            'run1',...
            'run2'   
            };
        for run_ind=1:length(runs)
run_data{r_num} = cellstr(spm_select('FPList',fullfile(data_path,subjects,sessions(s),'interpol_data', runs{run_ind}), '^swrTR.*'));
r_num=r_num+1;
        end
 else
     runs = {
               'run1',...
               'run2',...
               'run3',...
               'run4'
            }; 
   
        for run_ind=1:length(runs)
    
run_data{r_num} = cellstr(spm_select('FPList',fullfile(data_path,subjects,sessions(s), runs{run_ind}), '^swrfSC.*'));

r_num=r_num+1;

        end
end
end