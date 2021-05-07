clearvars
%% specify path
%Experiment folder
data_path = 'G:\Seqtap_data2';

%subject folders
subjects = {
    %     'sub1',...
    %                'sub3',...
    'sub4',...
    'sub5'
    };

for i=1:numel(subjects)
    switch subjects{i}
        case 'sub1'
            sessions= {'sess3',...
                'sess4',...
                'sess5',...
                'sess6'};
            
        case 'sub3'
            sessions= {'sess2',...
                'sess3',...
                'sess4'};
            
            
        case 'sub4'
            sessions= {'sess1',...
                'sess2',...
                'sess3',...
                'sess4'};
            
        case 'sub5'
            sessions= {'sess1',...
                'sess2',...
                'sess4',...
                'sess5'};
    end
    for j = 1:numel(sessions)
        if strcmp(subjects(i), 'sub4')
            if strcmp(sessions(j), 'sess1')
                runs = {'run2','run3','run4'};
                
            elseif strcmp(sessions(j),'sess2')
                runs = {'run1','run3'};
                
            elseif strcmp(sessions(j),'sess3')
                runs = {'run1','run2','run3','run4'};
                
            elseif strcmp(sessions(j),'sess4')
                runs = {'run1','run2','run3'};
                
            end
            
        elseif strcmp(subjects(i), 'sub5')
            
            if strcmp(sessions(j),'sess1')
                runs = {'run1','run2','run3','run4'};
                
            elseif strcmp(sessions(j),'sess2')
                runs = {'run1','run2','run3','run4'};
                
            elseif strcmp(sessions(j),'sess4')
                runs = {'run1','run2','run3','run4'};
                
            elseif strcmp(sessions(j),'sess5')
                runs = {'run1','run2','run3'};
                
            end
            
        else
            runs = {'run1','run2','run3','run4'};
        end
        for k=1:numel(runs)
            list_source=cellstr(spm_select('FPList',fullfile(data_path,subjects(i),sessions(j), runs(k)), '^fSC.*'));
            list_dest=char(fullfile('F:\temp', subjects(i), sessions(j), runs(k)));
            mkdir(char(list_dest));
            %       cd(char(fullfile(data_path,subjects(i),sessions(j), runs(k))));
            for n=1:length(list_source)
                copyfile(list_source{n},list_dest)
            end
        end
    end
end