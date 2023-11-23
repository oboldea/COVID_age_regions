% function checkbound.m
% checks if values of variables are reasonable: do not exceed population, are non-negative
% redistributes parameters into their prior bounds if they are out of bound
% checks if initial priors lead to unreasonable values of S
% INPUTS
% x             : (num_out x num_loc x num_cat +num_para) x num_ens prior draws of state
%                  variables and parameters
% x contains the following state variables in order, per region and then
% per age category, then at the end parameters are appended
%%% first - naive compartment
% 1 S susceptibles
% 2 E exposed
% 3 Is documented infected 
% 4 Ia undocumented infected 
% 5 H hospitalized patients
% 6 R Recovered
% 7 obs new confirmed cases
% 8 Hobs new hospitalizations
% 9 Rnew newly recovered people
%%% second - vaccinated or previously infected and waned compartment 
% 10 S susceptibles
% 11 E exposed
% 12 Is documented infected
% 13 Ia undocumented infected
% 14 H hospitalized patients
% 15 R Recovered
% 16 obs new confirmed cases
% 17 Hobs new hospitalizations
% 18 Wnew Waned people in the current period
% 19 Rnew Recovered people in the current period
% 20 WunV The pool of waned people that are not yet vaccinated
% pop                 : num_loc x num_ens x num_cat x2, population in each
%                       region /age category for the 2 sets of compartments: naive and vaccinated
%                       or previously infected
% num_cat       : scalar, no. of age categories
% num_out       : scalar, number of state variable per age x region that
%                 are updated
% num_s         : scalar, number of state variables
% ix_alph       : scalar, index of case detection rates among all
% parameters
% OUTPUT
% x             : (num_out x num_loc x num_cat +num_para) x num_ens bound corrected prior draws of state
%                  variables and parameters

function x = checkbound(x,pop,parabounds,num_cat,num_out)

xmin=parabounds(:,1);
xmax=parabounds(:,2);
num_para=size(parabounds,1);
num_loc=size(pop,1);
num_ens=size(x,2);
for i=1:num_loc
    
    for c=1:num_cat
        for j=1:num_ens
            % only susceptibles
        x(num_out*num_loc*(c-1)+(i-1)*num_out+1,x(num_out*num_loc*(c-1)+(i-1)*num_out+1,j)-pop(i,j,c,1)>0)=pop(i,j,c,1);
        x(num_out*num_loc*(c-1)+(i-1)*num_out+8,x(num_out*num_loc*(c-1)+(i-1)*num_out+8,j)-pop(i,j,c,2)>0)=pop(i,j,c,2);

        x(num_out*num_loc*(c-1)+(i-1)*num_out+6,x(num_out*num_loc*(c-1)+(i-1)*num_out+6,j)-pop(i,j,c,1)>0)=pop(i,j,c,1);
        x(num_out*num_loc*(c-1)+(i-1)*num_out+15,x(num_out*num_loc*(c-1)+(i-1)*num_out+15,j)-pop(i,j,c,2)>0)=pop(i,j,c,2);
        end
        for j=1:num_out
            % rest of state variables, including S
            x(num_out*num_loc*(c-1)+(i-1)*num_out+j,x(num_out*num_loc*(c-1)+(i-1)*num_out+j,:)<0)=0;
        end
    end
end

% check: if parameters are not calibrated, but estimated, put the back into
% intial prior range
aa=1;
alphaidx=[];
for i=1:num_para
    if ~ismember(i,alphaidx)
        if parabounds(i,1)~=parabounds(i,2)
            x(end-num_para+i,x(end-num_para+i,:)<xmin(i))=xmin(i)+(xmax(i)-xmin(i))*(0.1*rand(sum(x(end-num_para+i,:)<xmin(i)),1));
            x(end-num_para+i,x(end-num_para+i,:)>xmax(i))=xmax(i)-(xmax(i)-xmin(i))*(0.1*rand(sum(x(end-num_para+i,:)>xmax(i)),1));
        else
            x(end-num_para+i,:)=repmat(parabounds(i,1),1,num_ens);
        end
    end
end


