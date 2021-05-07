clearvars;
% subjects={'sub1','sub4','sub5','sub6','sub7'};
subjects={'sub6'};

for s=1:length(subjects)
    load(fullfile('F:\stim_data',subjects{s},'results_MovOnsets_AllReg/time_course_ana/meanTI_resample2_noWhit.mat'))
    %     load(fullfile('/p/himmelbach/nikhil/analysed_data',subjects{s},'results_MovOnsets_AllReg/time_course_ana/meanTI_resample2_noWhit_SS.mat'))
    
    %% Means and stds of meanTI_resample2_noWhits
for vox=1:27
%     meanTI_resample2_noWhit.tests(vox).meanVM = mean(meanTI_resample2_noWhit.means(vox).VM);
%     meanTI_resample2_noWhit.tests(vox).stdVM = std(meanTI_resample2_noWhit.means(vox).VM);
%     meanTI_resample2_noWhit.tests(vox).meanVS = mean(meanTI_resample2_noWhit.means(vox).VS);
%     meanTI_resample2_noWhit.tests(vox).stdVS = std(meanTI_resample2_noWhit.means(vox).VS);
%     meanTI_resample2_noWhit.tests(vox).meanSM = mean(meanTI_resample2_noWhit.means(vox).SM);
%     meanTI_resample2_noWhit.tests(vox).stdSM = std(meanTI_resample2_noWhit.means(vox).SM);
%     meanTI_resample2_noWhit.tests(vox).meanSS = mean(meanTI_resample2_noWhit.means(vox).SS);
%     meanTI_resample2_noWhit.tests(vox).stdSS = std(meanTI_resample2_noWhit.means(vox).SS);    
%     
%     %% t tests without corrections
%     [meanTI_resample2_noWhit.tests(vox).VM_signi, meanTI_resample2_noWhit.tests(vox).VM_p, ~, meanTI_resample2_noWhit.tests(vox).VM_stats] = ttest(meanTI_resample2_noWhit.means(vox).VM);
%     [meanTI_resample2_noWhit.tests(vox).VS_signi, meanTI_resample2_noWhit.tests(vox).VS_p, ~, meanTI_resample2_noWhit.tests(vox).VS_stats] = ttest(meanTI_resample2_noWhit.means(vox).VS);
%     [meanTI_resample2_noWhit.tests(vox).SM_signi, meanTI_resample2_noWhit.tests(vox).SM_p, ~, meanTI_resample2_noWhit.tests(vox).SM_stats] = ttest(meanTI_resample2_noWhit.means(vox).SM);
%     [meanTI_resample2_noWhit.tests(vox).SS_signi, meanTI_resample2_noWhit.tests(vox).SS_p, ~, meanTI_resample2_noWhit.tests(vox).SS_stats] = ttest(meanTI_resample2_noWhit.means(vox).SS);
    [meanTI_resample2_noWhit.tests(vox).VMVS_signiTR, meanTI_resample2_noWhit.tests(vox).VMVS_p, ~, meanTI_resample2_noWhit.tests(vox).VMVS_stats] = ttest2(meanTI_resample2_noWhit.means(vox).VM, meanTI_resample2_noWhit.means(vox).VS, 'Tail', 'right', 'Alpha', 0.05);
    [meanTI_resample2_noWhit.tests(vox).SMSS_signiTR, meanTI_resample2_noWhit.tests(vox).SMSS_p, ~, meanTI_resample2_noWhit.tests(vox).SMSS_stats] = ttest2(meanTI_resample2_noWhit.means(vox).SM, meanTI_resample2_noWhit.means(vox).SS, 'Tail', 'right', 'Alpha', 0.05);
    [meanTI_resample2_noWhit.tests(vox).VMSM_signiTR, meanTI_resample2_noWhit.tests(vox).VMSM_p,~, meanTI_resample2_noWhit.tests(vox).VMSM_stats] = ttest2(meanTI_resample2_noWhit.means(vox).VM, meanTI_resample2_noWhit.means(vox).SM);
     
    %% t tests with Bonferrroni correction for multiple comparisons
     meanTI_resample2_noWhit.tests(1).bonfp=0.05/27;
     
     if meanTI_resample2_noWhit.tests(vox).VMVS_p <= meanTI_resample2_noWhit.tests(1).bonfp
         meanTI_resample2_noWhit.tests(vox).VMVS_bonfsigni=1;
     else 
         meanTI_resample2_noWhit.tests(vox).VMVS_bonfsigni=0;
     end
    
      if meanTI_resample2_noWhit.tests(vox).SMSS_p <= meanTI_resample2_noWhit.tests(1).bonfp
         meanTI_resample2_noWhit.tests(vox).SMSS_bonfsigni=1;
     else 
         meanTI_resample2_noWhit.tests(vox).SMSS_bonfsigni=0;
      end
     
       if meanTI_resample2_noWhit.tests(vox).VMSM_p <= meanTI_resample2_noWhit.tests(1).bonfp
         meanTI_resample2_noWhit.tests(vox).VMSM_bonfsigni=1;
     else 
         meanTI_resample2_noWhit.tests(vox).VMSM_bonfsigni=0;
       end
     
     
end
 
%% Max T permutation test

%      %% for VM
%      
%     obsVM=meanTI_resample2_noWhit.means(1).VM;
%  
%     n_obsVM=length(obsVM);
%     
%     for perm=1:2000
%         rand_dist1=randi(2,1,n_obsVM);
%         
%         grp_ind11 = find(rand_dist1==1);
%         grp_ind12 = find(rand_dist1==2);
% 
%         % combine to form 1
%         for vox=1:27
%             grpVM=[];
%             
%             grpVM=meanTI_resample2_noWhit.means(vox).VM(grp_ind11);
%             
%             grpVM=vertcat(grpVM, meanTI_resample2_noWhit.means(vox).VM(grp_ind12)*-1); %since it is a one sample test the signs are permuted
%             
%             % one sample t test on the group
%             
%             meanTI_resample2_noWhit.perms(perm).VM_Tperm(vox) = ttest(grpVM);
%         end
%         
%         meanTI_resample2_noWhit.perms(perm).VM_maxT=max(meanTI_resample2_noWhit.perms(perm).VM_Tperm);
%     end
%     
%     alpha_level=0.05;
%     
%     for i=1:2000
%     all_maxT(i)=meanTI_resample2_noWhit.perms(i).VM_maxT;
%     end
%     
%     meanTI_resample2_noWhit.tests(1).perm_VM_criticalT=prctile(all_maxT, 100 - 100*alpha_level); %95th percentile
%     
%     for vox=1:27
%         if meanTI_resample2_noWhit.tests(vox).VM_stats.tstat   >= meanTI_resample2_noWhit.tests(1).perm_VM_criticalT
%             
%             meanTI_resample2_noWhit.tests(vox).perm_VM_signi = 1;
%         else
%             meanTI_resample2_noWhit.tests(vox).perm_VM_signi = 0;
%         end
%     end
%     
%    %% for VS
%      
%     obsVS=meanTI_resample2_noWhit.means(1).VS;
%  
%     n_obsVS=length(obsVS);
%     
%     for perm=1:2000
%         rand_dist1=randi(2,1,n_obsVS);
%         
%         grp_ind11 = find(rand_dist1==1);
%         grp_ind12 = find(rand_dist1==2);
% 
%         % combine to form 1
%         for vox=1:27
%             grpVS=[];
%             
%             grpVS=meanTI_resample2_noWhit.means(vox).VS(grp_ind11);
%             
%             grpVS=vertcat(grpVS, meanTI_resample2_noWhit.means(vox).VS(grp_ind12)*-1); %since it is a one sample test the signs are permuted
%             
%             % one sample t test on the group
%             
%             meanTI_resample2_noWhit.perms(perm).VS_Tperm(vox) = ttest(grpVS);
%         end
%         
%         meanTI_resample2_noWhit.perms(perm).VS_maxT=max(meanTI_resample2_noWhit.perms(perm).VS_Tperm);
%     end
%     
%     alpha_level=0.05;
%     
%     for i=1:2000
%     all_maxT(i)=meanTI_resample2_noWhit.perms(i).VS_maxT;
%     end
%     
%     meanTI_resample2_noWhit.tests(1).perm_VS_criticalT=prctile(all_maxT, 100 - 100*alpha_level); %95th percentile
%     
%     for vox=1:27
%         if meanTI_resample2_noWhit.tests(vox).VS_stats.tstat   >= meanTI_resample2_noWhit.tests(1).perm_VS_criticalT
%             
%             meanTI_resample2_noWhit.tests(vox).perm_VS_signi = 1;
%         else
%             meanTI_resample2_noWhit.tests(vox).perm_VS_signi = 0;
%         end
%     end
%     
%     %% for SM
%     
%     obsSM=meanTI_resample2_noWhit.means(1).SM;
%  
%     n_obsSM=length(obsSM);
%     
%     for perm=1:2000
%         rand_dist1=randi(2,1,n_obsSM);
%         
%         grp_ind11 = find(rand_dist1==1);
%         grp_ind12 = find(rand_dist1==2);
% 
%         % combine to form 1
%         for vox=1:27
%             grpSM=[];
%             
%             grpSM=meanTI_resample2_noWhit.means(vox).SM(grp_ind11);
%             
%             grpSM=vertcat(grpSM, meanTI_resample2_noWhit.means(vox).SM(grp_ind12)*-1); %since it is a one sample test the signs are permuted
%             
%             % one sample t test on the group
%             
%             meanTI_resample2_noWhit.perms(perm).SM_Tperm(vox) = ttest(grpSM);
%         end
%         
%         meanTI_resample2_noWhit.perms(perm).SM_maxT=max(meanTI_resample2_noWhit.perms(perm).SM_Tperm);
%     end
%     
%     alpha_level=0.05;
%     
%     for i=1:2000
%     all_maxT(i)=meanTI_resample2_noWhit.perms(i).SM_maxT;
%     end
%     
%     meanTI_resample2_noWhit.tests(1).perm_SM_criticalT=prctile(all_maxT, 100 - 100*alpha_level); %95th percentile
%     
%     for vox=1:27
%         if meanTI_resample2_noWhit.tests(vox).SM_stats.tstat   >= meanTI_resample2_noWhit.tests(1).perm_SM_criticalT
%             
%             meanTI_resample2_noWhit.tests(vox).perm_SM_signi = 1;
%         else
%             meanTI_resample2_noWhit.tests(vox).perm_SM_signi = 0;
%         end
%     end
%     
%    %% for SS
%      
%     obsSS=meanTI_resample2_noWhit.means(1).SS;
%  
%     n_obsSS=length(obsSS);
%     
%     for perm=1:2000
%         rand_dist1=randi(2,1,n_obsSS);
%         
%         grp_ind11 = find(rand_dist1==1);
%         grp_ind12 = find(rand_dist1==2);
% 
%         % combine to form 1
%         for vox=1:27
%             grpSS=[];
%             
%             grpSS=meanTI_resample2_noWhit.means(vox).SS(grp_ind11);
%             
%             grpSS=vertcat(grpSS, meanTI_resample2_noWhit.means(vox).SS(grp_ind12)*-1); %since it is a one sample test the signs are permuted
%             
%             % one sample t test on the group
%             
%             meanTI_resample2_noWhit.perms(perm).SS_Tperm(vox) = ttest(grpSS);
%         end
%         
%         meanTI_resample2_noWhit.perms(perm).SS_maxT=max(meanTI_resample2_noWhit.perms(perm).SS_Tperm);
%     end
%     
%     alpha_level=0.05;
%     
%     for i=1:2000
%     all_maxT(i)=meanTI_resample2_noWhit.perms(i).SS_maxT;
%     end
%     
%     meanTI_resample2_noWhit.tests(1).perm_SS_criticalT=prctile(all_maxT, 100 - 100*alpha_level); %95th percentile
%     
%     for vox=1:27
%         if meanTI_resample2_noWhit.tests(vox).SS_stats.tstat   >= meanTI_resample2_noWhit.tests(1).perm_SS_criticalT
%             
%             meanTI_resample2_noWhit.tests(vox).perm_SS_signi = 1;
%         else
%             meanTI_resample2_noWhit.tests(vox).perm_SS_signi = 0;
%         end
%     end
 
    
    %% for VM - VS
    
    obsVM=meanTI_resample2_noWhit.means(1).VM;
    obsVS=meanTI_resample2_noWhit.means(1).VS;
    
    n_obsVM=length(obsVM);
    n_obsVS=length(obsVS);
    
    mult_fact=(n_obsVM + n_obsVS)/(n_obsVM * n_obsVS); %used later in computing T value
    df=(n_obsVM + n_obsVS)-2; %degrees of freedom
    
    for perm=1:2000
        rand_dist1=randi(2,1,n_obsVM);
        rand_dist2=randi(2,1,n_obsVS);
        
        grp_ind11 = find(rand_dist1==1);
        grp_ind12 = find(rand_dist1==2);
        grp_ind21 = find(rand_dist2==1);
        grp_ind22 = find(rand_dist2==2);
        
        
        
        %form groups to calculate t tests on
        for vox=1:27
            grpVM=[];
            grpVS=[];
            
            grpVM=meanTI_resample2_noWhit.means(vox).VM(grp_ind11);
            grpVM=vertcat(grpVM, meanTI_resample2_noWhit.means(vox).VS(grp_ind21));
            
            grpVS=meanTI_resample2_noWhit.means(vox).VM(grp_ind12);
            grpVS=vertcat(grpVS, meanTI_resample2_noWhit.means(vox).VS(grp_ind22));
            
            
            % t tests on each of the two groups
            prt1=sum(grpVM.^2)-(sum(grpVM).^2)/n_obsVM;
            prt2=sum(grpVS.^2)-(sum(grpVS).^2)/n_obsVS;
            poold_var=(prt1+prt2)/df;
            den=sqrt(poold_var*mult_fact);
            
            meanTI_resample2_noWhit.perms(perm).VMVS_Tperm(vox) = (mean(grpVM)-mean(grpVS))./den;
        end
        
        meanTI_resample2_noWhit.perms(perm).VMVS_maxT=max(meanTI_resample2_noWhit.perms(perm).VMVS_Tperm);
        all_maxT(perm)=meanTI_resample2_noWhit.perms(perm).VMVS_maxT;

    end
    
    alpha_level=0.05;
    
    
    meanTI_resample2_noWhit.tests(1).perm_VMVS_criticalT=prctile(all_maxT, 100 - 100*alpha_level); %95th percentile
    
    for vox=1:27
        if meanTI_resample2_noWhit.tests(vox).VMVS_stats.tstat   >= meanTI_resample2_noWhit.tests(1).perm_VMVS_criticalT
            
            meanTI_resample2_noWhit.tests(vox).perm_VMVS_signi = 1;
        else
            meanTI_resample2_noWhit.tests(vox).perm_VMVS_signi = 0;
        end
    end
    
    %% for SM - SS
    
    
    obsSM=meanTI_resample2_noWhit.means(1).SM;
    obsSS=meanTI_resample2_noWhit.means(1).SS;
    
    n_obsSM=length(obsSM);
    n_obsSS=length(obsSS);
    
    mult_fact=(n_obsSM + n_obsSS)/(n_obsSM * n_obsSS); %used later in computing T value
    df=(n_obsSM + n_obsSS)-2; %degrees of freedom
    
    for perm=1:2000
        rand_dist1=randi(2,1,n_obsSM);
        rand_dist2=randi(2,1,n_obsSS);
        
        grp_ind11 = find(rand_dist1==1);
        grp_ind12 = find(rand_dist1==2);
        grp_ind21 = find(rand_dist2==1);
        grp_ind22 = find(rand_dist2==2);
        
        
        
        %form groups to calculate t tests on
        for vox=1:27
            grpSM=[];
            grpSS=[];
            
            grpSM=meanTI_resample2_noWhit.means(vox).SM(grp_ind11);
            grpSM=vertcat(grpSM, meanTI_resample2_noWhit.means(vox).SS(grp_ind21));
            
            grpSS=meanTI_resample2_noWhit.means(vox).SM(grp_ind12);
            grpSS=vertcat(grpSS, meanTI_resample2_noWhit.means(vox).SS(grp_ind22));
            
            
            % t tests on each of the two groups
            prt1=sum(grpSM.^2)-(sum(grpSM).^2)/n_obsSM;
            prt2=sum(grpSS.^2)-(sum(grpSS).^2)/n_obsSS;
            poold_var=(prt1+prt2)/df;
            den=sqrt(poold_var*mult_fact);
            
            meanTI_resample2_noWhit.perms(perm).SMSS_Tperm(vox) = (mean(grpSM)-mean(grpSS))./den;
        end
        
        meanTI_resample2_noWhit.perms(perm).SMSS_maxT=max(meanTI_resample2_noWhit.perms(perm).SMSS_Tperm);
        all_maxT(perm)=meanTI_resample2_noWhit.perms(perm).SMSS_maxT;
    end
    
    alpha_level=0.05;
    
    meanTI_resample2_noWhit.tests(1).perm_SMSS_criticalT=prctile(all_maxT, 100 - 100*alpha_level); %95th percentile
    
    for vox=1:27
        if meanTI_resample2_noWhit.tests(vox).SMSS_stats.tstat   >= meanTI_resample2_noWhit.tests(1).perm_SMSS_criticalT
            
            meanTI_resample2_noWhit.tests(vox).perm_SMSS_signi = 1;
        else
            meanTI_resample2_noWhit.tests(vox).perm_SMSS_signi = 0;
        end
    end
    
    
    %% for VM-SM
    
    obsVM=meanTI_resample2_noWhit.means(1).VM;
    obsSM=meanTI_resample2_noWhit.means(1).SM;
    
    n_obsVM=length(obsVM);
    n_obsSM=length(obsSM);
    
    mult_fact=(n_obsVM + n_obsSM)/(n_obsVM * n_obsSM); %used later in computing T value
    df=(n_obsVM + n_obsSM)-2; %degrees of freedom
    
    for perm=1:2000
        rand_dist1=randi(2,1,n_obsVM);
        rand_dist2=randi(2,1,n_obsSM);
        
        grp_ind11 = find(rand_dist1==1);
        grp_ind12 = find(rand_dist1==2);
        grp_ind21 = find(rand_dist2==1);
        grp_ind22 = find(rand_dist2==2);
        
        
        
        %form groups to calculate t tests on
        for vox=1:27
            grpVM=[];
            grpSM=[];
            
            grpVM=meanTI_resample2_noWhit.means(vox).VM(grp_ind11);
            grpVM=vertcat(grpVM, meanTI_resample2_noWhit.means(vox).SM(grp_ind21));
            
            grpSM=meanTI_resample2_noWhit.means(vox).VM(grp_ind12);
            grpSM=vertcat(grpSM, meanTI_resample2_noWhit.means(vox).SM(grp_ind22));
            
            
            % t tests on each of the two groups
            prt1=sum(grpVM.^2)-(sum(grpVM).^2)/n_obsVM;
            prt2=sum(grpSM.^2)-(sum(grpSM).^2)/n_obsSM;
            poold_var=(prt1+prt2)/df;
            den=sqrt(poold_var*mult_fact);
            
            meanTI_resample2_noWhit.perms(perm).VMSM_Tperm(vox) = (mean(grpVM)-mean(grpSM))./den;
        end
        
        meanTI_resample2_noWhit.perms(perm).VMSM_maxT=max(meanTI_resample2_noWhit.perms(perm).VMSM_Tperm);
        all_maxT(perm)=meanTI_resample2_noWhit.perms(perm).VMSM_maxT;
    end
    
    alpha_level=0.05;
        
    
    all_maxT=abs(all_maxT);
    meanTI_resample2_noWhit.tests(2).perm_VMSM_criticalT = prctile(all_maxT , 100 - 100*alpha_level); %95th percentile
    meanTI_resample2_noWhit.tests(1).perm_VMSM_criticalT = - meanTI_resample2_noWhit.tests(2).perm_VMSM_criticalT;
    
    for vox=1:27
        if meanTI_resample2_noWhit.tests(vox).VMSM_stats.tstat   >= meanTI_resample2_noWhit.tests(2).perm_VMSM_criticalT 
            
            meanTI_resample2_noWhit.tests(vox).perm_VMSM_signi = 1;
        
        elseif meanTI_resample2_noWhit.tests(vox).VMSM_stats.tstat   <= meanTI_resample2_noWhit.tests(1).perm_VMSM_criticalT 
            
            meanTI_resample2_noWhit.tests(vox).perm_VMSM_signi = -1;
        
        else
            meanTI_resample2_noWhit.tests(vox).perm_VMSM_signi = 0;
        end
    end
    
        
    save(fullfile('F:\stim_data',subjects{s},'results_MovOnsets_AllReg/time_course_ana','meanTI_resample2_noWhit.mat'),'meanTI_resample2_noWhit')
    
    fprintf('maxT_perm %s \n',char(subjects(s)));
    
    
end