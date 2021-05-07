clearvars
%% specify path
%Experiment folder
data_path = 'G:\Seqtap_data';

%subject folders
subjects = {
        'sub1',...
                   'sub3',...
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
    
    for j=1:numel(sessions)
        list_source1=char(fullfile(data_path,subjects(i),sessions(j), 'fullEPI'));
        list_source2=char(fullfile(data_path,subjects(i),sessions(j), 'struct'));
        list_dest1=char(fullfile( 'G:\Seqtap_data2', subjects(i), sessions(j), 'fullEPI'));
        list_dest2=char(fullfile( 'G:\Seqtap_data2', subjects(i), sessions(j),'struct'));

            status1=copyfile(list_source1,list_dest1);
            status2=copyfile(list_source2,list_dest2);
            
    end
end
