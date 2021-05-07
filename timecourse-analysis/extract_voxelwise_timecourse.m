% function SinVoxRegTimeCourse(subjects)
clearvars;
subjects={'sub1','sub2','sub4','sub5','sub6','sub7'};

% ==========================================================================
% Return adjusted data for a given voxel location
% ==========================================================================

% concatenate the co-variates together (also adding constants for session specific de-meaning)


for s=1:length(subjects)
    
    load (fullfile('/p/himmelbach/nikhil/analysed_data', subjects{s}, 'results_MovOnsets_AllReg','SPM.mat'));
    load (fullfile('/p/himmelbach/nikhil/analysed_data', subjects{s}, 'results_MovOnsets_AllReg','time_course_ana','MReg.mat'));

    
%     covar=[];
%     run_ind=[];
%     for i=1:length(SPM.Sess)
%         if i==1
%             covar(1:(length(SPM.Sess(1).C.C)),1:7)=SPM.Sess(1).C.C;
%             covar(1:length(SPM.Sess(1).C.C),8)=ones;
%             run_ind=length(SPM.Sess(1).C.C);
%         else
%             covar(run_ind+1:run_ind+(length(SPM.Sess(i).C.C)),1:7)=SPM.Sess(i).C.C;
%             covar(run_ind+1:run_ind+length(SPM.Sess(i).C.C),7+i)=ones;
%             run_ind=length(covar);
%         end
%     end
%     
%     
%     
%     % Convert MNI to voxel coordinates first
%     
%     a     = 0;
%     MReg=struct();
%     for x = 42 : 44
%         for y = 42 : 44
%             for z = 32 : 34
%                 a=a+1;
%                 MReg(a).xyz_v=[x y z];
%                 xyz = [x y z 1]*SPM.xVol.M';
%                 MReg(a).xyz=xyz(1:3);
%                 
%                 % Raw time course for the voxel
%                 
%                 XYZ = [x y z]';
%                 rtc = spm_data_read(SPM.xY.VY,'xyz',XYZ);
%                 
%                 % Whiten and filter the raw time course
%                 
%                 if ~isempty(rtc), rtc = spm_filter(SPM.xX.K,SPM.xX.W*rtc); 
%                 else
%                      disp('empty rtc')
%                 
%                 end
%                 
%                 MReg(a).rtc=rtc;
%                 
%                 
%                 % regress out the co-variates from the raw time course and do session specific de-meaning
%                 
%                 [MReg(a).beta, MReg(a).betaCInt, MReg(a).reg_rtc, MReg(a).reg_rtcCInt,~ ] = regress(rtc,covar);
%                 MReg(a).covar=covar;
%                 
%             end
%         end
%     end
    
    %======================================================================================================
    % Interpolation of time courses + extraction of mean time course and its SE for each voxel, by condition
    %======================================================================================================
    
    
    % Interpolation to 0.1s from TR=2s
    
    TR=2;
    
    for k=1:length(MReg)
        
%         raw_data = MReg(k).reg_rtc;
%         
%         TR_new=0.1;
%         
%         t_old=(0:length(raw_data)-1)*TR;
%         t_new=(0:length(raw_data)*TR/TR_new-1)*TR_new;
%         MReg(k).interp20_reg_rtc(:,1)=interp1(t_old,MReg(k).reg_rtc,t_new); %interp
%         
%         MReg(k).interpSpl20_reg_rtc(:,1)=spline(t_old,MReg(k).reg_rtc,t_new);% spline
        
        
        
        % Extraction of interpolated time courses
        
        conditions={'VM';'SM';'VS';'SS'};

        %       conditions={'VM';'SM';'VS';'SS';'bp'};
        

        for l=1:length(conditions)
            
            switch char(conditions(l))
                
                case 'VM'
                    if strcmp(subjects(s),'sub1')
                        run_ind=[1 3 5 7];
                    elseif strcmp(subjects(s),'sub2')
                        run_ind=[1 3 5 7 9 11 13];
                    else
                        run_ind=[1 3 5 7 9 11 13 15];  %run number for VM
                    end
                    col=1;
                    
                    for i = 1 : length(run_ind)
                        
                        bl_ons_ind=(5:4:length(SPM.Sess(run_ind(i)).U(1).ons)); % index for block onsets from all event indices (excluding the first block for conditions that come first
                        
                        if run_ind(i)==1
                        
                            for m=1:length(bl_ons_ind)
                                bl_ons = floor(SPM.Sess(run_ind(i)).U(1).ons(bl_ons_ind(m))*10);
                                cond_tc_interpSpl20_resample2.VM(k).interpSpl20_rtc(:,col) = MReg(k).interpSpl20_reg_rtc(bl_ons -(5.9*10) :20: bl_ons+(18*10));
                                col=col+1;
                            end
                            
                        else
                            
                            for m=1:length(bl_ons_ind)
                                bl_ons = (sum(SPM.nscan(1:(run_ind(i)-1)))*20) + floor(SPM.Sess(run_ind(i)).U(1).ons(bl_ons_ind(m))*10);
                                cond_tc_interpSpl20_resample2.VM(k).interpSpl20_rtc(:,col) = MReg(k).interpSpl20_reg_rtc(bl_ons -(5.9*10) :20: bl_ons+(18*10));
                                col=col+1;
                            end
                        end
                    end
                    
                    
                    
                    cond_tc_interpSpl20_resample2.VM(k).interpSpl20_mtc=mean(cond_tc_interpSpl20_resample2.VM(k).interpSpl20_rtc,2);
                    
                    cond_tc_interpSpl20_resample2.VM(k).interpSpl20_std=std(cond_tc_interpSpl20_resample2.VM(k).interpSpl20_rtc,0,2);
                    
                    cond_tc_interpSpl20_resample2.VM(k).interpSpl20_se=cond_tc_interpSpl20_resample2.VM(k).interpSpl20_std/sqrt(length(cond_tc_interpSpl20_resample2.VM(k).interpSpl20_rtc));
                    
                    continue
                    
                case 'SM'
                    if strcmp(subjects(s),'sub1')
                        run_ind=[1 4 5 8];
                    elseif strcmp(subjects(s),'sub2')
                        run_ind=[1 4 5 8 9 12 14];
                    else
                        run_ind=[1 4 5 8 9 12 13 16];  %run number for SM
                    end
                        col=1;
                    
                    for i = 1 : length(run_ind)
                        
                        if run_ind(i)==1
                            
                            bl_ons_ind=(1:4:length(SPM.Sess(run_ind(i)).U(2).ons));
                        
                            for m=1:length(bl_ons_ind)
                                bl_ons = floor(SPM.Sess(run_ind(i)).U(2).ons(bl_ons_ind(m))*10);
                                cond_tc_interpSpl20_resample2.SM(k).interpSpl20_rtc(:,col) = MReg(k).interpSpl20_reg_rtc(bl_ons -(5.9*10) :20: bl_ons+(18*10));
                                col=col+1;
                            end
                            
                        elseif run_ind(i)==5||run_ind(i)==9||run_ind(i)==13
                            
                            bl_ons_ind=(1:4:length(SPM.Sess(run_ind(i)).U(2).ons));
                            
                            for m=1:length(bl_ons_ind)
                                bl_ons = (sum(SPM.nscan(1:(run_ind(i)-1)))*20) + floor(SPM.Sess(run_ind(i)).U(1).ons(bl_ons_ind(m))*10);
                                cond_tc_interpSpl20_resample2.SM(k).interpSpl20_rtc(:,col)=MReg(k).interpSpl20_reg_rtc(bl_ons-(5.9*10) :20: bl_ons+(18*10));
                                col=col+1;
                            end
                            
                        elseif strcmp(subjects{s},'sub2')&& run_ind(i)==14
                            
                            bl_ons_ind=(5:4:length(SPM.Sess(run_ind(i)).U(1).ons));
                            
                            for m=1:length(bl_ons_ind)
                                bl_ons = (sum(SPM.nscan(1:run_ind(i)-1))*20) + floor(SPM.Sess(run_ind(i)).U(1).ons(bl_ons_ind(m))*10);
                                cond_tc_interpSpl20_resample2.SM(k).interpSpl20_rtc(:,col)=MReg(k).interpSpl20_reg_rtc(bl_ons-(5.9*10) :20: bl_ons+(18*10));
                                col=col+1;
                            end
                            
                        else
                            
                            bl_ons_ind=(5:4:length(SPM.Sess(run_ind(i)).U(1).ons));
                            
                            for m=1:length(bl_ons_ind)
                                bl_ons = (sum(SPM.nscan(1:run_ind(i)-1))*20) + floor(SPM.Sess(run_ind(i)).U(1).ons(bl_ons_ind(m))*10);
                                cond_tc_interpSpl20_resample2.SM(k).interpSpl20_rtc(:,col)=MReg(k).interpSpl20_reg_rtc(bl_ons-(5.9*10) :20: bl_ons+(18*10));
                                col=col+1;
                            end
                        end
                    end
                    
                    cond_tc_interpSpl20_resample2.SM(k).interpSpl20_mtc=mean(cond_tc_interpSpl20_resample2.SM(k).interpSpl20_rtc,2);
                    
                    cond_tc_interpSpl20_resample2.SM(k).interpSpl20_std=std(cond_tc_interpSpl20_resample2.SM(k).interpSpl20_rtc,0,2);
                    
                    cond_tc_interpSpl20_resample2.SM(k).interpSpl20_se=cond_tc_interpSpl20_resample2.SM(k).interpSpl20_std/sqrt(length(cond_tc_interpSpl20_resample2.SM(k).interpSpl20_rtc));
                    
                    continue
                    
                case 'VS'
                    
                    if strcmp(subjects(s),'sub1')
                        run_ind=[2 3 6 7];
                    elseif strcmp(subjects(s),'sub2')    
                        run_ind=[2 3 6 7 10 11 13];
                    else
                        run_ind=[2 3 6 7 10 11 14 15];  %run number for VS
                    end
                    
                    col=1;
                    
                    for i= 1: length(run_ind)
                        
                        if run_ind(i)==3||run_ind(i)==7||run_ind(i)==11||run_ind(i)==15
                            
                            bl_ons_ind=(1:4:length(SPM.Sess(run_ind(i)).U(2).ons));
                            
                            for m=1:length(bl_ons_ind)
                                bl_ons = (sum(SPM.nscan(1:(run_ind(i)-1)))*20) + floor(SPM.Sess(run_ind(i)).U(2).ons(bl_ons_ind(m))*10);
                                cond_tc_interpSpl20_resample2.VS(k).interpSpl20_rtc(:,col)=MReg(k).interpSpl20_reg_rtc(bl_ons-(5.9*10) :20: bl_ons+(18*10));
                                col=col+1;
                            end
                        
                        elseif strcmp(subjects{s},'sub2')&& run_ind(i)==13
                            
                            bl_ons_ind=(1:4:length(SPM.Sess(run_ind(i)).U(2).ons));
                            
                            for m=1:length(bl_ons_ind)
                                bl_ons = (sum(SPM.nscan(1:(run_ind(i)-1)))*20) + floor(SPM.Sess(run_ind(i)).U(2).ons(bl_ons_ind(m))*10);
                                cond_tc_interpSpl20_resample2.VS(k).interpSpl20_rtc(:,col)=MReg(k).interpSpl20_reg_rtc(bl_ons-(5.9*10) :20: bl_ons+(18*10));
                                col=col+1;
                            end
                            
                        else
                            
                            bl_ons_ind=(5:4:length(SPM.Sess(run_ind(i)).U(1).ons));
                            
                            for m=1:length(bl_ons_ind)
                                bl_ons = (sum(SPM.nscan(1:(run_ind(i)-1)))*20) + floor(SPM.Sess(run_ind(i)).U(1).ons(bl_ons_ind(m))*10);
                                cond_tc_interpSpl20_resample2.VS(k).interpSpl20_rtc(:,col)=MReg(k).interpSpl20_reg_rtc(bl_ons-(5.9*10) :20: bl_ons+(18*10));
                                col=col+1;
                            end
                        end
                    end
                    
                    cond_tc_interpSpl20_resample2.VS(k).interpSpl20_mtc=mean(cond_tc_interpSpl20_resample2.VS(k).interpSpl20_rtc,2);
                    
                    cond_tc_interpSpl20_resample2.VS(k).interpSpl20_std=std(cond_tc_interpSpl20_resample2.VS(k).interpSpl20_rtc,0,2);
                    
                    cond_tc_interpSpl20_resample2.VS(k).interpSpl20_se=cond_tc_interpSpl20_resample2.VS(k).interpSpl20_std/sqrt(length(cond_tc_interpSpl20_resample2.VS(k).interpSpl20_rtc));
                    
                    continue
                    
                case 'SS'
                    
                    if strcmp(subjects(s),'sub1')
                        run_ind=[2 4 6 8];
                    elseif strcmp(subjects(s),'sub2')   
                        run_ind=[2 4 6 8 10 12 14];
                    else
                        run_ind=[2 4 6 8 10 12 14 16];  %run number for SS
                    end
                    col=1;
                    
                    for i= 1: length(run_ind)
                        
                        bl_ons_ind=(1:4:length(SPM.Sess(run_ind(i)).U(2).ons)); % index for block onsets from all event indices (excluding the first block for conditions that come first
                        
                        for m=1:length(bl_ons_ind)
                            bl_ons = (sum(SPM.nscan(1:(run_ind(i)-1)))*20) + floor(SPM.Sess(run_ind(i)).U(2).ons(bl_ons_ind(m))*10);
                            cond_tc_interpSpl20_resample2.SS(k).interpSpl20_rtc(:,col)=MReg(k).interpSpl20_reg_rtc(bl_ons-(5.9*10) :20: bl_ons+(18*10));
                            col=col+1;
                        end
                    end
                    
                    
                    
                    cond_tc_interpSpl20_resample2.SS(k).interpSpl20_mtc=mean(cond_tc_interpSpl20_resample2.SS(k).interpSpl20_rtc,2);
                    
                    cond_tc_interpSpl20_resample2.SS(k).interpSpl20_std=std(cond_tc_interpSpl20_resample2.SS(k).interpSpl20_rtc,0,2);
                    
                    cond_tc_interpSpl20_resample2.SS(k).interpSpl20_se=cond_tc_interpSpl20_resample2.SS(k).interpSpl20_std/sqrt(length(cond_tc_interpSpl20_resample2.SS(k).interpSpl20_rtc));
                    
                    
                    
%                 case 'bp'
%                     
%                     ind=[2 3 4 6 7 8 10 11 12 14 15 16];  %run number for bp
%                     
%                     col=1;
%                     
%                     for i= 1: length(ind)
%                         
%                         bl_count=length(SPM.Sess(ind(i)).U(3).ons); % index for block onsets from all event indices (excluding the first block for conditions that come first
%                         
%                         for m=1:length(bl_count)
%                             bl_ons=floor(SPM.Sess(ind(i)).U(3).ons(m)*10);
%                             cond_tc_interpSpl20_resample2bp(k).interpSpl20_rtc(:,col)=MReg(k).interpSpl20_reg_rtc(bl_ons-(2.9*10):bl_ons+(18*10));
%                             col=col+1;
%                         end
%                     end
%                     
%                     
%                     
%                     cond_tc_interpSpl20_resample2bp(k).interpSpl20_mtc=mean(cond_tc_interpSpl20_resample2bp(k).interpSpl20_rtc,2);
%                     
%                     cond_tc_interpSpl20_resample2bp(k).interpSpl20_std=std(cond_tc_interpSpl20_resample2bp(k).interpSpl20_rtc,0,2);
%                     
%                     cond_tc_interpSpl20_resample2bp(k).interpSpl20_se=cond_tc_interpSpl20_resample2bp(k).interpSpl20_std/sqrt(length(cond_tc_interpSpl20_resample2bp(k).interpSpl20_rtc));
                    
            end
        end
        
    end
    
    
    save(fullfile('/p/himmelbach/nikhil/analysed_data',subjects{s},'results_MovOnsets_AllReg/time_course_ana','cond_tc_interpSpl20_resample2.mat'),'cond_tc_interpSpl20_resample2')
    fprintf('cond_tc_interpSpl20_resample2 saved in the results folder of %s\n',subjects{s})
    
    
end
