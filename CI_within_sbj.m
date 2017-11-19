function [CI95] = CI_within_sbj(data)
%% Calculates within-subject confidence intervals 
%
% Removes inter-sbj variability, then gets CI
% (based on Cousineau, D. (2005), with correction by Morey, 2008)
% data is [N x condition];

%% remove within-sbj variability
% as a result, each sbj's average will be the same.
N_condi=size(data,2); % number of within-sbj conditions;
CondiAvg=nanmean(data,2); % avg for each sbj across condi
Gavg=nanmean(CondiAvg,1); % avg across subj to get grand avg

% [corrected value = condi value – condi average + grand average], done for
% each subject.
new_data = bsxfun(@plus,(bsxfun(@minus,data,CondiAvg)),Gavg);
%% calculate SEM and CI
Sdev=nanstd(new_data); %gets SD for each column, ignore NaNs
SEM = Sdev(1,:)/sqrt(length(new_data)); % get standard err (std/N squared)
uncorrCI95 = 1.96*SEM; % confidence interval (Cousineau, 2005)
CI95 = uncorrCI95*(N_condi/(N_condi-1)); % (correction by Morey, 2008)

end

%% references
% Cousineau 2005(http://www.tqmp.org/RegularArticles/vol01-1/p042/p042.pdf)
% Morey 2008 (http://pcl.missouri.edu/sites/default/files/morey.2008.pdf)

%% same as in line 17, but looped

% for subji=1:size(CI_data,1);
%     for condi=1:size(CI_data,2);
%         new_data(subji,condi)=CI_data(subji, condi) - CondiAvg(subji,1) + Gavg;
%     end
% end
