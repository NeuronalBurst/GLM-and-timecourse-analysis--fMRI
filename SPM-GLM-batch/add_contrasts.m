clearvars
%  subjects={'sub1','sub2','sub4','sub5','sub6','sub7'};
  subjects={'sub4','sub7'};



for s=1:numel(subjects)
    
 spm('defaults', 'FMRI');
spm_jobman('initcfg');

spm_mat=fullfile('F:\stim_data', subjects(s),'results_MovOnsets_AllReg','SPM.mat');
% load('F:\stim_data\all_sub_cons.mat');
 
%% Build contrast vectors
if strcmp(subjects{s}, 'sub1')
    
    
    cond_names={ 
    'VM','SM','reg','reg','reg','reg','reg','reg','reg',...
    'VS','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'VM','VS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'SM','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'VM','SM','reg','reg','reg','reg','reg','reg','reg',...
    'VS','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'VM','VS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'SM','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
    };

VM_pos=[];
VS_pos=[];
SM_pos=[];
SS_pos=[];
bp_pos=[];

for n=1:length(cond_names)
    if strcmp(cond_names(n),'VM')
        VM_pos=[VM_pos n];
    elseif strcmp(cond_names(n),'VS')
        VS_pos=[VS_pos n];
    elseif strcmp(cond_names(n),'SM')
        SM_pos=[SM_pos n];
    elseif strcmp(cond_names(n),'SS')
        SS_pos=[SS_pos n];
    elseif strcmp(cond_names(n),'bp')
        bp_pos=[bp_pos n];
        
    end
end


vector_VMvs=zeros(1,86);
vector_VMvs(VM_pos)=1/length(VM_pos);
vector_VMvs(VS_pos)=-(1/length(VS_pos));

vector_vmVS=zeros(1,86);
vector_vmVS(VM_pos)=-(1/length(VM_pos));
vector_vmVS(VS_pos)=(1/length(VS_pos));

vector_SMss=zeros(1,86);
vector_SMss(SM_pos)=1/length(SM_pos);
vector_SMss(SS_pos)=-(1/length(SS_pos));

vector_smSS=zeros(1,86);
vector_smSS(SM_pos)=-(1/length(SM_pos));
vector_smSS(SS_pos)=(1/length(SS_pos));

vector_VMsm=zeros(1,86);
vector_VMsm(VM_pos)=(1/length(VM_pos));
vector_VMsm(SM_pos)=-(1/length(SM_pos));

vector_vmSM=zeros(1,86);
vector_vmSM(VM_pos)=-(1/length(VM_pos));
vector_vmSM(SM_pos)=(1/length(SM_pos));


elseif strcmp(subjects{s}, 'sub2')
    
    cond_names={ 'VM','SM','reg','reg','reg','reg','reg','reg','reg',...
                'VS','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
                'VM','VS','bp','reg','reg','reg','reg','reg','reg','reg',...
                'SM','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
                 'VM','SM','reg','reg','reg','reg','reg','reg','reg',...
                 'VS','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
                 'VM','VS','bp','reg','reg','reg','reg','reg','reg','reg',...
                 'SM','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
                 'VM','SM','reg','reg','reg','reg','reg','reg','reg',...
                 'VS','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
                 'VM','VS','bp','reg','reg','reg','reg','reg','reg','reg',...
                 'SM','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
                 'VM','VS','bp','reg','reg','reg','reg','reg','reg','reg',...
                 'SM','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
    };

VM_pos=[];
VS_pos=[];
SM_pos=[];
SS_pos=[];


for n=1:length(cond_names)
    if strcmp(cond_names(n),'VM')
        VM_pos=[VM_pos n];
    elseif strcmp(cond_names(n),'VS')
        VS_pos=[VS_pos n];
    elseif strcmp(cond_names(n),'SM')
        SM_pos=[SM_pos n];
    elseif strcmp(cond_names(n),'SS')
        SS_pos=[SS_pos n];
    
    end
end


vector_VMvs=zeros(1,151);
vector_VMvs(VM_pos)=1/length(VM_pos);
vector_VMvs(VS_pos)=-(1/length(VS_pos));

vector_vmVS=zeros(1,151);
vector_vmVS(VM_pos)=-(1/length(VM_pos));
vector_vmVS(VS_pos)=(1/length(VS_pos));

vector_SMss=zeros(1,151);
vector_SMss(SM_pos)=1/length(SM_pos);
vector_SMss(SS_pos)=-(1/length(SS_pos));

vector_smSS=zeros(1,151);
vector_smSS(SM_pos)=-(1/length(SM_pos));
vector_smSS(SS_pos)=(1/length(SS_pos));

vector_VMsm=zeros(1,151);
vector_VMsm(VM_pos)=(1/length(VM_pos));
vector_VMsm(SM_pos)=-(1/length(SM_pos));

vector_vmSM=zeros(1,151);
vector_vmSM(VM_pos)=-(1/length(VM_pos));
vector_vmSM(SM_pos)=(1/length(SM_pos));

else
    
    cond_names={ 'VM','SM','reg','reg','reg','reg','reg','reg','reg',...
        'VS','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
        'VM','VS','bp','reg','reg','reg','reg','reg','reg','reg',...
        'SM','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'VM','SM','reg','reg','reg','reg','reg','reg','reg',...
    'VS','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'VM','VS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'SM','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'VM','SM','reg','reg','reg','reg','reg','reg','reg',...
    'VS','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'VM','VS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'SM','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'VM','SM','reg','reg','reg','reg','reg','reg','reg',...
    'VS','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'VM','VS','bp','reg','reg','reg','reg','reg','reg','reg',...
    'SM','SS','bp','reg','reg','reg','reg','reg','reg','reg',...
    };
    

VM_pos=[];
VS_pos=[];
SM_pos=[];
SS_pos=[];


for n=1:length(cond_names)
    if strcmp(cond_names(n),'VM')
        VM_pos=[VM_pos n];
    elseif strcmp(cond_names(n),'VS')
        VS_pos=[VS_pos n];
    elseif strcmp(cond_names(n),'SM')
        SM_pos=[SM_pos n];
    elseif strcmp(cond_names(n),'SS')
        SS_pos=[SS_pos n];
    
    end
end


vector_VMvs=zeros(1,172);
vector_VMvs(VM_pos)=1/length(VM_pos);
vector_VMvs(VS_pos)=-(1/length(VS_pos));

vector_vmVS=zeros(1,172);
vector_vmVS(VM_pos)=-(1/length(VM_pos));
vector_vmVS(VS_pos)=(1/length(VS_pos));

vector_SMss=zeros(1,172);
vector_SMss(SM_pos)=1/length(SM_pos);
vector_SMss(SS_pos)=-(1/length(SS_pos));

vector_smSS=zeros(1,172);
vector_smSS(SM_pos)=-(1/length(SM_pos));
vector_smSS(SS_pos)=(1/length(SS_pos));

vector_VMsm=zeros(1,172);
vector_VMsm(VM_pos)=(1/length(VM_pos));
vector_VMsm(SM_pos)=-(1/length(SM_pos));

vector_vmSM=zeros(1,172);
vector_vmSM(VM_pos)=-(1/length(VM_pos));
vector_vmSM(SM_pos)=(1/length(SM_pos));

%     vector_VMvs=all_sub_cons(1).c;
%     vector_vmVS=all_sub_cons(1).c;
%     vector_SMss=all_sub_cons(1).c;
%     vector_smSS=all_sub_cons(1).c;
%     vector_VMsm=all_sub_cons(1).c;
%     vector_SMvm=all_sub_cons(1).c;
    
end



matlabbatch{1}.spm.stats.con.spmmat(1) = spm_mat;
matlabbatch{1}.spm.stats.con.consess{1}.tcon.name = 'VM>VS';
matlabbatch{1}.spm.stats.con.consess{1}.tcon.weights = vector_VMvs;
matlabbatch{1}.spm.stats.con.consess{1}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{2}.tcon.name = 'VM<VS';
matlabbatch{1}.spm.stats.con.consess{2}.tcon.weights = vector_vmVS;
matlabbatch{1}.spm.stats.con.consess{2}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{3}.tcon.name = 'SM>SS';
matlabbatch{1}.spm.stats.con.consess{3}.tcon.weights = vector_SMss;
matlabbatch{1}.spm.stats.con.consess{3}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{4}.tcon.name = 'SM<SS';
matlabbatch{1}.spm.stats.con.consess{4}.tcon.weights = vector_smSS;
matlabbatch{1}.spm.stats.con.consess{4}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{5}.tcon.name = 'VM>SM';
matlabbatch{1}.spm.stats.con.consess{5}.tcon.weights = vector_VMsm;
matlabbatch{1}.spm.stats.con.consess{5}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.consess{6}.tcon.name = 'VM<SM';
matlabbatch{1}.spm.stats.con.consess{6}.tcon.weights = vector_vmSM;
matlabbatch{1}.spm.stats.con.consess{6}.tcon.sessrep = 'none';

matlabbatch{1}.spm.stats.con.delete = 0;



 spm_jobman('serial', matlabbatch, '');
 clear matlabbatch;

end