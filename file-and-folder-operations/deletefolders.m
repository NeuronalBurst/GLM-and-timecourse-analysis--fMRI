clearvars
%% specify path
%Experiment folder
data_path = 'G:\Seqtap_data2';

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
%         list_dest=char(fullfile( 'G:\Seqtap_data2', subjects(i), sessions(j)));
            status1=rmdir(list_source1,'s');
            status2=rmdir(list_source2,'s');
            
    end
end
