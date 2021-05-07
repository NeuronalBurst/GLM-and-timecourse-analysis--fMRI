clearvars;
subjects={'sub1','sub2','sub4','sub5','sub6','sub7'};

for s=1:length(subjects)
    load(fullfile('/p/himmelbach/nikhil/analysed_data',subjects{s},'results_MovOnsets_AllReg/time_course_ana/cond_tc.mat'))
    load(fullfile('/p/himmelbach/nikhil/analysed_data',subjects{s},'results_MovOnsets_AllReg/time_course_ana/MReg.mat'))
        
    pnum=1;
    figure;
for vox=1:length(cond_tc.VM)
        if MReg(vox).xyz(3) == -4
            ind=[21 12 3 24 15 6 27 18 9];
            subplot(3,3,pnum)
%             errorbar(cond_tc.VM(ind(pnum)).interpSpl20_mtc, cond_tc.VM(ind(pnum)).interpSpl20_se)
            errorbar(cond_tc.VM(ind(pnum)).interpSpl20_mtc, cond_tc.VM(ind(pnum)).interpSpl20_se)
            
            set(gca,'FontSize',7);
            set(gca,'XTick',(0:10:240));
            set(gca,'XTickLabel',(-6:18));
            set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            set(gcf, 'InvertHardcopy', 'off')
            ylim([-10 10])
            set(gca,'YTick',(-10:1:10)); 
            title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))

            switch subjects{s}
                
                case 'sub2'
                    if [MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)]== [-6,-26,-4]
                        set(gca,'Color','r');
%                          title(sprintf(' x=%i y=%i z=%i *',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
%                     else
%                       
%                          title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
                    end
                        
                case 'sub5'
                        
                    if [MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)]== [-4,-26,-4]
                        set(gca,'Color','r');

%                         title(sprintf(' x=%i y=%i z=%i *',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
%                     else
%                       
%                         title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
                    end
                
%                 otherwise
                    
%                     title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
            end
             
            for i=1:size(cond_tc.VM(1).interpSpl20_rtc,2)
                hold on
                all_pl=plot(cond_tc.VM(ind(pnum)).interpSpl20_rtc(:,i));
                all_pl.Color(4)=0.2; 
%                 all_pl_ax=gca;
%                 all_pl_ax.XLim=[];
                
            end 
            
            pnum=pnum+1;
        end
end
suptitle(sprintf('%s Superior VM', subjects{s}))
saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/time_coursesM6_all',subjects{s},sprintf('%s_superior_VM.png', subjects{s})))

pnum=1;
figure;
for vox=1:length(cond_tc.VM)
        if MReg(vox).xyz(3) == -6
            ind=[20 11 2 23 14 5 26 17 8];
            subplot(3,3,pnum)
%             errorbar(cond_tc.VM(ind(pnum)).interpSpl20_mtc, cond_tc.VM(ind(pnum)).interpSpl20_se)
            errorbar(cond_tc.VM(ind(pnum)).interpSpl20_mtc, cond_tc.VM(ind(pnum)).interpSpl20_se)
            
             set(gca,'FontSize',7);
            set(gca,'XTick',(0:10:240));
            set(gca,'XTickLabel',(-6:18));
            set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            set(gcf, 'InvertHardcopy', 'off')
            ylim([-10 10]) 
            set(gca,'YTick',(-10:1:10)); 
            
            title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
            
            switch subjects{s}
                
                case 'sub1'
                    if [MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)]== [-4,-30,-6]
                        set(gca,'Color','r');

%                          title(sprintf(' x=%i y=%i z=%i *',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
%                     else
%                       
%                          title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
                    end
                        
                case 'sub4'
                        
                    if [MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)]== [-8,-30,-6]
                        set(gca,'Color','r');
%                         title(sprintf(' x=%i y=%i z=%i *',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
%                     else
%                       
%                         title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
                    end
                    
                    
                case 'sub7'
                        
                    if [MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)]== [-4,-28,-6]
                        set(gca,'Color','r');
%                         title(sprintf(' x=%i y=%i z=%i *',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
%                     else
%                       
%                         title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
                    end    
                
%                 otherwise
%                     
%                     title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
            end
              
            for i=1:size(cond_tc.VM(1).interpSpl20_rtc,2)
                hold on
                all_pl=plot(cond_tc.VM(ind(pnum)).interpSpl20_rtc(:,i));
                all_pl.Color(4)=0.2;
            end 
            
            pnum=pnum+1;
        end
end
suptitle(sprintf('%s Middle VM',subjects{s}))
saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/time_coursesM6_all',subjects{s},sprintf('%s_middle_VM.png', subjects{s})))



pnum=1;
figure;
for vox=1:length(cond_tc.VM)
        if MReg(vox).xyz(3) == -8
            ind=[19 10 1 22 13 4 25 16 7];
            subplot(3,3,pnum)
%             errorbar(cond_tc.VM(ind(pnum)).interpSpl20_mtc, cond_tc.VM(ind(pnum)).interpSpl20_se)
            errorbar(cond_tc.VM(ind(pnum)).interpSpl20_mtc, cond_tc.VM(ind(pnum)).interpSpl20_se)
 
            set(gca,'FontSize',7);
            set(gca,'XTick',(0:10:240));
            set(gca,'XTickLabel',(-6:18));
            set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            set(gcf, 'InvertHardcopy', 'off')
            ylim([-10 10]) 
            set(gca,'YTick',(-10:1:10)); 
            
            title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
            
            for i=1:size(cond_tc.VM(1).interpSpl20_rtc,2)
                hold on
                all_pl=plot(cond_tc.VM(ind(pnum)).interpSpl20_rtc(:,i));
                all_pl.Color(4)=0.2;
                
            end 
            
            pnum=pnum+1;
        end
end
suptitle(sprintf('%s Inferior VM',subjects{s}))
saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/time_coursesM6_all',subjects{s},sprintf('%s_inferior_VM.png', subjects{s})))


%% for VS

pnum=1;
figure;
for vox=1:length(cond_tc.VS)
        if MReg(vox).xyz(3) == -4
            ind=[21 12 3 24 15 6 27 18 9];
            subplot(3,3,pnum)
%             errorbar(cond_tc.VS(ind(pnum)).interpSpl20_mtc, cond_tc.VS(ind(pnum)).interpSpl20_se)
            errorbar(cond_tc.VS(ind(pnum)).interpSpl20_mtc, cond_tc.VS(ind(pnum)).interpSpl20_se)
            
            set(gca,'FontSize',7);
            set(gca,'XTick',(0:10:240));
            set(gca,'XTickLabel',(-6:18));            
            ylim([-10 10]) 
            set(gca,'YTick',(-10:1:10)); 
            set(gcf,'units','normalized','outerposition',[0 0 1 1])
            set(gcf, 'InvertHardcopy', 'off')
            title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))

            for i=1:size(cond_tc.VS(1).interpSpl20_rtc,2)
                hold on
                all_pl=plot(cond_tc.VS(ind(pnum)).interpSpl20_rtc(:,i));
                all_pl.Color(4)=0.2;
            end    
            
            pnum=pnum+1;
        end
end
suptitle(sprintf('%s Superior VS',subjects{s}))
saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/time_coursesM6_all',subjects{s},sprintf('%s_superior_VS.png', subjects{s})))


pnum=1;
figure;
for vox=1:length(cond_tc.VS)
        if MReg(vox).xyz(3) == -6
            ind=[20 11 2 23 14 5 26 17 8];
            subplot(3,3,pnum)
%             errorbar(cond_tc.VS(ind(pnum)).interpSpl20_mtc, cond_tc.VS(ind(pnum)).interpSpl20_se)
            errorbar(cond_tc.VS(ind(pnum)).interpSpl20_mtc, cond_tc.VS(ind(pnum)).interpSpl20_se)
 
            set(gca,'FontSize',7);
            set(gca,'XTick',(0:10:240));
            set(gca,'XTickLabel',(-6:18));
            ylim([-10 10]) 
            set(gca,'YTick',(-10:1:10)); 
            set(gcf,'units','normalized','outerposition',[0 0 1 1])
            set(gcf, 'InvertHardcopy', 'off')
            title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))

            for i=1:size(cond_tc.VS(1).interpSpl20_rtc,2)
                hold on
                all_pl=plot(cond_tc.VS(ind(pnum)).interpSpl20_rtc(:,i));
                all_pl.Color(4)=0.2;
            end   
            
            pnum=pnum+1;
        end
end
suptitle(sprintf('%s Middle VS',subjects{s}))
saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/time_coursesM6_all',subjects{s},sprintf('%s_middle_VS.png', subjects{s})))



pnum=1;
figure;
for vox=1:length(cond_tc.VS)
        if MReg(vox).xyz(3) == -8
            ind=[19 10 1 22 13 4 25 16 7];
            subplot(3,3,pnum)
%             errorbar(cond_tc.VS(ind(pnum)).interpSpl20_mtc, cond_tc.VS(ind(pnum)).interpSpl20_se)
            errorbar(cond_tc.VS(ind(pnum)).interpSpl20_mtc, cond_tc.VS(ind(pnum)).interpSpl20_se)
            
             
            
            set(gca,'FontSize',7);
            set(gca,'XTick',(0:10:240));
            set(gca,'XTickLabel',(-6:18));
            ylim([-10 10]) 
            set(gca,'YTick',(-10:1:10)); 
            set(gcf,'units','normalized','outerposition',[0 0 1 1])
            set(gcf, 'InvertHardcopy', 'off')
            title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))

            for i=1:size(cond_tc.VS(1).interpSpl20_rtc,2)
                hold on
                all_pl=plot(cond_tc.VS(ind(pnum)).interpSpl20_rtc(:,i));
                all_pl.Color(4)=0.2;
            end   
            
            pnum=pnum+1;
        end
end
suptitle(sprintf('%s Inferior VS',subjects{s}))
saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/time_coursesM6_all',subjects{s},sprintf('%s_inferior_VS.png', subjects{s})))
    
    pnum=1;
    figure;
for vox=1:length(cond_tc.SM)
        if MReg(vox).xyz(3) == -4
            ind=[21 12 3 24 15 6 27 18 9];
            subplot(3,3,pnum)
%             errorbar(cond_tc.SM(ind(pnum)).interpSpl20_mtc, cond_tc.SM(ind(pnum)).interpSpl20_se)
            errorbar(cond_tc.SM(ind(pnum)).interpSpl20_mtc, cond_tc.SM(ind(pnum)).interpSpl20_se)

            set(gca,'FontSize',7);
            set(gca,'XTick',(0:10:240));
            set(gca,'XTickLabel',(-6:18));
            set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            set(gcf, 'InvertHardcopy', 'off')
            ylim([-10 10]) 
            set(gca,'YTick',(-10:1:10)); 
            title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))

            switch subjects{s}
                
                case 'sub2'
                    if [MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)]== [-8,-28,-4]
                        set(gca,'Color','r');
%                          title(sprintf(' x=%i y=%i z=%i *',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
%                     else
%                       
%                          title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
                    end
                        
                case 'sub5'
                        
                    if [MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)]== [-4,-26,-4]
                        set(gca,'Color','r');

%                         title(sprintf(' x=%i y=%i z=%i *',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
%                     else
%                       
%                         title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
                    end
                
%                 otherwise
                    
%                     title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
            end
             
            for i=1:size(cond_tc.SM(1).interpSpl20_rtc,2)
                hold on
                all_pl=plot(cond_tc.SM(ind(pnum)).interpSpl20_rtc(:,i));
                all_pl.Color(4)=0.2;
            end 
            
            pnum=pnum+1;
        end
end
suptitle(sprintf('%s Superior SM', subjects{s}))
saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/time_coursesM6_all',subjects{s},sprintf('%s_superior_SM.png', subjects{s})))

pnum=1;
figure;
for vox=1:length(cond_tc.SM)
        if MReg(vox).xyz(3) == -6
            ind=[20 11 2 23 14 5 26 17 8];
            subplot(3,3,pnum)
%             errorbar(cond_tc.SM(ind(pnum)).interpSpl20_mtc, cond_tc.SM(ind(pnum)).interpSpl20_se)
            errorbar(cond_tc.SM(ind(pnum)).interpSpl20_mtc, cond_tc.SM(ind(pnum)).interpSpl20_se)
            
            set(gca,'FontSize',7);
            set(gca,'XTick',(0:10:240));
            set(gca,'XTickLabel',(-6:18));
            set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            set(gcf, 'InvertHardcopy', 'off')
            ylim([-10 10]) 
            set(gca,'YTick',(-10:1:10)); 
            
            title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
            
            switch subjects{s}
                
                case 'sub1'
                    if [MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)]== [-6,-30,-6]
                        set(gca,'Color','r');

%                          title(sprintf(' x=%i y=%i z=%i *',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
%                     else
%                       
%                          title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
                    end
                        
                case 'sub6'
                        
                    if [MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)]== [-4,-28,-6]
                        set(gca,'Color','r');
%                         title(sprintf(' x=%i y=%i z=%i *',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
%                     else
%                       
%                         title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
                    end
                
                case 'sub7'
                        
                    if [MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)]== [-6,-28,-6]
                        set(gca,'Color','r');
%                         title(sprintf(' x=%i y=%i z=%i *',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
%                     else
%                       
%                         title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
                    end    
                
%                 otherwise
%                     
%                     title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
            end
            
            for i=1:size(cond_tc.SM(1).interpSpl20_rtc,2)
                hold on
                all_pl=plot(cond_tc.SM(ind(pnum)).interpSpl20_rtc(:,i));
                all_pl.Color(4)=0.2;
            end 
            

                  
            pnum=pnum+1;
        end
end
suptitle(sprintf('%s Middle SM',subjects{s}))
saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/time_coursesM6_all',subjects{s},sprintf('%s_middle_SM.png', subjects{s})))



pnum=1;
figure;
for vox=1:length(cond_tc.SM)
        if MReg(vox).xyz(3) == -8
            ind=[19 10 1 22 13 4 25 16 7];
            subplot(3,3,pnum)
%             errorbar(cond_tc.SM(ind(pnum)).interpSpl20_mtc, cond_tc.SM(ind(pnum)).interpSpl20_se)
            errorbar(cond_tc.SM(ind(pnum)).interpSpl20_mtc, cond_tc.SM(ind(pnum)).interpSpl20_se)

            set(gca,'FontSize',7);
            set(gca,'XTick',(0:10:240));
            set(gca,'XTickLabel',(-6:18));
            set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            set(gcf, 'InvertHardcopy', 'off')
            ylim([-10 10]) 
            set(gca,'YTick',(-10:1:10)); 
            
            title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
            
            switch subjects{s}
                
                case 'sub4'
                    if [MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)]== [-4,-26,-8]
                        set(gca,'Color','r');
%                          title(sprintf(' x=%i y=%i z=%i *',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
%                     else
%                       
%                          title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
                    end
                        
%                 otherwise
%                     
%                         title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))
            end

            for i=1:size(cond_tc.SM(1).interpSpl20_rtc,2)
                hold on
                all_pl=plot(cond_tc.SM(ind(pnum)).interpSpl20_rtc(:,i));
                all_pl.Color(4)=0.2;
            end 
            
            pnum=pnum+1;
        end
end
suptitle(sprintf('%s Inferior SM',subjects{s}))
saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/time_coursesM6_all',subjects{s},sprintf('%s_inferior_SM.png', subjects{s})))


%% for SS

pnum=1;
figure;
for vox=1:length(cond_tc.SS)
        if MReg(vox).xyz(3) == -4
            ind=[21 12 3 24 15 6 27 18 9];
            subplot(3,3,pnum)
%             errorbar(cond_tc.SS(ind(pnum)).interpSpl20_mtc, cond_tc.SS(ind(pnum)).interpSpl20_se)
            errorbar(cond_tc.SS(ind(pnum)).interpSpl20_mtc, cond_tc.SS(ind(pnum)).interpSpl20_se)
            
            set(gca,'FontSize',7);
            set(gca,'XTick',(0:10:240));
            set(gca,'XTickLabel',(-6:18));            
            ylim([-10 10]) 
            set(gca,'YTick',(-10:1:10)); 
            set(gcf,'units','normalized','outerposition',[0 0 1 1])
            set(gcf, 'InvertHardcopy', 'off')
            title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))

            for i=1:size(cond_tc.SS(1).interpSpl20_rtc,2)
                hold on
                all_pl=plot(cond_tc.SS(ind(pnum)).interpSpl20_rtc(:,i));
                all_pl.Color(4)=0.2;
            end
            
            pnum=pnum+1;
        end
end
suptitle(sprintf('%s Superior SS',subjects{s}))
saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/time_coursesM6_all',subjects{s},sprintf('%s_superior_SS.png', subjects{s})))


pnum=1;
figure;
for vox=1:length(cond_tc.SS)
        if MReg(vox).xyz(3) == -6
            ind=[20 11 2 23 14 5 26 17 8];
            subplot(3,3,pnum)
%             errorbar(cond_tc.SS(ind(pnum)).interpSpl20_mtc, cond_tc.SS(ind(pnum)).interpSpl20_se)
            errorbar(cond_tc.SS(ind(pnum)).interpSpl20_mtc, cond_tc.SS(ind(pnum)).interpSpl20_se)
            
            
            
            set(gca,'FontSize',7);
            set(gca,'XTick',(0:10:240));
            set(gca,'XTickLabel',(-6:18));
            ylim([-10 10]) 
            set(gca,'YTick',(-10:1:10)); 
            set(gcf,'units','normalized','outerposition',[0 0 1 1])
            set(gcf, 'InvertHardcopy', 'off')
            title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))

            for i=1:size(cond_tc.SS(1).interpSpl20_rtc,2)
                hold on
                all_pl=plot(cond_tc.SS(ind(pnum)).interpSpl20_rtc(:,i));
                all_pl.Color(4)=0.2;
            end
            pnum=pnum+1;
        end
end
suptitle(sprintf('%s Middle SS',subjects{s}))
saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/time_coursesM6_all',subjects{s},sprintf('%s_middle_SS.png', subjects{s})))



pnum=1;
figure;
for vox=1:length(cond_tc.SS)
        if MReg(vox).xyz(3) == -8
            ind=[19 10 1 22 13 4 25 16 7];
            subplot(3,3,pnum)
%             errorbar(cond_tc.SS(ind(pnum)).interpSpl20_mtc, cond_tc.SS(ind(pnum)).interpSpl20_se)
            errorbar(cond_tc.SS(ind(pnum)).interpSpl20_mtc, cond_tc.SS(ind(pnum)).interpSpl20_se)
            set(gca,'FontSize',7);
            set(gca,'XTick',(0:10:240));
            set(gca,'XTickLabel',(-6:18));
            ylim([-10 10]) 
            set(gca,'YTick',(-10:1:10)); 
            set(gcf,'units','normalized','outerposition',[0 0 1 1])
            set(gcf, 'InvertHardcopy', 'off')
            title(sprintf(' x=%i y=%i z=%i',MReg(ind(pnum)).xyz(1),MReg(ind(pnum)).xyz(2),MReg(ind(pnum)).xyz(3)))

            for i=1:size(cond_tc.SS(1).interpSpl20_rtc,2)
                hold on
                all_pl=plot(cond_tc.SS(ind(pnum)).interpSpl20_rtc(:,i));
                all_pl.Color(4)=0.2;
            end

            pnum=pnum+1;
        end
end
suptitle(sprintf('%s Inferior SS',subjects{s}))
saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/TCM6_all_noReset',subjects{s},sprintf('%s_inferior_SS.png', subjects{s})))

end
