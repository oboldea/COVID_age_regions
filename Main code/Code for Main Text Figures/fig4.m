close all
startdate=datenum('27-Feb-2020');
enddate=datenum('31-jan-2022');
%load output % uncomment this to load results

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

para=x_post(end-num_para+1:end,:,startdate-bdate+1:enddate-bdate+1);
%plot results
names=["Groningen", "Friesland","Drenthe","Overijssel","Flevoland","Gelderland","Utrecht","North Holland","South Holland","Zeeland","North Brabant","Limburg"];
hold on;
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
col2 = rgb('Thistle');
 col1 = rgb('Plum');
 col4 = rgb('PaleTurquoise');
 col3 = rgb('Turquoise');
  col6=rgb('Khaki');
  col5=rgb('Gold');
new_colors=repmat([col1;col2;col3;col4;col5;col6],4,1);
% % position of legends
pos_leg=[[0.15041928721174 0.843596711912129 0.0939465386781303 0.0783221952633764]; 
[0.595780922431866 0.858450880154794 0.0939465386781302 0.0593912381327586];
[0.152384696016771 0.385548133309954 0.0939465386781303 0.0593912381327586];
[0.59420859538784 0.38406335231515 0.0939465386781302 0.0593912381327587]];
posit_new=[0.180638364779876 0.363028953229397 0.248213836477987 0.304380103934671];
posit_var=[[0.465999207230063 0.925760950259835 0.0609913059563439 0.0653303637713436];
    [0.635156492785796 0.927044902214308 0.0598120606733232 0.0653303637713436];
    [0.818789308176101 0.926774121485771 0.0860849056603787 0.0653303637713436]];

inf_1 = zeros(num_times,num_ens,num_cat); % reported and unreported
inf_2  = zeros(num_times,num_ens,num_cat); % reported 
hos_e1  = zeros(num_times,num_ens,num_cat); % estimated hospitalizations
hos_e2  = zeros(num_times,num_ens,num_cat); % estimated hospitalizations
for c=1:num_cat
   post_inf1=zeros(num_ens,num_times);
   post_inf2=zeros(num_ens,num_times);
   post_hos1 = zeros(num_ens,num_times);
   post_hos2 = zeros(num_ens,num_times);
    for j=1:num_loc
     % total over regions
    post_inf1=post_inf1+squeeze(x_post(num_out*num_loc*(c-1)+num_out*(j-1)+7,:,:))./squeeze(x_post(num_s+ixalpha(c),:,:));
    post_inf2=post_inf2+squeeze(x_post(num_out*num_loc*(c-1)+num_out*(j-1)+16,:,:))./squeeze(x_post(num_s+ixalpha(c),:,:));  
    post_hos1 = post_hos1+ squeeze(x_post(num_out*num_loc*(c-1)+num_out*(j-1)+8,:,:));
    post_hos2 = post_hos2+ squeeze(x_post(num_out*num_loc*(c-1)+num_out*(j-1)+17,:,:));
    end
    inf_1(:,:,c)=(post_inf1)';
    inf_2(:,:,c)=(post_inf2)';
    hos_e1(:,:,c)=(post_hos1)';
    hos_e2(:,:,c)= (post_hos2)';
end
% bar plot of case detection rates per variant
ix_var=[1 tg1b-1;tg1b tg1e; tg2b tg2e; tg3b tg3e];
num_var=size(ix_var,1);
% find ratio of cumulative cases in an age category to cumulative cases
% across all age categories at each point in time
popn=repmat(sum(pop0,1),num_ens,1);

ratio_inf1=zeros(num_ens,num_cat,num_var);
ratio_inf2=zeros(num_ens,num_cat,num_var);
for j=1:num_var
ratio_inf1(:,:,j) = squeeze(sum(inf_1(ix_var(j,1):ix_var(j,2),:,:),1))./popn;
ratio_inf2(:,:,j) = squeeze(sum(inf_2(ix_var(j,1):ix_var(j,2),:,:),1))./popn;
end
ratio_21=zeros(num_cat,3,num_var);
ratio_22=zeros(num_cat,3,num_var);
for j=1:num_var
ratio_21(:,1,j)=shiftdim(mean(ratio_inf1(:,:,j),1));
ratio_21(:,2,j)=shiftdim(quantile(ratio_inf1(:,:,j),0.025,1));
ratio_21(:,3,j)=shiftdim(quantile(ratio_inf1(:,:,j),0.975,1));
ratio_22(:,1,j)=shiftdim(mean(ratio_inf2(:,:,j),1));
ratio_22(:,2,j)=shiftdim(quantile(ratio_inf2(:,:,j),0.025,1));
ratio_22(:,3,j)=shiftdim(quantile(ratio_inf2(:,:,j),0.975,1));
end
% infection burden cumulative per variant
bar_inf = zeros(num_var,2*num_cat,3);
for j=1:3
bar_inf(:,:,j)=[squeeze(ratio_21(1,j,:)) squeeze(ratio_22(1,j,:)) squeeze(ratio_21(2,j,:))...
    squeeze(ratio_22(2,j,:)) squeeze(ratio_21(3,j,:)) squeeze(ratio_22(3,j,:))];
end
xbar = [1:1:6 8:1:13 15:1:20 22:1:27]';
ybar=zeros(2*num_cat*num_var,3);
for j=1:3
ybar(:,j)=reshape((bar_inf(:,:,j))',[2*num_cat*num_var 1]);
end
posit_panel=[0.127575630252101 0.916457377721428 0.158088230739246 0.0770010111783656];

% Fig 4 Panel A
figure(1)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gca,'fontsize',40);
b=bar(xbar,ybar(:,1));
b.FaceColor='flat';
for j = 1:length(xbar)
    b.CData(j,:) = new_colors(j,:);
end
xticklabels({'Wild-Type','Alpha','Delta','Omicron'})
ylabel({'Age-specific infections to population ratio'});set(gca,'Fontsize',30);
for j=1:1:length(xbar)
    aline(j)=line([xbar(j) xbar(j)],[ybar(j,2) ybar(j,3)],'Color',new_colors(j,:),'LineWidth',7);hold on;
          uistack(aline(j),'top');
end
hold off;
for j=1:1:length(xbar)
   %aline(j).Color='k';
   line([xbar(j) xbar(j)],[ybar(j,2) ybar(j,3)],'Color','k','LineWidth',7);hold on;
end
ylim([0 0.4]);
name_RU={'Adults: primary','Adults: breakthrough & re-infections','Adolescents: primary','Adolescents: breakthrough & re-infections','Children: primary','Children: re-infections'};
lgd=legend(aline(1:j),name_RU,'Location','Northwest');
hold on
annotation('textbox',...
    posit_panel,...
    'String','A: INFECTIONS PER VARIANT',...
    'LineStyle','none',...
    'FontSize',40,...
    'FitBoxToText','on','EdgeColor', 'none');    
lgd.FontSize = 22;  
             box on
      lgd.NumColumns = 1;
       ax = gca;     
xticks(xbar(4:6:end));
xticklabels({'Wild-Type','Alpha','Delta','Omicron'}) 
exportgraphics(gca,'fig4a.eps');



% repeat calculations for cumulative hospitalizations instead of infections
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ratio_hos1=zeros(num_ens,num_cat,num_var);
ratio_hos2=zeros(num_ens,num_cat,num_var);

for j=1:num_var
ratio_hos1(:,:,j) = squeeze(sum(hos_e1(ix_var(j,1):ix_var(j,2),:,:),1))./(squeeze(sum(inf_1(ix_var(j,1):ix_var(j,2),:,:),1))+squeeze(sum(inf_1(ix_var(j,1):ix_var(j,2),:,:),1)));
ratio_hos2(:,:,j) = squeeze(sum(hos_e2(ix_var(j,1):ix_var(j,2),:,:),1))./(squeeze(sum(inf_2(ix_var(j,1):ix_var(j,2),:,:),1))+squeeze(sum(inf_1(ix_var(j,1):ix_var(j,2),:,:),1)));
end
ratio_21=zeros(num_cat,3,num_var);
ratio_22=zeros(num_cat,3,num_var);
for j=1:num_var
ratio_21(:,1,j)=shiftdim(mean(ratio_hos1(:,:,j),1));
ratio_21(:,2,j)=shiftdim(quantile(ratio_hos1(:,:,j),0.025,1));
ratio_21(:,3,j)=shiftdim(quantile(ratio_hos1(:,:,j),0.975,1));
ratio_22(:,1,j)=shiftdim(mean(ratio_hos2(:,:,j),1));
ratio_22(:,2,j)=shiftdim(quantile(ratio_hos2(:,:,j),0.025,1));
ratio_22(:,3,j)=shiftdim(quantile(ratio_hos2(:,:,j),0.975,1));
end
% hosp burden cumulative per variant
bar_inf = zeros(num_var,2*num_cat,3);
for j=1:3
bar_inf(:,:,j)=[squeeze(ratio_21(1,j,:)) squeeze(ratio_22(1,j,:)) squeeze(ratio_21(2,j,:))...
    squeeze(ratio_22(2,j,:)) squeeze(ratio_21(3,j,:)) squeeze(ratio_22(3,j,:))];
end
xbar = [1:1:6 8:1:13 15:1:20 22:1:27]';
ybar=zeros(2*num_cat*num_var,3);
for j=1:3
ybar(:,j)=reshape((bar_inf(:,:,j))',[2*num_cat*num_var 1]);
end

posit_panel=[0.127575630252101 0.916457377721428 0.158088230739246 0.0770010111783656];
% Figure 4 Panel B
figure(2)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gca,'fontsize',40);
b=bar(xbar,ybar(:,1));

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
    line([xbar(j) xbar(j)],[ybar(j,2) ybar(j,3)],'Color','k','LineWidth',7);hold on;
end
ylim([0 0.006]);
 yticks([0; 0.002; 0.004; 0.006]);
  yticklabels(["0","0.002","0.004","0.006"]);
hold on
annotation('textbox',...
    posit_panel,...
    'String','B: HOSPITALIZATIONS TO INFECTION RATIO PER VARIANT',...
    'LineStyle','none',...
    'FontSize',40,...
    'FitBoxToText','on','EdgeColor', 'none');    
             box on
%       lgd.NumColumns = 1;
       ax = gca;
       
xticks(xbar(4:6:end));
xticklabels({'Wild-Type','Alpha','Delta','Omicron'}) 
name_RU={'Adults: primary','Adults: breakthrough & re-infections','Adolescents: primary','Adolescents: breakthrough & re-infections','Children: primary','Children: re-infections'};
lgd=legend(aline(1:j),name_RU,'Location','Northeast');
lgd.FontSize = 22;  
exportgraphics(gca,'fig4b.eps');

