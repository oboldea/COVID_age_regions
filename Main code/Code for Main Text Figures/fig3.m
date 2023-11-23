close all
startdate=datenum('27-Feb-2020');
enddate=datenum('31-jan-2022');
%load output % uncomment this to load results

warning('off','all');
% variant beginning (5%), dominant and end 
% variants become 50% dominant
tg1=datenum('08-Feb-2021')-datenum('27-Feb-2020')+1;
tg2=datenum('23-Jun-2021')-datenum('27-Feb-2020')+1;
tg3=datenum('24-Dec-2021')-datenum('27-Feb-2020')+1;

tg=[tg1;tg2;tg3];
% variant beginning (5%) and end
tg1b=datenum('29-Dec-2020')-datenum('27-Feb-2020')+1;
tg1e=datenum('31-May-2021')-datenum('27-Feb-2020')+1;
tg2b=datenum('1-June-2021')-datenum('27-Feb-2020')+1;
tg2e=datenum('09-Dec-2021')-datenum('27-Feb-2020')+1;
tg3b=datenum('10-Dec-2021')-datenum('27-Feb-2020')+1;
tg3e=datenum('31-Jan-2022')-datenum('27-Feb-2020')+1;
tg_be=[[tg1b tg1e]; [tg2b tg2e];[tg3b tg3e]];
dates_plot=[datenum('1-Apr-2020') datenum('1-Jul-2020') datenum('1-Oct-2020') datenum('1-Jan-2021') datenum('1-Apr-2021') datenum('1-Jul-2021') datenum('1-Oct-2021') datenum('1-Jan-2022')]-datenum('27-Feb-2020');

para=x_post(end-num_para+1:end,:,startdate-bdate+1:enddate-bdate+1);
%plot results
jmin=1;
jmax=num_loc;
% subfigure panel names
panel_names={'A: TOTAL', 'B: ADULTS', 'C: ADOLESCENTS', 'D: CHILDREN'};
x_post=x_post(:,:,startdate-bdate+1:enddate-bdate+1);
inc=inc(startdate-bdate+1:enddate-bdate+1,:,:);
zikenhuis=zikenhuis(:,startdate-bdate+1:enddate-bdate+1);

if enddate>datenum("30-sep-2021")
    hos=hos(startdate-bdate+1:end,:,:);
else
    hos=hos(startdate-bdate+1:enddate-bdate+1,:,:);
end
num_times=enddate-startdate+1;
posleg=[0.177279874213837 0.726057906458797 0.161556603773584 0.185141631169834];
data1=readtable('dates.xls','ReadVariableNames',1); % import dates
date1 = datetime(data1.obs_date, 'InputFormat', 'MM-dd-yyyy');
date2=date1(startdate-datenum("27-feb-2020")+1:startdate-datenum("27-feb-2020")+size(hos,1));
date1=date1(startdate-datenum("27-feb-2020")+1:enddate-datenum("27-feb-2020")+1);
date3 = date1(enddate-datenum("27-feb-2020")-size(hos_young,1)+1:enddate-datenum("27-feb-2020"));
%positions of variant boxes on plot
pos_variants=[ [0.274700517943027 0.925970805921825 0.0267931927487977 0.0274684478064865] [0.346902040061309 0.925612022181192 0.0241671423286285 0.0274684478064865] [0.427728238465198 0.925970805921823 0.0372874848052425 0.0274684478064865];
    [0.714952090270071 0.924486024927021 0.0267931927487977 0.0274684478064865] [0.788332857671372 0.92486963168379 0.0241671423286283 0.0274684478064865]  [0.867979810792243 0.924486024927019 0.0372874848052427 0.0274684478064865];
    [0.274307436182021 0.452325668579583 0.0267931927487977 0.0274684478064864]  [0.346508958300303 0.450482103844146 0.0241671423286285 0.0274684478064864] [0.427335156704192 0.452325668579581 0.0372874848052425 0.0274684478064864];
     [0.713772844987053 0.452325668579583 0.0267931927487977 0.0274684478064866] [0.785974367105336 0.451966884838949 0.0241671423286287 0.0274684478064865] [0.866800565509224 0.452325668579581 0.0372874848052422 0.0274684478064865]];
% position first wave
pos_wave1=[[0.158232704402516 0.712694877505568 0.101594339622641 0.111358574610245];
    [0.591015723270441 0.714922048997772 0.101594339622641 0.111358574610245];
  [0.158232704402516 0.238307349665924 0.101594339622641 0.111358574610245];
   [0.591015723270441 0.230141054194506 0.101594339622641 0.110616184112843]];
% position panels
pos_panels=[[0.130716981132075 0.924276169265033 0.055996855345912 0.0452858203414994];
    [0.569789308176101 0.924276169265033 0.055996855345912 0.0460282108389017];
    [0.130716981132075 0.450631031922791 0.055996855345912 0.044543429844098];
    [0.569789308176101 0.450631031922791 0.055996855345912 0.0415738678544916]];

colg=rgb('ForestGreen');
colormap(spring)
col=get(gca,'ColorOrder');
ixcol = col([3;5;6],:);

% % position of legends
pos_leg=[[0.15041928721174 0.843596711912129 0.0939465386781303 0.0783221952633764]; 
[0.595780922431866 0.858450880154794 0.0939465386781302 0.0593912381327586];
[0.152384696016771 0.385548133309954 0.0939465386781303 0.0593912381327586];
[0.59420859538784 0.38406335231515 0.0939465386781302 0.0593912381327587]];
posit_new=[0.180638364779876 0.363028953229397 0.248213836477987 0.304380103934671];
posit_var=[[0.465999207230063 0.925760950259835 0.0609913059563439 0.0653303637713436];
    [0.635156492785796 0.927044902214308 0.0598120606733232 0.0653303637713436];
    [0.818789308176101 0.926774121485771 0.0860849056603787 0.0653303637713436]];

inf_RU = zeros(num_times,num_ens,num_cat); % reported and unreported
inf_R  = zeros(num_times,num_ens,num_cat); % reported 
inf_U  = zeros(num_times,num_ens,num_cat); % unreported
for c=1:3
   post_tot1=zeros(num_ens,num_times);
   post_tot2=zeros(num_ens,num_times);
      for j=1:12
     % total over regions
    post_tot1=post_tot1+squeeze(sum(x_post(num_out*num_loc*(c-1)+num_out*(j-1)+7,:,:)+x_post(num_out*num_loc*(c-1)+num_out*(j-1)+16,:,:),1))./squeeze(x_post(num_s+ixalpha(c),:,:));  
    post_tot2=post_tot2+squeeze(sum(x_post(num_out*num_loc*(c-1)+num_out*(j-1)+7,:,:)+x_post(num_out*num_loc*(c-1)+num_out*(j-1)+16,:,:),1));
       end
    post_tot3=post_tot1-post_tot2;     
    inf_RU(:,:,c)=(post_tot1)';
    inf_R(:,:,c)=(post_tot2)';
    inf_U(:,:,c)=(post_tot3)';
end

% find ratio of cases in an age category to cases
% across all age categories at each point in time
%ratio_R1=cumsum(inf_R,1)./repmat(sum(cumsum(inf_RU,1),3),1,1,num_cat);
%ratio_U1=cumsum(inf_U,1)./repmat(sum(cumsum(inf_RU,1),3),1,1,num_cat);
ratio_R1 =inf_R./repmat(sum(inf_RU,3),1,1,num_cat);
ratio_U1 =inf_U./repmat(sum(inf_RU,3),1,1,num_cat);

ratio=[];
for c=1:num_cat
ratio=[ratio mean(ratio_R1(:,:,num_cat+1-c),2) mean(ratio_U1(:,:,num_cat+1-c),2)]; % invert to start with children
end    
ratio=cumsum(ratio,2);    
% 
posit_panel=[0.127575630252101 0.916457377721428 0.158088230739246 0.0770010111783656];

% Panel A
figure(1)
 set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%  set(gca,'fontsize',20);
 col2 = rgb('Thistle');
 col1 = rgb('Plum');
 col4 = rgb('PaleTurquoise');
 col3 = rgb('Turquoise');
  col6=rgb('Khaki');
  col5=rgb('Gold');
cmap2=[col1;col2;col3;col4;col5;col6];
cmap3=[col5;col6;col3;col4;col1;col2];
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gca,'fontsize',30);

for c=1:2*num_cat
         y1=ratio(:,c);
         if c==1
         y2=zeros(num_times,1);
         else 
         y2=ratio(:,c-1);
         end
          y2=y2(end:-1:1);
         fill([date1; date1(end:-1:1)], [y1 ;y2], cmap3(c,:),'LineStyle','none'); hold on;
         xlim([date1(1) date1(end)])
         xtickangle(45);xticks(date1(dates_plot));
    xticklabels(["Apr 2020","Jul 2020","Oct 2020","Jan 2021", "Apr 2021","Jul 2021","Oct 2021","Jan 2022"]);set(gca,'fontsize',40);
         ylim([0 max(max(ratio,[],2),[],1)]);set(gca,'fontsize',40);  
 end
 for i=1:3
    aline=xline(tg(i),'','LineWidth', 5,'color',ixcol(i,:));hold on;
          bline= xline(tg_be(i,1),':','LineWidth', 5,'color',ixcol(i,:)); hold on;
          uistack(aline,'top');
          uistack(bline,'top');
 end
         ylabel('Fraction of total daily infections');set(gca,'Fontsize',30);
hold on
annotation('textbox',...
    posit_panel,...
    'String','A: CASE DETECTION',...
    'LineStyle','none',...
    'FontSize',40,...
    'FitBoxToText','on','EdgeColor', 'none');    
 
 annotation('textbox',...
    posit_var(1,:),...
    'String',{'Alpha'},...
    'LineStyle','none',...
    'FontSize',30,...
    'FitBoxToText','off',...
    'BackgroundColor',ixcol(1,:));
    annotation('textbox',...
    posit_var(2,:),...
    'String','Delta',...
    'LineStyle','none',...
    'FontSize',30,...
    'FitBoxToText','off',...
    'BackgroundColor',ixcol(2,:));
   annotation('textbox',...
    posit_var(3,:),...
    'String','Omicron',...
    'LineStyle','none',...
    'FontSize',30,...
    'FitBoxToText','off',...
    'BackgroundColor',ixcol(3,:));
lgd=legend({'Children - Reported','Children - Unreported','Adolescents - Reported','Adolescents - Unreported','Adults - Reported','Adults - Unreported'},'Location','NorthWest');
  lgd.FontSize = 20;   
  set(lgd,...
   'Position',[0.167123626850923 0.610473084811774 0.196852064956433 0.245972929106515]);
             box on
       ax = gca;
       ax.LineWidth = 2;
    set(gca, 'Layer', 'Top');
get(0,'defaultfigureposition');
set(groot,'defaultfigureposition',[400 250 450 350]);
exportgraphics(gca,'fig3a.eps');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Panel B
posleg=[0.177279874213837 0.726057906458797 0.161556603773584 0.185141631169834];
data1=readtable('dates.xls','ReadVariableNames',1); % import dates
date1 = datetime(data1.obs_date, 'InputFormat', 'MM-dd-yyyy');
date2=date1(startdate-datenum("27-feb-2020")+1:startdate-datenum("27-feb-2020")+size(hos,1));
date1=date1(startdate-datenum("27-feb-2020")+1:enddate-datenum("27-feb-2020")+1);
date3 = date1(enddate-datenum("27-feb-2020")-size(hos_young,1)+1:enddate-datenum("27-feb-2020"));

col2 = rgb('Thistle');
 col1 = rgb('Plum');
 col4 = rgb('PaleTurquoise');
 col3 = rgb('Turquoise');
  col6=rgb('Khaki');
  col5=rgb('Gold');
col=get(gca,'ColorOrder');
ixcol = col([3;5;6],:);


inf_RU = zeros(num_times,num_ens,num_cat); % reported and unreported
inf_R  = zeros(num_times,num_ens,num_cat); % reported 
inf_U  = zeros(num_times,num_ens,num_cat); % unreported
hos_e  = zeros(num_times,num_ens,num_cat); % estimated hospitalizations
for c=1:num_cat
   post_tot1=zeros(num_ens,num_times);
   post_tot2=zeros(num_ens,num_times);
   post_hos = zeros(num_ens,num_times);
    for j=1:num_loc
     % total over regions
    post_tot1=post_tot1+squeeze(sum(x_post(num_out*num_loc*(c-1)+num_out*(j-1)+7,:,:)+x_post(num_out*num_loc*(c-1)+num_out*(j-1)+16,:,:),1))./squeeze(x_post(num_s+ixalpha(c),:,:));  
    post_tot2=post_tot2+squeeze(sum(x_post(num_out*num_loc*(c-1)+num_out*(j-1)+7,:,:)+x_post(num_out*num_loc*(c-1)+num_out*(j-1)+16,:,:),1));
    post_hos = post_hos+ squeeze(sum(x_post(num_out*num_loc*(c-1)+num_out*(j-1)+8,:,:)+x_post(num_out*num_loc*(c-1)+num_out*(j-1)+17,:,:),1));
    end
    post_tot3=post_tot1-post_tot2;     
    inf_RU(:,:,c)=(post_tot1)';
    inf_R(:,:,c)=(post_tot2)';
    inf_U(:,:,c)=(post_tot3)';
    hos_e(:,:,c)= (post_hos)';
end

% find ratio of cumulative cases in an age category to cumulative cases
% across all age categories at each point in time
ratio_R1=cumsum(inf_R,1)./repmat(sum(cumsum(inf_RU,1),3),1,1,num_cat);
ratio_U1=cumsum(inf_U,1)./repmat(sum(cumsum(inf_RU,1),3),1,1,num_cat);

% bar plot of case detection rates per variant
ix_var=[1 tg1b-1;tg1b tg1e; tg2b tg2e; tg3e tg3e];
num_var=size(ix_var,1);
ratio_R2=zeros(num_ens,num_cat,num_var);
ratio_U2=zeros(num_ens,num_cat,num_var);

for j=1:num_var
ratio_R2(:,:,j) = squeeze(sum(inf_R(ix_var(j,1):ix_var(j,2),:,:),1))./repmat(sum(squeeze(sum(inf_RU(ix_var(j,1):ix_var(j,2),:,:),1)),2),1,num_cat);
ratio_U2(:,:,j) = squeeze(sum(inf_U(ix_var(j,1):ix_var(j,2),:,:),1))./repmat(sum(squeeze(sum(inf_RU(ix_var(j,1):ix_var(j,2),:,:),1)),2),1,num_cat);
end
ratio_R3=zeros(num_cat,3,num_var);
ratio_U3=zeros(num_cat,3,num_var);
for j=1:num_var
ratio_R3(:,1,j)=shiftdim(mean(ratio_R2(:,:,j),1));
ratio_R3(:,2,j)=shiftdim(quantile(ratio_R2(:,:,j),0.025,1));
ratio_R3(:,3,j)=shiftdim(quantile(ratio_R2(:,:,j),0.975,1));
ratio_U3(:,1,j)=shiftdim(mean(ratio_U2(:,:,j),1));
ratio_U3(:,2,j)=shiftdim(quantile(ratio_U2(:,:,j),0.025,1));
ratio_U3(:,3,j)=shiftdim(quantile(ratio_U2(:,:,j),0.975,1));
end
% infection burden cumulative per variant
bar_inf = zeros(num_var,2*num_cat,3);
for j=1:3
bar_inf(:,:,j)=[squeeze(ratio_R3(1,j,:)) squeeze(ratio_U3(1,j,:)) squeeze(ratio_R3(2,j,:))...
    squeeze(ratio_U3(2,j,:)) squeeze(ratio_R3(3,j,:)) squeeze(ratio_U3(3,j,:))];
end
xbar = [1:1:6 8:1:13 15:1:20 22:1:27]';
ybar=zeros(2*num_cat*num_var,3);
for j=1:3
ybar(:,j)=reshape((bar_inf(:,:,j))',[2*num_cat*num_var 1]);
end
posit_panel=[0.127575630252101 0.916457377721428 0.158088230739246 0.0770010111783656];

% Figure 3 Panel B reported and unreported infections
figure(2)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gca,'fontsize',40);
b=bar(xbar,ybar(:,1));
new_colors=repmat([col1;col2;col3;col4;col5;col6],4,1);
b.FaceColor='flat';
for j = 1:length(xbar)
    b.CData(j,:) = new_colors(j,:);
end
xticklabels({'Wild-Type','Alpha','Delta','Omicron'});set(gca,'fontsize',40);
ylabel({'Fraction of total infections'});set(gca,'Fontsize',30);

for j=1:1:length(xbar)
    aline(j)=line([xbar(j) xbar(j)],[ybar(j,2) ybar(j,3)],'Color',new_colors(j,:),'LineWidth',7);hold on;
          uistack(aline(j),'top');
end
bh=zeros(length(xbar),1);


hold off;
for j=1:1:length(xbar)
   %aline(j).Color='k';
   line([xbar(j) xbar(j)],[ybar(j,2) ybar(j,3)],'Color','k','LineWidth',7);hold on;
end
name_RU={'Adults - Reported','Adults - Unreported','Adolescents - Reported','Adolescents - Unreported','Children - Reported','Children - Unreported'};
lgd=legend(aline(1:j),name_RU,'Location',[0.629610544123382 0.605017582602949 0.265231085330749 0.310536971691289]);
hold on
annotation('textbox',...
    posit_panel,...
    'String','B: INFECTIONS PER VARIANT',...
    'LineStyle','none',...
    'FontSize',40,...
    'FitBoxToText','on','EdgeColor', 'none');    
lgd.FontSize = 20;  
     set(lgd,...
   'Position',[0.685416666666667 0.667705088265836 0.209375 0.256490134994808]);
          %   box on
       ax = gca;
xticks(xbar(4:6:end));
xticklabels({'Wild-Type','Alpha','Delta','Omicron'}) 
exportgraphics(gca,'fig3b.eps');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 3 Panel C hospitalizations to infections ratio (reported and unreported)

hos_c=zeros(num_ens,num_cat,num_var);
comp_names=["Children","Adolescents","Adults","All"];
for j=1:num_var
hos_c(:,:,j) = squeeze(sum(hos_e(ix_var(j,1):ix_var(j,2),:,:),1));
end

% ratio calc for hosp
for j=1:num_var
ratio_R2(:,:,j) = squeeze(sum(hos_e(ix_var(j,1):ix_var(j,2),:,:),1))./squeeze(sum(inf_RU(ix_var(j,1):ix_var(j,2),:,:),1));
end
ratio_R3=zeros(num_cat,3,num_var);
for j=1:num_var
ratio_R3(:,1,j)=shiftdim(mean(ratio_R2(:,:,j),1));
ratio_R3(:,2,j)=shiftdim(quantile(ratio_R2(:,:,j),0.025,1));
ratio_R3(:,3,j)=shiftdim(quantile(ratio_R2(:,:,j),0.975,1));
end
% burden cumulative per variant
bar_inf = zeros(num_var,num_cat,3);
for j=1:3
bar_inf(:,:,j)=[squeeze(ratio_R3(1,j,:)) squeeze(ratio_R3(2,j,:)) squeeze(ratio_R3(3,j,:))];
end
xbar = [1:2:5 8:2:12 15:2:19 22:2:26]';
ybar=zeros(num_cat*num_var,3);
for j=1:3
ybar(:,j)=reshape((bar_inf(:,:,j))',[num_cat*num_var 1]);
end

figure(3)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gca,'fontsize',40);
b=bar(xbar,ybar(:,1));
new_colors=repmat([col1;col3;col5],4,1);
b.FaceColor='flat';
for j = 1:length(xbar)
    b.CData(j,:) = new_colors(j,:);
end
xticklabels({'Wild-Type','Alpha','Delta','Omicron'})
ylabel({'Age-specific hospitalizations to infection ratio'});set(gca,'Fontsize',30);

for j=1:1:length(xbar)

    aline(j)=line([xbar(j) xbar(j)],[ybar(j,2) ybar(j,3)],'Color',new_colors(j,:),'LineWidth',7);hold on;
          uistack(aline(j),'top');
end


hold off;
for j=1:1:length(xbar)
   %aline(j).Color='k';
   line([xbar(j) xbar(j)],[ybar(j,2) ybar(j,3)],'Color','k','LineWidth',7);hold on;
end
name_RU={'Adults','Adolescents','Children'};
lgd2=legend(aline(1:j),name_RU,'Location','NorthEast');
hold on
annotation('textbox',...
    posit_panel,...
    'String','C: HOSPITALIZATIONS TO INFECTION RATIO PER VARIANT',...
    'LineStyle','none',...
    'FontSize',40,...
    'FitBoxToText','on','EdgeColor', 'none');  
lgd2.FontSize = 20;  
     set(lgd2,...
   'Position',[0.768382352941176 0.703258999931964 0.127440800833835 0.213660959541187]);
          %   box on
       ax = gca;
xticks(xbar(2:3:end));
xticklabels({'Wild-Type','Alpha','Delta','Omicron'}) 
exportgraphics(gca,'fig3c.eps');
% calculate fraction hospitalizations in total, just like for
% reported/unreported cases, and plot bars

