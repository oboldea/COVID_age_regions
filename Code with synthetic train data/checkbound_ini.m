% function checkbound_ini.m
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
% parabounds    : num_para x2 lower and upper bounds of uniform parameter
%                 prior
% num_cat       : scalar, no. of age categories
% num_out       : scalar, number of state variable per age x region that
%                 are updated
% OUTPUT
% x             : (num_out x num_loc x num_cat +num_para) x num_ens bound corrected prior draws of state
%                  variables and parameters 
function x = checkbound_ini(x,pop,parabounds,num_cat,num_out)

xmin=parabounds(:,1);
xmax=parabounds(:,2);
num_para=size(xmin,1);
num_loc=size(pop,1);
num_ens=size(x,2);
for i=1:num_loc

    for c=1:num_cat
        %S
        %S non-vaccinated
        x(num_out*num_loc*(c-1)+(i-1)*num_out+1,x(num_out*num_loc*(c-1)+(i-1)*num_out+1,:)<0)=0;
        x(num_out*num_loc*(c-1)+(i-1)*num_out+1,x(num_out*num_loc*(c-1)+(i-1)*num_out+1,:)>pop(i,c))=pop(i,c);
        %S vaccinated
        x(num_out*num_loc*(c-1)+(i-1)*num_out+10,x(num_out*num_loc*(c-1)+(i-1)*num_out+8,:)<0)=0;
        x(num_out*num_loc*(c-1)+(i-1)*num_out+10,x(num_out*num_loc*(c-1)+(i-1)*num_out+8,:)>pop(i,c))=pop(i,c); 
            for j=1:num_out
            % rest of state variables
            x(num_out*num_loc*(c-1)+(i-1)*num_out+j,x(num_out*num_loc*(c-1)+(i-1)*num_out+j,:)<0)=0;
            end
    end
end
