close all
startdate=datenum('27-Feb-2020');
enddate=datenum('31-jan-2022');
%load output % uncomment this to load results

% variant beginning (5%), dominant and end 
% variants become 50% dominant
tg1=datenum('08-Feb-2021')-datenum('27-Feb-2020')+1;
tg2=datenum('23-Jun-2021')-datenum('27-Feb-2020')+1;
tg3=datenum('24-Dec-2021')-datenum('27-Feb-2020')+1;
t_dom=[tg1;tg2;tg3];
% variant beginning (5%) and end
tg1b=datenum('29-Dec-2020')-datenum('27-Feb-2020')+1;
tg1e=datenum('31-May-2021')-datenum('27-Feb-2020')+1;
tg2b=datenum('1-June-2021')-datenum('27-Feb-2020')+1;
tg2e=datenum('09-Dec-2021')-datenum('27-Feb-2020')+1;
tg3b=datenum('10-Dec-2021')-datenum('27-Feb-2020')+1;
tg3e=datenum('31-Jan-2022')-datenum('27-Feb-2020')+1;
tg_be=[[tg1b tg1e]; [tg2b tg2e];[tg3b tg3e]];




data1=readtable('dates.xls','ReadVariableNames',1); % import dates
date1 = datetime(data1.obs_date, 'InputFormat', 'MM-dd-yyyy');
date1=date1(startdate-datenum("27-feb-2020")+1:enddate-datenum("27-feb-2020")+1);
ylab=["Fraction Seropositive"];

% variant index
ix_var=[1 tg1b-1;tg1b tg1e; tg2b tg2e; tg3b tg3e];
j=1:1:12;
 col2 = rgb('Thistle');
 col1 = rgb('Plum');
 col4 = rgb('PaleTurquoise');
 col3 = rgb('Turquoise');
 col6=rgb('Khaki');
 col5=rgb('Gold');
cmap=[col1;col2;col3;col4;col5;col6];
gr=[0.85,0.85,0.85];
% plot seroprevalence
make_it_tight = true;
subplot = @(m,n,p) subtightplot (m, n, p, [0.001 0.05], [0.1 0.1], [0.1 0.01]);
if ~make_it_tight,  clear subplot;  end



p_sero =mean_sero./N_sero;
tg_sero=[tg1b-1 tg1e tg2e tg3e]';
num_var=size(tg_sero,1);
sero_esti=zeros(num_cat,num_var,3); % means and CI

% Fig 2 Panel A
figure(1)
        box on
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
for c=1:3
      hold on;
      subplot(1,num_cat,c)
        box on
        ax = gca;
        ax.LineWidth = 2;
    post=x_post(num_out*num_loc*(c-1)+num_out*(j-1)+1,:,:)+x_post(num_out*num_loc*(c-1)+num_out*(j-1)+10,:,:);
    popc=squeeze(repmat(sum(pop0(:,c),1),1,num_ens,num_times));
    s_sum=squeeze(sum(post,1))./popc;
    meanpost1=1-mean(s_sum);
    ci1post=quantile(1-s_sum, 0.025);
    ci2post=quantile(1-s_sum, 0.975);
    % retrieve sero per variant
   
    sero_esti(c,:,1)=meanpost1(1,tg_sero);
    sero_esti(c,:,2)=ci1post(1,tg_sero);
    sero_esti(c,:,3)=ci2post(1,tg_sero);
    xx=[date1' (fliplr(date1'))];
    yy=[ci1post fliplr(ci2post)];

    hold on
    patch(xx,yy,gr,'EdgeColor',gr, 'LineWidth',7);
    xlim([date1(1) date1(end)+7])

    xtickangle(45)
    plot(date1,meanpost1,'Color',cmap(2*(c-1)+1,:), 'LineWidth',5);
    dates_plot=[datenum('1-Sep-2020') datenum('1-Jun-2021')  datenum('1-Jan-2022')]-datenum('27-Feb-2020');
    
        xticks(date1(dates_plot));
    xticklabels(["Sep 2020","Jun 2021","Jan 2022"]);
    if c~=1
        set(gca,'YTick', []);
    end
  set(gca,'linewidth',2,'Fontsize',40);       

    for s=1:4
    plot(date1(tsero(s)),mean_sero(c,s)./N_sero(c,s),'.k','MarkerSize',40);
    end
            for kk=1:9
            yline(kk/10,'--k', 'LineWidth', 0.5);
            end
    hold on
   if c==1
         ylabel(ylab(c),'FontSize',40); set(gca,'fontsize',40);
   end
   if c==1
       legend1=legend({' 95% Quantiles','Adults Mean','Data'},'Location','northwest','FontSize',30);
                 box on
        ax = gca;
        ax.LineWidth = 2;
     set(gca, 'Layer', 'Top');
   elseif c==2
       legend1=legend({' 95% Quantiles','Adolescents Mean','Data'},'Location','northwest','FontSize',30);
                 box on
        ax = gca;
        ax.LineWidth = 2;
     set(gca, 'Layer', 'Top');
   else
     legend1=legend({' 95% Quantiles','Children Mean','Data'},'Location','northwest','FontSize',30);
                      box on
        ax = gca;
        ax.LineWidth = 2;
     set(gca, 'Layer', 'Top');
   end
end
posit_panel=[0.095012605042017 0.900246638106434 0.330882343236639 0.0770010111783656];
hold on
annotation('textbox',...
    posit_panel,...
    'String','A: SEROPREVALENCE',...
    'LineStyle','none',...
    'FontSize',40,...
    'FitBoxToText','on','EdgeColor', 'none');

% calculate mean and CI for data per variant , all ages
s_post=zeros(num_ens,num_times);
j=1:1:num_loc;
for c=1:3
s_post=s_post+squeeze(sum(x_post(num_out*num_loc*(c-1)+num_out*(j-1)+1,:,:)+x_post(num_out*num_loc*(c-1)+num_out*(j-1)+10,:,:),1));
end
sero_sum=1-(1/sum(sum(pop0,2),1))*s_post(:,tg_sero);
sero_tot=[mean(sero_sum,1);(quantile(sero_sum, [0.025 0.975],1))];
exportgraphics(gcf,sprintf('fig2a.eps'));

% Fig 2 Panels B-D
para=x_post(end-num_para+1:end,:,startdate-bdate+1:enddate-bdate+1);
%plot results
jmin=1;
jmax=num_loc;
% subfigure panel names
panel_names={'A: TOTAL', 'B: CASES ADULTS', 'C: CASES ADOLESCENTS', 'D: CASES CHILDREN'};
x_post=x_post(:,:,startdate-bdate+1:enddate-bdate+1);
inc=inc(startdate-bdate+1:enddate-bdate+1,:,:);
dates_plot=[datenum('1-Apr-2020') datenum('1-Jul-2020') datenum('1-Oct-2020') datenum('1-Jan-2021') datenum('1-Apr-2021') datenum('1-Jul-2021') datenum('1-Oct-2021') datenum('1-Jan-2022')]-datenum('27-Feb-2020');

posleg=[0.177279874213837 0.726057906458797 0.161556603773584 0.185141631169834];
data1=readtable('dates.xls','ReadVariableNames',1); % import dates
date1 = datetime(data1.obs_date, 'InputFormat', 'MM-dd-yyyy');
date2=date1(startdate-datenum("27-feb-2020")+1:startdate-datenum("27-feb-2020")+size(hos,1));
date1=date1(startdate-datenum("27-feb-2020")+1:enddate-datenum("27-feb-2020")+1);
date3 = date1(enddate-datenum("27-feb-2020")-size(hos_young,1)+1:enddate-datenum("27-feb-2020"));
%positions of variant boxes on plot
pos_variants=[ [0.486468196712647 0.926246816085752 0.0782770763965954 0.0747663551401875];
    [0.635264590270071 0.926272066458982 0.0782770763965959 0.0747663551401866];
    [0.795330007002801 0.925233644859813 0.1109375 0.0747663551401859]];
% position first wave
pos_wave1=[[0.158232704402516 0.712694877505568 0.101594339622641 0.111358574610245];
    [0.591015723270441 0.714922048997772 0.101594339622641 0.111358574610245];
  [0.158232704402516 0.238307349665924 0.101594339622641 0.111358574610245];
   [0.591015723270441 0.230141054194506 0.101594339622641 0.110616184112843]];
% position panels
pos_panels=[0.125986787167697 0.919645820799938 0.17384453279068 0.0770010111783656];
 col2 = rgb('Thistle');
 col1 = rgb('Plum');
 col4 = rgb('PaleTurquoise');
 col3 = rgb('Turquoise');
  col6=rgb('Khaki');
  col5=rgb('Gold');
cmap=[col1;col3;col5];
col=get(gca,'ColorOrder');
ixcol = col([3;5;6],:);
case_lab=["Reported (per 1,000 adults)", "Reported (per 1,000 adolescents)","Reported (per 1,000 children)"];
% plot national cases in 1,000 individuals per population: adults,
% adolescents, children
gr=[0.85,0.85,0.85];
pop_new=repmat(permute(pop0,[3 1 2]),num_times,1,1); % to divide by population in each age group
pop_new=(squeeze(sum(pop_new,2)))'/1000;
pop_tot=repmat(sum(sum(pop0,2),1),1,num_times)/1000;
for c=1:3
   figure(c+1)
   set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
   set(gca,'fontsize',40);
   j=1:12;
    post=squeeze(sum(x_post(num_out*num_loc*(c-1)+num_out*(j-1)+7,:,:)+x_post(num_out*num_loc*(c-1)+num_out*(j-1)+16,:,:),1));
    meanpost=(mean(post,1))./pop_new(c,:);
    ci= quantile(post, [.025 .975]);
     ci(1,:)=ci(1,:)./pop_new(c,:);
     ci(2,:)=ci(2,:)./pop_new(c,:);
     xx=[date1' fliplr(date1')];
         yy=[ci(1,:) fliplr(ci(2,:))];
    hold on
         patch(xx,yy,gr,'EdgeColor',gr,'Linewidth',10);

     plot(date1,meanpost(1,:),'LineWidth',6,'color', cmap(c,:)); % plot mean fit
     % plot data only every other 7 days until Omicron, else plot too dense 
     inc2=(sum(inc(:,:,c),2))'./pop_new(c,:);
     %inc7days = [inc2(1:7:7*round(num_times/7,0)) inc2(7*round(num_times/7,0)+1:1:end)];
     %date7days=[date1(1:7:7*round(num_times/7,0)); date1(7*round(num_times/7,0)+1:1:end)];
     inc7days = [inc2(1:7:674) inc2(675:1:end)];
     date7days=[date1(1:7:674); date1(675:1:end)];
     plot(date7days,inc7days,'.k','MarkerSize',10); % plot data
           xticks(date1(dates_plot));
    xticklabels(["Apr 2020","Jul 2020","Oct 2020","Jan 2021", "Apr 2021","Jul 2021","Oct 2021", "Jan 2022"]);
   xtickangle(45)
         xlim([date1(1) date1(end)+1]);
                  ylim([0 13])
         yticks([ 0 2 4 6 8 10 12]);
   
    ylab=ylabel(case_lab(c),'fontsize',40);  hold on;
    for i=1:3
    xline(t_dom(i),'','LineWidth',6,'color',ixcol(i,:));hold on;
       xline(tg_be(i,1),':','LineWidth', 6,'color',ixcol(i,:)); 
   end
  % labels of which variants 
  annotation('textbox',...
    pos_variants(1,:),...
    'String',{'Alpha'},...
    'LineStyle','none',...
    'FontSize',40,...
    'FitBoxToText','off',...
    'BackgroundColor',ixcol(1,:));
    annotation('textbox',...
    pos_variants(2,:),...
    'String','Delta',...
    'LineStyle','none',...
    'FontSize',40,...
    'FitBoxToText','off',...
    'BackgroundColor',ixcol(2,:));
   annotation('textbox',...
    pos_variants(3,:),...
    'String','Omicron',...
    'LineStyle','none',...
    'FontSize',40,...
    'FitBoxToText','off',...
    'BackgroundColor',ixcol(3,:));
box on;

         ax = gca;
        ax.LineWidth = 2;
lgd=legend({' 95% CrI',' Model Mean',' Data'},'Location','northwest','FontSize',30);
set(lgd,...
    'Position',[0.192051820728291 0.742992236883163 0.169642852885383 0.157041535491035]);
annotation('textbox',...
    pos_panels,...
    'String',char(panel_names(c+1)),...
    'LineStyle','none',...
    'FontSize',40,...
    'FitBoxToText','on','EdgeColor', 'none');

     set(gca, 'Layer', 'Top');
axes('position',[0.190704973970721 0.422868000517634 0.259505110062892 0.300839294428369])
box on
range=1:64;% zoom in for the first 64 days
xx=[date1(range)' fliplr(date1(range)')];
         yy=[ci(1,range) fliplr(ci(2,range))];
    hold on
         patch(xx,yy,gr,'EdgeColor',gr);
     plot(date1(range),meanpost(1,range),'LineWidth',4,'color', cmap(c,:)); % plot mean fit
     % plot only every other 7 days until obs 600
     incwave1=(sum(inc(range,:,c),2))'./pop_new(c,range);
      plot(date1(range),incwave1,'.k','MarkerSize',15); % plot data
     xtickangle(45)
    xlim([date1(range(1)) date1(range(end))]);set(gca,'Fontsize',25);
 if c==3
         ylim([0 0.008]);
             % Set the remaining axes properties
         yticks([0 0.002 0.004 0.006 0.008])
          yticklabels({'0','0.002','0.004','0.006','0.008'})
 end
box on;

         ax = gca;
        ax.LineWidth = 2;
            set(gca,'Layer', 'Top');  
 hold off
  if c==1
      exportgraphics(gcf,'fig2b.eps');
  elseif c==2
        exportgraphics(gcf,'fig2c.eps');
  else 
      exportgraphics(gcf,'fig2d.eps');
  end
end
