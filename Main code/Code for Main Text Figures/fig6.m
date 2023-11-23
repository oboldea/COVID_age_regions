warning ('off','all');
close all;
load('CBSprov.mat'); cbs=CBSprov; % load data CBS data on commuters; (i,j) is number of people living in i but working in j
load('pop.mat'); % load population
% constructed from CBSDataProvince, downloaded at the province level
% https://opendata.cbs.nl/statline/#/CBS/nl/dataset/83628NED/table, Dec
% 2018
pop1=sum(pop,2)/sum(pop,[1,2]);
% construct data
% calculate fraction of commuters in total population
P=12;
cbsmob1=reshape(cbs(:,4),P,P);
cbsmob=cbsmob1/sum(cbsmob1,[1,2]); %csmobout(i,j) fraction of total commuters
cbsmob=[[cbsmob sum(cbsmob,2)]; [sum(cbsmob,1) 1]]; % add totals
% add bogus row and then relative size of each province (bogus line because
% command heatmap does not support plotting multiple heatmaps one after
% another)
cbsmob = [cbsmob; zeros(1,P+1); [pop1' 1]];

% select the off-diagonal elements
xlab=["Groningen", "Friesland","Drenthe","Overijssel","Flevoland","Gelderland","Utrecht","North Holland","South Holland", ...
    "Zeeland","North Brabant","Limburg","Total"];
ylab=["Groningen", "Friesland","Drenthe","Overijssel","Flevoland","Gelderland","Utrecht","North Holland","South Holland", ...
    "Zeeland","North Brabant","Limburg","Total","A","% Population"];


figure1 = figure('WindowState','maximized',...
    'OuterPosition',[-0.00416666666666667 0.0296296296296296 1.00833333333333 0.977777777777778]);
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
h=heatmap(xlab,ylab,cbsmob*100,'InnerPosition',[0.132083333333333 0.0393873312564901 0.758333333333334 0.662005890743589],...
    'ColorScaling','log',...
       'ColorMethod','min','Colormap',flipud([0.0104166666666667 0 0;0.0208333333333333 0 0;0.03125 0 0;0.0416666666666667 0 0;0.0520833333333333 0 0;0.0625 0 0;0.0729166666666667 0 0;0.0833333333333333 0 0;0.09375 0 0;0.104166666666667 0 0;0.114583333333333 0 0;0.125 0 0;0.135416666666667 0 0;0.145833333333333 0 0;0.15625 0 0;0.166666666666667 0 0;0.177083333333333 0 0;0.1875 0 0;0.197916666666667 0 0;0.208333333333333 0 0;0.21875 0 0;0.229166666666667 0 0;0.239583333333333 0 0;0.25 0 0;0.260416666666667 0 0;0.270833333333333 0 0;0.28125 0 0;0.291666666666667 0 0;0.302083333333333 0 0;0.3125 0 0;0.322916666666667 0 0;0.333333333333333 0 0;0.34375 0 0;0.354166666666667 0 0;0.364583333333333 0 0;0.375 0 0;0.385416666666667 0 0;0.395833333333333 0 0;0.40625 0 0;0.416666666666667 0 0;0.427083333333333 0 0;0.4375 0 0;0.447916666666667 0 0;0.458333333333333 0 0;0.46875 0 0;0.479166666666667 0 0;0.489583333333333 0 0;0.5 0 0;0.510416666666667 0 0;0.520833333333333 0 0;0.53125 0 0;0.541666666666667 0 0;0.552083333333333 0 0;0.5625 0 0;0.572916666666667 0 0;0.583333333333333 0 0;0.59375 0 0;0.604166666666667 0 0;0.614583333333333 0 0;0.625 0 0;0.635416666666667 0 0;0.645833333333333 0 0;0.65625 0 0;0.666666666666667 0 0;0.677083333333333 0 0;0.6875 0 0;0.697916666666667 0 0;0.708333333333333 0 0;0.71875 0 0;0.729166666666667 0 0;0.739583333333333 0 0;0.75 0 0;0.760416666666667 0 0;0.770833333333333 0 0;0.78125 0 0;0.791666666666667 0 0;0.802083333333333 0 0;0.8125 0 0;0.822916666666667 0 0;0.833333333333333 0 0;0.84375 0 0;0.854166666666667 0 0;0.864583333333333 0 0;0.875 0 0;0.885416666666667 0 0;0.895833333333333 0 0;0.90625 0 0;0.916666666666667 0 0;0.927083333333333 0 0;0.9375 0 0;0.947916666666667 0 0;0.958333333333333 0 0;0.96875 0 0;0.979166666666667 0 0;0.989583333333333 0 0;1 0 0;1 0.0104166666666667 0;1 0.0208333333333333 0;1 0.03125 0;1 0.0416666666666667 0;1 0.0520833333333333 0;1 0.0625 0;1 0.0729166666666667 0;1 0.0833333333333333 0;1 0.09375 0;1 0.104166666666667 0;1 0.114583333333333 0;1 0.125 0;1 0.135416666666667 0;1 0.145833333333333 0;1 0.15625 0;1 0.166666666666667 0;1 0.177083333333333 0;1 0.1875 0;1 0.197916666666667 0;1 0.208333333333333 0;1 0.21875 0;1 0.229166666666667 0;1 0.239583333333333 0;1 0.25 0;1 0.260416666666667 0;1 0.270833333333333 0;1 0.28125 0;1 0.291666666666667 0;1 0.302083333333333 0;1 0.3125 0;1 0.322916666666667 0;1 0.333333333333333 0;1 0.34375 0;1 0.354166666666667 0;1 0.364583333333333 0;1 0.375 0;1 0.385416666666667 0;1 0.395833333333333 0;1 0.40625 0;1 0.416666666666667 0;1 0.427083333333333 0;1 0.4375 0;1 0.447916666666667 0;1 0.458333333333333 0;1 0.46875 0;1 0.479166666666667 0;1 0.489583333333333 0;1 0.5 0;1 0.510416666666667 0;1 0.520833333333333 0;1 0.53125 0;1 0.541666666666667 0;1 0.552083333333333 0;1 0.5625 0;1 0.572916666666667 0;1 0.583333333333333 0;1 0.59375 0;1 0.604166666666667 0;1 0.614583333333333 0;1 0.625 0;1 0.635416666666667 0;1 0.645833333333333 0;1 0.65625 0;1 0.666666666666667 0;1 0.677083333333333 0;1 0.6875 0;1 0.697916666666667 0;1 0.708333333333333 0;1 0.71875 0;1 0.729166666666667 0;1 0.739583333333333 0;1 0.75 0;1 0.760416666666667 0;1 0.770833333333333 0;1 0.78125 0;1 0.791666666666667 0;1 0.802083333333333 0;1 0.8125 0;1 0.822916666666667 0;1 0.833333333333333 0;1 0.84375 0;1 0.854166666666667 0;1 0.864583333333333 0;1 0.875 0;1 0.885416666666667 0;1 0.895833333333333 0;1 0.90625 0;1 0.916666666666667 0;1 0.927083333333333 0;1 0.9375 0;1 0.947916666666667 0;1 0.958333333333333 0;1 0.96875 0;1 0.979166666666667 0;1 0.989583333333333 0;1 1 0;1 1 0.015625;1 1 0.03125;1 1 0.046875;1 1 0.0625;1 1 0.078125;1 1 0.09375;1 1 0.109375;1 1 0.125;1 1 0.140625;1 1 0.15625;1 1 0.171875;1 1 0.1875;1 1 0.203125;1 1 0.21875;1 1 0.234375;1 1 0.25;1 1 0.265625;1 1 0.28125;1 1 0.296875;1 1 0.3125;1 1 0.328125;1 1 0.34375;1 1 0.359375;1 1 0.375;1 1 0.390625;1 1 0.40625;1 1 0.421875;1 1 0.4375;1 1 0.453125;1 1 0.46875;1 1 0.484375;1 1 0.5;1 1 0.515625;1 1 0.53125;1 1 0.546875;1 1 0.5625;1 1 0.578125;1 1 0.59375;1 1 0.609375;1 1 0.625;1 1 0.640625;1 1 0.65625;1 1 0.671875;1 1 0.6875;1 1 0.703125;1 1 0.71875;1 1 0.734375;1 1 0.75;1 1 0.765625;1 1 0.78125;1 1 0.796875;1 1 0.8125;1 1 0.828125;1 1 0.84375;1 1 0.859375;1 1 0.875;1 1 0.890625;1 1 0.90625;1 1 0.921875;1 1 0.9375;1 1 0.953125;1 1 0.96875;1 1 0.984375;1 1 1]),...
    'CellLabelFormat','%0.3f',...
    'FontSize',25,...
    'YLabel','',...
    'XLabel','');
ax = gca;
axp = struct(ax);       %you will get a warning
axp.Axes.XAxisLocation = 'top';

annotation('textbox',...
    [0.0182291666666667 0.935201229693176 0.6375 0.0607902735562321],...
    'String',{'FRACTION OUT OF TOTAL COMMUTERS'},...
    'FontSize',30,'FitBoxToText','on','EdgeColor','none');

% Create line
annotation(figure1,'line',[0.0302083333333333 0.1328125],...
    [0.842159916926273 0.700934579439252],'LineWidth',2);
% Create textbox
annotation(figure1,'textbox',...
    [0.022875 0.732087227414329 0.0792083333333333 0.0404984423676013],...
    'String','FROM',...
    'FontSize',25,...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.0676666666666667 0.797507788161993 0.0792083333333333 0.0404984423676013],...
    'String',{'    TO'},...
    'FontSize',25,...
    'FitBoxToText','off',...
    'EdgeColor','none');
% Create textbox
annotation(figure1,'textbox',...
    [0.834900210084033 0.0447026295107424 0.0536458333333333 0.0384215991692627],...
    'Color',[1 1 1],...
    'String',{'100'},...
    'HorizontalAlignment','center',...
    'FontSize',20,...
    'FitBoxToText','off',...
    'EdgeColor','none',...
    'BackgroundColor',[0 0 0]);

% Create rectangle
annotation(figure1,'rectangle',...
    [0.108193277310924 0.0800405268490375 0.785189075630252 0.0486322188449848],...
    'LineStyle','none',...
    'FaceColor',[1 1 1]);

% Create textbox
annotation(figure1,'textbox',...
    [0.833849789915966 0.131885855687804 0.0557335434173674 0.0384215991692628],...
    'Color',[1 1 1],...
    'String',{'100'},...
    'HorizontalAlignment','center',...
    'FontSize',20,...
    'FitBoxToText','off',...
    'EdgeColor','none',...
    'BackgroundColor',[0 0 0]);

% Create textbox
annotation(figure1,'textbox',...
    [0.250525210084034 0.264295656620175 0.0479166666666667 0.0373831775700934],...
    'String','   0',...
    'LineStyle','none',...
    'HorizontalAlignment','center',...
    'FontSize',20,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Create textbox
annotation(figure1,'textbox',...
    [0.132803746498599 0.265359328592576 0.0479166666666666 0.0373831775700935],...
    'String','   0',...
    'LineStyle','none',...
    'HorizontalAlignment','center',...
    'FontSize',20,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);

% Create textbox
annotation(figure1,'textbox',...
    [0.659370623249299 0.573767387249193 0.0479166666666666 0.0373831775700934],...
    'String','   0',...
    'LineStyle','none',...
    'HorizontalAlignment','center',...
    'FontSize',20,...
    'FitBoxToText','off',...
    'BackgroundColor',[1 1 1]);


s=struct(h);
s.XAxis.TickLabelRotation = 90;   % horizontal
