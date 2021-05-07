clearvars;
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
    'run4'
    };

%% Extraction of onsets and durations from the timing files

timing_files={'TIM_R1.CSV',...
    'TIM_R2.CSV',...
    'TIM_R3.CSV',...
    'TIM_R4.CSV'
    };


for s=1:numel(sessions)
    
    if strcmp(sessions(s),'sess1')
        for l=1:length(timing_files)
            
            fileId=fopen(char(fullfile('/p/himmelbach/nikhil/timing_files', subjects,sessions(s),timing_files{l})));
            
            
            %% For Run 1
            if strcmp(timing_files{l},'TIM_R1.CSV')==1
                
                % read the CSV file according to the desired format
                temp_time=cell2mat(textscan(fileId,'%f %f %f', 'HeaderLines',1,'Delimiter', ','));
                fclose(fileId);
                temp_time1=temp_time(:,1)-49.3-10; % 49.3 - first onset time of the first run, 10 for deleting the first 5 dummy scans

                 RT_all1=temp_time(:,2);
                onsets_all=temp_time1+RT_all1;
                
                j=1:4:length(onsets_all);
                k=j(1:2:end);
                for i=1:numel(k)
                    onsets1(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                onsets.sess(s).run(1).block1=onsets1(5:end); % since the first 4 onsets are negative
                
                k=j(2:2:end);
                for i=1:numel(k)
                    onsets.sess(s).run(1).block2((j(i):j(i)+3),1)=onsets_all(k(i):k(i)+3);
                end
                RT_mov_avg=sum(RT_all1(5:end))/length(RT_all1(5:end)); % used in run 2

                continue
            end
            
            
            %% For run 2
            
            if strcmp(timing_files{l},'TIM_R2.CSV')
                
                fgetl(fileId);
                n=1;
                temp_time={};
                while ~feof(fileId)
                    line=fgetl(fileId);
                    if startsWith(line,'bpL') || startsWith(line,'bpR')
                        
                        temp_time(n,:)=textscan(line,'%*s %f %f','Delimiter', ',');
                        n=n+1;
                        
                    else
                        temp_time(n,:)=textscan(line,'%f %f','Delimiter', ',');
                        n=n+1;
                    end
                end
                fclose(fileId);
                
                temp_time=cell2mat(temp_time);
                temp_time1=temp_time(:,1)-12.081700 - 10; % 10 for deleting the first 5 dummy scans
                
                onsets_all=temp_time1+RT_mov_avg;
                
                j=1:4:length(onsets_all);
                k=j(1:2:end);
                for i=1:numel(k)
                    onsets1(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                onsets.sess(s).run(2).block1=onsets1(5:end); % since the first 4 onsets are negative
                
                k=j(2:2:end);
                for i=1:numel(k)
                    onsets.sess(s).run(2).block2(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                continue
            end
            
            %% For run 3
            
            if strcmp(timing_files{l},'TIM_R3.CSV')
                
                fgetl(fileId);
                n=1;
                temp_time={};
                while ~feof(fileId)
                    line=fgetl(fileId);
                    if startsWith(line,'NA')
                        
                        temp_time(n,:)=textscan(line,'%*s %f %f %f','Delimiter', ',');
                        n=n+1;
                        
                    elseif startsWith(line,'bpL') || startsWith(line,'bpR')
                        
                        temp_time(n,:)=textscan(line,'%*s %f %f %u %*s','Delimiter', ',');
                        n=n+1;
                    else
                        temp_time(n,:)=textscan(line,'%f %f %u %*s','Delimiter', ',');
                        n=n+1;
                    end
                end
                fclose(fileId);
                
                % convert all the empty cells into NaN so that the cell array can then be converted to an array of doubles with the cell2 mat function
                for n=1:length(temp_time)
                    if isempty(temp_time{n,3})
                        temp_time{n,3}=NaN;
                    end
                end
                
                temp_time=cell2mat(temp_time);
                temp_time1=temp_time(:,1)-13.388454+2-10; % 2 is for the first TR count, 10 for deleting the first 5 dummy scans

                RT_all=temp_time(:,2);
                onsets_all=temp_time1;
                j=1:4:length(onsets_all);
                k=j(1:2:end);
                for i=1:numel(k)
                    onsets1(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                    RT1(j(i):j(i)+3,1)=RT_all(k(i):k(i)+3);
                end
                onsets.sess(s).run(3).block1=onsets1(5:end)+RT1(5:end); % since the first 4 onsets are negative
                
                k=j(2:2:end);
                for i=1:numel(k)
                    onsets2(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                
                RT1_avg=sum(RT1(5:end))\length(RT1(5:end));
                onsets.sess(s).run(3).block2=onsets2+RT1_avg;
                continue
            end
            
            
            
            %% For run 4
            if strcmp(timing_files{l},'TIM_R4.CSV')
                
                fgetl(fileId);
                n=1;
                temp_time={};
                while ~feof(fileId)
                    line=fgetl(fileId);
                    if startsWith(line,'NA')
                        temp_time(n,:)=textscan(line,'%*s %f %f %f','Delimiter', ',');
                        n=n+1;
                        
                    elseif startsWith(line,'bpL') || startsWith(line,'bpR')
                        
                        temp_time(n,:)=textscan(line,'%*s %f %f %u %*s','Delimiter', ',');
                        n=n+1;
                    else
                        temp_time(n,:)=textscan(line,'%f %f %u %*s','Delimiter', ',');
                        n=n+1;
                    end
                end
                fclose(fileId);
                
                % convert all the empty cells into NaN so that the cell array can then be converted to an array of doubles with the cell2 mat function
                for n=1:length(temp_time)
                    if isempty(temp_time{n,3})
                        temp_time{n,3}=NaN;
                    end
                end
                
                temp_time=cell2mat(temp_time);
                temp_time1=temp_time(:,1)-12.737624+2-10; % 2 is for the first TR count, 10 for deleting the first 5 dummy scans

                RT_all=temp_time(:,2);
                onsets_all=temp_time1;
                j=1:4:length(onsets_all);
                k=j(1:2:end);
                for i=1:numel(k)
                    onsets1(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                    RT1(j(i):j(i)+3,1)=RT_all(k(i):k(i)+3);
                end
                onsets.sess(s).run(4).block1=onsets1(5:end)+RT1(5:end); % since the first 4 onsets are negative
                
                k=j(2:2:end);
                for i=1:numel(k)
                    onsets2(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                
                RT1_avg=sum(RT1(5:end))\length(RT1(5:end));
                onsets.sess(s).run(4).block2=onsets2+RT1_avg;
                
                continue
            end
        end
        continue
    end
    
    if strcmp(sessions(s),'sess2')
        for l=1:length(timing_files)
            
            fileId=fopen(char(fullfile('/p/himmelbach/nikhil/timing_files', subjects,sessions(s),timing_files{l})));
            
            
            %% For Run 1
            if strcmp(timing_files{l},'TIM_R1.CSV')==1
                
                % read the CSV file according to the desired format
                temp_time=[];
                temp_time=cell2mat(textscan(fileId,'%f %f %f', 'HeaderLines',1,'Delimiter', ','));
                fclose(fileId);
                temp_time1=temp_time(:,1)-12.877869+8-10; % 8 is for the 4th TR count, 10 for deleting the first 5 dummy scans

                RT_all1=temp_time(:,2);
                onsets_all=temp_time1+RT_all1;
                
                j=1:4:length(onsets_all);
                k=j(1:2:end);
                for i=1:numel(k)
                    onsets1(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                onsets.sess(s).run(1).block1=onsets1(2:end); % since only the first onset is negative
                
                k=j(2:2:end);
                for i=1:numel(k)
                    onsets.sess(s).run(1).block2((j(i):j(i)+3),1)=onsets_all(k(i):k(i)+3);
                end
                RT_mov_avg=sum(RT_all1(2:end))/length(RT_all1(2:end)); %used in run 2 

                continue
            end
            
            
            %% For run 2
            
            if strcmp(timing_files{l},'TIM_R2.CSV')
                
                fgetl(fileId);
                n=1;
                m=1;
                temp_time={};
                bp_trial=[];
                while ~feof(fileId)
                    line=fgetl(fileId);
                    if startsWith(line,'bpL')
                        bp_trial(m,1)=n;
                        m=m+1;
                        temp_time(n,:)=textscan(line,'%*s %f %f','Delimiter', ';');
                        n=n+1;
                    else
                        temp_time(n,:)=textscan(line,'%f %f','Delimiter', ';');
                        n=n+1;
                    end
                end
                fclose(fileId);
                
                temp_time=cell2mat(temp_time);
                temp_time1=temp_time(:,1)-13.584917+2-10; % 2 for the first TR count, 10 for deleting the first 5 dummy scans

                onsets_all=temp_time1+RT_mov_avg;
                
                j=1:4:length(onsets_all);
                k=j(1:2:end);
                for i=1:numel(k)
                    onsets1(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                onsets.sess(s).run(2).block1=onsets1(5:end);
                
                k=j(2:2:end);
                for i=1:numel(k)
                    onsets.sess(s).run(2).block2(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                
                
                % extract button press timing and add the reaction time to it to get the onsets for button press
                for n=1:length(bp_trial)
                    onsets.sess(s).run(2).bp(n,1)=temp_time1(bp_trial(n));
                end
                continue
            end
            
            %% For run 3
            
            if strcmp(timing_files{l},'TIM_R3.CSV')
                
                fgetl(fileId);
                n=1;
                m=1;
                temp_time={};
                bp_trial=[];
                while ~feof(fileId)
                    line=fgetl(fileId);
                    if startsWith(line,'NA')
                        temp_time(n,:)=textscan(line,'%*s %f %f %f','Delimiter', ',');
                        n=n+1;
                        
                    elseif startsWith(line,'bpL')
                        bp_trial(m,1)=n;
                        m=m+1;
                        temp_time(n,:)=textscan(line,'%*s %f %f %u %*s','Delimiter', ',');
                        n=n+1;
                    else
                        temp_time(n,:)=textscan(line,'%f %f %u %*s','Delimiter', ',');
                        n=n+1;
                    end
                end
                fclose(fileId);
                
                % convert all the empty cells into NaN so that the cell array can then
                % be converted to an array of doubles with the cell2 mat function
                for n=1:length(temp_time)
                    if isempty(temp_time{n,3})
                        temp_time{n,3}=NaN;
                    end
                end
                temp_time=cell2mat(temp_time);
                temp_time1=temp_time(:,1)-12.181794+4-10; % 4 is for the 4th TR count, 10 for deleting the first 5 dummy scans

                RT_all=temp_time(:,2);
                onsets_all=temp_time1;
                j=1:4:length(onsets_all);
                k=j(1:2:end);
                for i=1:numel(k)
                    onsets1(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                    RT1(j(i):j(i)+3,1)=RT_all(k(i):k(i)+3);
                end
                onsets.sess(s).run(3).block1=onsets1(4:end)+RT1(4:end);
                
                k=j(2:2:end);
                for i=1:numel(k)
                    onsets2(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                
                RT1_avg=sum(RT1(4:end))\length(RT1(4:end));
                onsets.sess(s).run(3).block2=onsets2+RT1_avg;
                
                % extract button press timing and add the reaction time to it to get the
                % onsets for button press
                
                for n=1:length(bp_trial)
                    onsets.sess(s).run(3).bp(n,1)=temp_time1(bp_trial(n));
                end
                continue
            end
            
            
            
            %% For run 4
            if strcmp(timing_files{l},'TIM_R4.CSV')
                
                fgetl(fileId);
                n=1;
                m=1;
                temp_time={};
                bp_trial=[];
                while ~feof(fileId)
                    line=fgetl(fileId);
                    if startsWith(line,'NA')
                        temp_time(n,:)=textscan(line,'%*s %f %f %f','Delimiter', ',');
                        n=n+1;
                        
                    elseif startsWith(line,'bpL')
                        bp_trial(m,1)=n;
                        m=m+1;
                        temp_time(n,:)=textscan(line,'%*s %f %f %u %*s','Delimiter', ',');
                        n=n+1;
                    else
                        temp_time(n,:)=textscan(line,'%f %f %u %*s','Delimiter', ',');
                        n=n+1;
                    end
                end
                fclose(fileId);
                
                % convert all the empty cells into NaN so that the cell array can then be converted to an array of doubles with the cell2 mat function
                for n=1:length(temp_time)
                    if isempty(temp_time{n,3})
                        temp_time{n,3}=NaN;
                    end
                end
                
                temp_time=cell2mat(temp_time);
                temp_time1=temp_time(:,1)-12.628468+4-10; %2nd TR count,10 for deleting the first 5 dummy scans

                RT_all=temp_time(:,2);
                onsets_all=temp_time1;
                j=1:4:length(onsets_all);
                k=j(1:2:end);
                for i=1:numel(k)
                    onsets1(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                    RT1(j(i):j(i)+3,1)=RT_all(k(i):k(i)+3);
                end
                onsets.sess(s).run(4).block1=onsets1(4:end)+RT1(4:end);
                
                k=j(2:2:end);
                for i=1:numel(k)
                    onsets2(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                
                RT1_avg=sum(RT1(4:end))\length(RT1(4:end));
                onsets.sess(s).run(4).block2=onsets2+RT1_avg;
                
                % extract button press timing and add the reaction time to it to get the
                % onsets for button press
                
                for n=1:length(bp_trial)
                    onsets.sess(s).run(4).bp(n,1)=temp_time1(bp_trial(n));
                end
                
                continue
            end
        end
        continue
    end
    
    if strcmp(sessions(s),'sess3')||strcmp(sessions(s),'sess4')
        
        for l=1:length(timing_files)
            
            fileId=fopen(char(fullfile('/p/himmelbach/nikhil/timing_files', subjects,sessions(s),timing_files{l})));
            
            
            %% For Run 1
            if strcmp(timing_files{l},'TIM_R1.CSV')==1
                
                % read the CSV file according to the desired format
                temp_time=[];
                temp_time=cell2mat(textscan(fileId,'%f %f %f', 'HeaderLines',1,'Delimiter', ','));
                fclose(fileId);
                
                temp_time1=temp_time(:,1)-10; % 10 for deleting the first 5 dummy scans
                
                RT_all1=temp_time(:,2);
                
                onsets_all=temp_time1+RT_all1;
 
                j=1:4:length(onsets_all);
                k=j(1:2:end);
                for i=1:numel(k)
                    onsets.sess(s).run(1).block1(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                
                k=j(2:2:end);
                for i=1:numel(k)
                    onsets.sess(s).run(1).block2((j(i):j(i)+3),1)=onsets_all(k(i):k(i)+3);
                end
                RT_mov_avg=sum(RT_all1)/length(RT_all1); % used in run 2
                continue
            end
            
            
            %% For run 2
            if strcmp(timing_files{l},'TIM_R2.CSV')==1
                
                % read the CSV file according to the desired format
                
                fgetl(fileId);
                n=1;
                m=1;
                bp_trial=[];
                temp_time={};
                while ~feof(fileId)
                    line=fgetl(fileId);
                    if startsWith(line,'bpL')
                        bp_trial(m,1)=n;
                        m=m+1;
                        temp_time(n,:)=textscan(line,'%*s %f %f','Delimiter', ',');
                        n=n+1;
                    else
                        temp_time(n,:)=textscan(line,'%f %f','Delimiter', ',');
                        n=n+1;
                    end
                end
                fclose(fileId);
                
                temp_time=cell2mat(temp_time);
                
                temp_time1=temp_time(:,1)-10; % 10 for deleting the first 5 dummy scans
                
                onsets_all=temp_time1+RT_mov_avg;
                
                j=1:4:length(onsets_all);
                k=j(1:2:end);
                for i=1:numel(k)
                    onsets.sess(s).run(2).block1(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                
                k=j(2:2:end);
                for i=1:numel(k)
                    onsets.sess(s).run(2).block2(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end

                % extract button press timing and add the reaction time to it to get the onsets for button press
                for n=1:length(bp_trial)
                    onsets.sess(s).run(2).bp(n,1)=temp_time1(bp_trial(n));
                end
                continue
            end
            
            %% For run 3
            if strcmp(timing_files{l},'TIM_R3.CSV')==1
                
                % read the CSV file according to the desired format
                fgetl(fileId);
                n=1;
                m=1;
                bp_trial=[];
                temp_time={};
                while ~feof(fileId)
                    line=fgetl(fileId);
                    if startsWith(line,'NA')
                        temp_time(n,:)=textscan(line,'%*s %f %f %f','Delimiter', ',');
                        n=n+1;
                        
                    elseif startsWith(line,'bpL')
                        bp_trial(m,1)=n;
                        m=m+1;
                        temp_time(n,:)=textscan(line,'%*s %f %f %u %*s','Delimiter', ',');
                        n=n+1;
                    else
                        temp_time(n,:)=textscan(line,'%f %f %u %*s','Delimiter', ',');
                        n=n+1;
                    end
                end
                fclose(fileId);
                
                % convert all the empty cells into NaN so that the cell array can then
                % be converted to an array of doubles with the cell2 mat function
                for n=1:length(temp_time)
                    if isempty(temp_time{n,3})
                        temp_time{n,3}=NaN;
                    end
                end
                
                temp_time=cell2mat(temp_time);
                
                onsets_all=temp_time(:,1)-10; % 10 for deleting the first 5 dummy scans
                RT_all=temp_time(:,2);
                
                j=1:4:length(onsets_all);
                k=j(1:2:end);
                for i=1:numel(k)
                    onsets1(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                    RT1(j(i):j(i)+3,1)=RT_all(k(i):k(i)+3);
                end
                onsets.sess(s).run(3).block1=onsets1+RT1;
                
                k=j(2:2:end);
                for i=1:numel(k)
                    onsets2(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                RT1_avg=sum(RT1)\length(RT1);
                onsets.sess(s).run(3).block2=onsets2+RT1_avg;
                
                % extract button press timing and add the reaction time to it to get the
                % onsets for button press
                
                for n=1:length(bp_trial)
                    onsets.sess(s).run(3).bp(n,1)=onsets_all(bp_trial(n));
                end
                
                continue
            end
            
            %% For run 4
            
            if strcmp(timing_files{l},'TIM_R4.CSV')==1
                
                % read the CSV file according to the desired format
                
                fgetl(fileId);
                n=1;
                m=1;
                bp_trial=[];
                temp_time={};
                while ~feof(fileId)
                    line=fgetl(fileId);
                    if startsWith(line,'NA')
                        temp_time(n,:)=textscan(line,'%*s %f %f %f','Delimiter', ',');
                        n=n+1;
                        
                    elseif startsWith(line,'bpL')
                        bp_trial(m,1)=n;
                        m=m+1;
                        temp_time(n,:)=textscan(line,'%*s %f %f %u %*s','Delimiter', ',');
                        n=n+1;
                    else
                        temp_time(n,:)=textscan(line,'%f %f %u %*s','Delimiter', ',');
                        n=n+1;
                    end
                end
                fclose(fileId);
                
                
                % convert all the empty cells into NaN so that the cell array can then
                % be converted to an array of doubles with the cell2 mat function
                for n=1:length(temp_time)
                    if isempty(temp_time{n,3})
                        temp_time{n,3}=NaN;
                    end
                end
                temp_time=cell2mat(temp_time);
                
                onsets_all=temp_time(:,1)-10; % 10 for deleting the first 5 dummy scans
                RT_all=temp_time(:,2);
                
                j=1:4:length(onsets_all);
                k=j(1:2:end);
                for i=1:numel(k)
                    onsets1(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                    RT1(j(i):j(i)+3,1)=RT_all(k(i):k(i)+3);
                end
                onsets.sess(s).run(4).block1=onsets1+RT1;
                
                k=j(2:2:end);
                for i=1:numel(k)
                    onsets2(j(i):j(i)+3,1)=onsets_all(k(i):k(i)+3);
                end
                RT1_avg=sum(RT1)\length(RT1);
                onsets.sess(s).run(4).block2=onsets2+RT1_avg;
                
                % extract button press timing and add the reaction time to it to get the
                % onsets for button press
                
                for n=1:length(bp_trial)
                    onsets.sess(s).run(4).bp(n,1)=onsets_all(bp_trial(n));
                end
                
                continue
            end
        end
        continue
    end
end