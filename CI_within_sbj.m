function [CI95] = CI_within_sbj(data)
%% calculate within-sbj confidence intervals 
% removes inter-sbj variability & gets SEM & CI
% (based on Cousineau, D. (2005)
%  Tutorial in Quantitative Methods for Psychology))
% CI_data is [N x condition];

%% remove within-sbj variability
% as a result, each sbj's average will be the same.

CondiAvg=nanmean(data,2); % avg for each sbj across condi
Gavg=nanmean(CondiAvg,1); % avg across subj to get grand avg

% [corrected value = condi value – condi average + grand average], done for
% each subject.
new_data = bsxfun(@plus,(bsxfun(@minus,data,CondiAvg)),Gavg);
%% calculate SEM and CI
Sdev=nanstd(new_data); %gets SD for each column, ignore NaNs
SEM = Sdev(1,:)/sqrt(length(new_data)); % get standard err (std/N squared)
CI95 = 1.96*SEM; % confidence interval
end

%% same as in line 17, but looped

% for subji=1:size(CI_data,1);
%     for condi=1:size(CI_data,2);
%         new_data(subji,condi)=CI_data(subji, condi) - CondiAvg(subji,1) + Gavg;
%     end
% end
