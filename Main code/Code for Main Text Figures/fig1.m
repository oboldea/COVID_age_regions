close all
startdate=bdate;
enddate=edate;
%load output % uncomment this to load results

posit_panel=[0.095012605042017 0.900246638106434 0.330882343236639 0.0770010111783656];
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


data1=readtable('dates.xls','ReadVariableNames',1); % import dates
date1 = datetime(data1.obs_date, 'InputFormat', 'MM-dd-yyyy');
date1=date1(startdate-datenum("27-feb-2020")+1:enddate-datenum("27-feb-2020")+1);
col=get(gca,'ColorOrder');
ixcol = col([3;5;6],:);
% variant index
ix_var=[1 tg1b-1;tg1b tg1e; tg2b tg2e; tg3b tg3e];
num_var=size(ix_var,1);
j=1:1:12;
% calculate estimated seroprev.
 col2 = rgb('Thistle');
 col1 = rgb('Plum');
 col4 = rgb('PaleTurquoise');
 col3 = rgb('Turquoise');
  col6=rgb('Khaki');
  col5=rgb('Gold');
cmap=[col1;col3;col5;col6];
col2=rgb('Red');
col3=rgb('Black');
col4=rgb('RoyalBlue');
colg=rgb('ForestGreen');
coln2=rgb('DarkMagenta');

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
    hos=hos(startdate-bdate+1:end,:);
else
    hos=hos(startdate-bdate+1:enddate-bdate+1,:);
end
num_times=enddate-startdate+1;

posleg=[0.188006095297388 0.639241394500908 0.196354161606481 0.254932495168684];
data1=readtable('dates.xls','ReadVariableNames',1); % import dates, different dates for different hospitalization series
date1 = datetime(data1.obs_date, 'InputFormat', 'MM-dd-yyyy');
date2=date1(startdate-datenum("27-feb-2020")+1:startdate-datenum("27-feb-2020")+size(hos,1));
date1=date1(startdate-datenum("27-feb-2020")+1:enddate-datenum("27-feb-2020")+1);
date3 = date1(enddate-datenum("27-feb-2020")-size(hos_young,1)+1:enddate-datenum("27-feb-2020"));
%positions of variant boxes on plot
pos_variants=[ [0.466155696712647 0.925208394486583 0.0782770763965953 0.0747663551401879];
    [0.635264590270071 0.926272066458982 0.0782770763965959 0.0747663551401866];
    [0.795330007002801 0.925233644859813 0.1109375 0.0747663551401859]];
% position panels
pos_panels=[0.125986787167697 0.919645820799938 0.17384453279068 0.0770010111783656];

gr=[0.85,0.85,0.85];
pop_new=repmat(permute(pop0,[3 1 2]),num_times,1,1); % to divide by population in each age group
pop_new=(squeeze(sum(pop_new,2)))'/1000;
pop_tot=repmat(sum(sum(pop0,2),1),1,num_times)/1000;
fnt = 40; % fontsize

% Fig 1 Panel A
figure(1)
box on
ax = gca;
ax.LineWidth = 2;
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gca,'fontsize',40);
hos_new = [[sum(hos(:,1:num_loc),2) hos(:,num_loc+1) hos(:,num_loc+2)]; [(sum(zikenhuis(:,end-122:end),1))'-hos_young(:,1)-hos_young(:,2) hos_young(:,1) hos_young(:,2)]];
% national hosp 
post_tot=zeros(num_ens,num_times);
for c=1:num_cat
    for j=1:num_loc
    post_tot=post_tot+squeeze(sum(x_post(num_out*num_loc*(c-1)+num_out*(j-1)+8,:,:)+x_post(num_out*num_loc*(c-1)+num_out*(j-1)+17,:,:),1));    
    end
end
    meanpost=(mean(post_tot,1));
    ci= quantile(post_tot, [.025 .975]);
     ci(1,:)=ci(1,:);
     ci(2,:)=ci(2,:);
     xx=[date1' fliplr(date1')];
         yy=[ci(1,:) fliplr(ci(2,:))];
    hold on
    patch(xx,yy,gr,'EdgeColor',gr,'Linewidth',10);

     hosp=(sum(hos,2))'; % national hospitalizations
  
     plot(date1,meanpost(1,:),'LineWidth',6,'color', coln2); % plot mean fit
     plot(date1,sum(zikenhuis,1),'.','MarkerSize',20,'color', col4); % Dashboard data, only used October 1, 2021
     plot(date2,hosp,'.','MarkerSize',20, 'color', col3); % plot data
     xtickangle(45)
    xlim([date1(1) date1(end)+1])
               xticks(date1(dates_plot));
    xticklabels(["Apr 2020","Jul 2020","Oct 2020","Jan 2021", "Apr 2021","Jul 2021","Oct 2021","Jan 2022"]);
    ylim([0 610])
    ylab=ylabel('Hospitalizations (1/day)','FontSize',40);
    
    hold on
    case_lab=["Hospitalizations (1/day)", "Hospitalizations (1/day)","Hospitalizations (1/day)"];
   set(gca,'fontsize',40);
   % variant lines (when they become dominant (ie 50%)
   for i=1:3
    xline(tg(i),'','LineWidth', 6,'color',ixcol(i,:)); 
           xline(tg_be(i,1),':','LineWidth', 6,'color',ixcol(i,:)); 
   end
  % labels for variants 

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
legend1=legend({' 95% CrI','Data 1', 'Data 2','Model Mean'},'Location','northwest');
           set(legend1,...
    'Position',posleg);
    annotation('textbox',...
     pos_panels,...
    'String',char(panel_names(1)),...
    'LineStyle','none',...
    'FontSize',40,...
    'FitBoxToText','off','EdgeColor', 'none'); 
  set(gca, 'Layer', 'Top');
hold off;
exportgraphics(gcf,'fig1a.eps');

% hospitalizations per age
for c=1:3
         figure(1+c)
         box on
        ax = gca;
        ax.LineWidth = 2;
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    set(gca,'fontsize',40);
   j=1:12;
    post=squeeze(sum(x_post(num_out*num_loc*(c-1)+num_out*(j-1)+8,:,:)+x_post(num_out*num_loc*(c-1)+num_out*(j-1)+17,:,:),1));
    meanpost=(mean(post,1));
    ci= quantile(post, [.025 .975]);
     ci(1,:)=ci(1,:);
     ci(2,:)=ci(2,:);
     xx=[date1' fliplr(date1')];
         yy=[ci(1,:) fliplr(ci(2,:))];
    hold on
      if c==1
      patch(xx,yy,gr,'EdgeColor',gr,'LineWidth',10);
      else
      patch(xx,yy,gr,'EdgeColor',gr,'LineWidth',5); % make sure the CrI is visible but does appear to go below zero just because of line width
      end
     plot(date1,meanpost(1,:),'LineWidth',6,'color', cmap(c,:)); % plot mean fit
     if c==1
     plot(date2,sum(hos(:,1:num_loc),2),'.','MarkerSize',20, 'color', col3); % plot data
     else
      plot(date2,hos(:,num_loc-1+c),'.','MarkerSize',20, 'color', col3); % plot data
     end
     plot(date3,hos_new(end-size(hos_young,1)+1:end,c),'.','MarkerSize',20, 'color', colg); % plot data
     xtickangle(45)
         xlim([date1(1) date1(end)+1])
                    xticks(date1(dates_plot));
    xticklabels(["Apr 2020","Jul 2020","Oct 2020","Jan 2021", "Apr 2021","Jul 2021","Oct 2021","Jan 2022"]);
         if c==1
         ylim([0 610])
         else
          ylim([0 30])
         end
    if c==2
        ylab=ylabel('Hospitalizations (1/day)','FontSize',40);     
    end   
    hold on;
    for i=1:3
    xline(tg(i),'','LineWidth',6,'color',ixcol(i,:));hold on;
           xline(tg_be(i,1),':','LineWidth', 6,'color',ixcol(i,:)); hold on;
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
legend1=legend({' 95% CrI','Data 1','Data 3','Model Mean'},'Location','northwest');
set(legend1,...
    'Position',posleg);
annotation('textbox',...
    pos_panels,...
    'String',char(panel_names(c+1)),...
    'LineStyle','none',...
    'FontSize',40,...
    'FitBoxToText','on','EdgeColor', 'none');   

      set(gca, 'Layer', 'Top'); hold off;
    if c==1 
     exportgraphics(gcf,'fig1b.eps');
    elseif c==2
     exportgraphics(gcf,'fig1c.eps');
    else
     exportgraphics(gcf,'fig1d.eps');
    end
end

