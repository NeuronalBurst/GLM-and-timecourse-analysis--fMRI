clearvars;
subjects={'sub1','sub2','sub4','sub5','sub6','sub7'};
% figure
% set(gcf,'units','normalized','outerposition',[0 0 1 1]);
pnum=1;
for s=1:length(subjects)
        clearvars -except s pnum subjects

    load(fullfile('/p/himmelbach/nikhil/analysed_data',subjects{s},'results_MovOnsets_AllReg/time_course_ana/plot_mean_mtc.mat'))
    
    %     %% for the superior layer
    
    %     if s==1
    %
    %         subplot(6,3,pnum)
    %         colormap(jet)
    %         imagesc(plot_max_mtc(s).SupPlot);
    %         colorbar
    %         caxis([0 1])
    % %         title('Superior')
    %         hold on
    %
    %         % plot gridlines
    %
    %         plot(repmat(2.5,14,1),0:0.5:6.5,'k-', 'LineWidth', 3)
    %         plot(repmat(4.5,14,1),0:0.5:6.5,'k-', 'LineWidth', 3)
    %
    %         plot(0:0.5:6.5,repmat(2.5,14,1),'k-', 'LineWidth', 3)
    %         plot(0:0.5:6.5,repmat(4.5,14,1),'k-', 'LineWidth', 3)
    %
    %
    %         plot(repmat(1.5,14,1),0:0.5:6.5,'k-', 'LineWidth',3)
    %         plot(repmat(3.5,14,1),0:0.5:6.5,'k-', 'LineWidth',3)
    %         plot(repmat(5.5,14,1),0:0.5:6.5,'k-', 'LineWidth',3)
    %
    %         plot(0:0.5:6.5,repmat(1.5,14,1),'k-', 'LineWidth',3)
    %         plot(0:0.5:6.5,repmat(3.5,14,1),'k-', 'LineWidth',3)
    %         plot(0:0.5:6.5,repmat(5.5,14,1),'k-', 'LineWidth',3)
    %         axis off
    %         axis square
    %
    %         pnum=pnum+1;
    %
    %
    %
    %
    %         %% for the middle layer
    %
    %
    %         subplot(6,3,pnum)
    %         colormap(jet)
    %         imagesc(plot_max_mtc(s).MidPlot);
    %         colorbar
    %         caxis([0 1])
    %
    % %         title('Middle')
    %
    %         hold on
    %
    %
    %         plot(repmat(2.5,14,1),0:0.5:6.5,'k-', 'LineWidth', 3)
    %         plot(repmat(4.5,14,1),0:0.5:6.5,'k-', 'LineWidth', 3)
    %
    %         plot(0:0.5:6.5,repmat(2.5,14,1),'k-', 'LineWidth', 3)
    %         plot(0:0.5:6.5,repmat(4.5,14,1),'k-', 'LineWidth', 3)
    %
    %
    %         plot(repmat(1.5,14,1),0:0.5:6.5,'k-', 'LineWidth',3)
    %         plot(repmat(3.5,14,1),0:0.5:6.5,'k-', 'LineWidth',3)
    %         plot(repmat(5.5,14,1),0:0.5:6.5,'k-', 'LineWidth',3)
    %
    %         plot(0:0.5:6.5,repmat(1.5,14,1),'k-', 'LineWidth',3)
    %         plot(0:0.5:6.5,repmat(3.5,14,1),'k-', 'LineWidth',3)
    %         plot(0:0.5:6.5,repmat(5.5,14,1),'k-', 'LineWidth',3)
    %         axis off
    %         axis square
    %         pnum=pnum+1;
    %
    %
    %         %% for the inferior layer
    %
    %
    %
    %         subplot(6,3,pnum)
    %         colormap(jet)
    %         imagesc(plot_max_mtc(s).InfPlot);
    %         colorbar
    %         caxis([0 1])
    %         hold on
    %
    %
    %         plot(repmat(2.5,14,1),0:0.5:6.5,'k-', 'LineWidth', 3)
    %         plot(repmat(4.5,14,1),0:0.5:6.5,'k-', 'LineWidth', 3)
    %
    %         plot(0:0.5:6.5,repmat(2.5,14,1),'k-', 'LineWidth', 3)
    %         plot(0:0.5:6.5,repmat(4.5,14,1),'k-', 'LineWidth', 3)
    %
    %
    %         plot(repmat(1.5,14,1),0:0.5:6.5,'k-', 'LineWidth',3)
    %         plot(repmat(3.5,14,1),0:0.5:6.5,'k-', 'LineWidth',3)
    %         plot(repmat(5.5,14,1),0:0.5:6.5,'k-', 'LineWidth',3)
    %
    %         plot(0:0.5:6.5,repmat(1.5,14,1),'k-', 'LineWidth',3)
    %         plot(0:0.5:6.5,repmat(3.5,14,1),'k-', 'LineWidth',3)
    %         plot(0:0.5:6.5,repmat(5.5,14,1),'k-', 'LineWidth',3)
    %         axis off
    %         axis square
    %         pnum=pnum+1;
    %
    %
    %
    %     else
    %% for the superior layer
    figure('Color',[1 1 1]);
%     set(gca,'LooseInset',get(gca, 'TightInset'))
    %         im(s).sub(1)=subplot(6,3,pnum);
    %         colormap(jet)
    imagesc(plot_mean_mtc.SupPlot);
    %         colorbar
%     caxis([0 1])
    hold on
    
    % plot gridlines
    
    
    % vertical thin lines
    plot(repmat(1.5,14,1),0:0.5:6.5,'w-', 'LineWidth',3)
    plot(repmat(3.5,14,1),0:0.5:6.5,'w-', 'LineWidth',3)
    plot(repmat(5.5,14,1),0:0.5:6.5,'w-', 'LineWidth',3)
    
    % horizontal thin lines
    plot(0:0.5:6.5,repmat(1.5,14,1),'w-', 'LineWidth',3)
    plot(0:0.5:6.5,repmat(3.5,14,1),'w-', 'LineWidth',3)
    plot(0:0.5:6.5,repmat(5.5,14,1),'w-', 'LineWidth',3)
    
    % vertical thick lines
    plot(repmat(2.5,14,1),0:0.5:6.5,'k-', 'LineWidth', 3)
    plot(repmat(4.5,14,1),0:0.5:6.5,'k-', 'LineWidth', 3)
    
    % horizontal thick lines
    plot(0:0.5:6.5,repmat(2.5,14,1),'k-', 'LineWidth', 3)
    plot(0:0.5:6.5,repmat(4.5,14,1),'k-', 'LineWidth', 3)
    
    axis off
    axis square
    pnum=pnum+1;
    
    set(gcf, 'InvertHardcopy', 'off')
    saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/plot_mean_mtc',subjects{s},sprintf('%s_superior.png', subjects{s})))
    
    
    %% for the middle layer
    
    figure('Color',[1 1 1]);
%     set(gca,'LooseInset',get(gca, 'TightInset'))
    %         im(s).sub(2)=subplot(6,3,pnum);
    %         colormap(jet)
    imagesc(plot_mean_mtc.MidPlot);
    %         colorbar
%     caxis([0 1])
    hold on
    plot(repmat(1.5,14,1),0:0.5:6.5,'w-', 'LineWidth',3)
    plot(repmat(3.5,14,1),0:0.5:6.5,'w-', 'LineWidth',3)
    plot(repmat(5.5,14,1),0:0.5:6.5,'w-', 'LineWidth',3)
    
    plot(0:0.5:6.5,repmat(1.5,14,1),'w-', 'LineWidth',3)
    plot(0:0.5:6.5,repmat(3.5,14,1),'w-', 'LineWidth',3)
    plot(0:0.5:6.5,repmat(5.5,14,1),'w-', 'LineWidth',3)
    
    plot(repmat(2.5,14,1),0:0.5:6.5,'k-', 'LineWidth', 3)
    plot(repmat(4.5,14,1),0:0.5:6.5,'k-', 'LineWidth', 3)
    
    plot(0:0.5:6.5,repmat(2.5,14,1),'k-', 'LineWidth', 3)
    plot(0:0.5:6.5,repmat(4.5,14,1),'k-', 'LineWidth', 3)
    
    
    
    axis off
    axis square
    pnum=pnum+1;
    
    set(gcf, 'InvertHardcopy', 'off')
    saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/plot_mean_mtc',subjects{s},sprintf('%s_middle.png', subjects{s})))
    
    %% for the inferior layer
    
    figure('Color',[1 1 1]);
%     set(gca,'LooseInset',get(gca, 'TightInset'))
    %         im(s).sub(3)=subplot(6,3,pnum);
    %         colormap(jet)
    imagesc(plot_mean_mtc.InfPlot);
    %         colorbar
%     caxis([0 1])
    hold on
    plot(repmat(1.5,14,1),0:0.5:6.5,'w-', 'LineWidth',3)
    plot(repmat(3.5,14,1),0:0.5:6.5,'w-', 'LineWidth',3)
    plot(repmat(5.5,14,1),0:0.5:6.5,'w-', 'LineWidth',3)
    
    plot(0:0.5:6.5,repmat(1.5,14,1),'w-', 'LineWidth',3)
    plot(0:0.5:6.5,repmat(3.5,14,1),'w-', 'LineWidth',3)
    plot(0:0.5:6.5,repmat(5.5,14,1),'w-', 'LineWidth',3)
    
    plot(repmat(2.5,14,1),0:0.5:6.5,'k-', 'LineWidth', 3)
    plot(repmat(4.5,14,1),0:0.5:6.5,'k-', 'LineWidth', 3)
    
    plot(0:0.5:6.5,repmat(2.5,14,1),'k-', 'LineWidth', 3)
    plot(0:0.5:6.5,repmat(4.5,14,1),'k-', 'LineWidth', 3)
    
    
    
    axis off
    axis square
    pnum=pnum+1;
    
    set(gcf, 'InvertHardcopy', 'off')
    saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/plot_mean_mtc',subjects{s},sprintf('%s_inferior.png', subjects{s})))
    
    %     end
end
figure('Color',[1 1 1]);
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
colorbar
set(gcf, 'InvertHardcopy', 'off')
saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/plot_mean_mtc','colorbar.png'))
% 

%         saveas(gcf,fullfile('/p/himmelbach/nikhil/figures/plot_mean_mtc','all.png'))
