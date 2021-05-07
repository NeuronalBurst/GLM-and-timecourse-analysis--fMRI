clearvars
%% specify path
%Experiment folder
data_path = 'G:\Seqtap_data2';

%subject folders
subjects = {
        'sub1',...
%                    'sub3',...
%     'sub4',...
%     'sub5'
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
%             list_source=cellstr(spm_select('FPListRec',fullfile(data_path,subjects(i),sessions(j)), '^wrfSC.*'));
%             list_source2=cellstr(spm_select('FPListRec',fullfile(data_path,subjects(i),sessions(j)), '^wmeanfSC.*'));
             list_source3=cellstr(spm_select('FPListRec',fullfile(data_path,subjects(i),sessions(j)), '^sw.*'));
%             for n=1:length(list_source)
%             delete(char(list_source(n)));
%             end
%             for n=1:length(list_source2)
%             delete(char(list_source2(n)));
%             end
            for n=1:length(list_source3)
            delete(char(list_source3(n)));
            end
    end
end
