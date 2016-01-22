%% *Basic Catalog Statistics*
% 
close all
[cat1,cat2] = loadmulticat(cat1,cat2);
%% _Catalog 1_
basiccatsum(cat1);
%
%% _Catalog 2_
basiccatsum(cat2);
%% *Comparison Criteria*
%Trim the catalog according to the input file
%
[cat1, cat2] = trimcats(cat1,cat2, reg, maglim, timewindow,distwindow,magdelmax,depdelmax);
%% *Map of Events*
% Map of all events in the overlapping time period that match the comparison criteria
plottrimcats(cat1,cat2, reg);
%% *Summary of Matching Events*
%Parsing matching and missing events
%
[missing, dist, dep, mags, both, matching] = ...
    compareevnts(cat1,cat2,timewindow,distwindow,magdelmax,depdelmax);
%% *Matching events*
% The following <./MatchingEvents.html events> were determined to be 'matching' based on the thresholds
% defined in initMkQCmulti.dat.
if ~isempty(matching.data)
    plotmatchingevnts(cat1, cat2, matching,reg);
else
    disp('No matching events.')
end
%% *Missing Events*
% For a complete list of missing events, please click <./MissingEvents.html here>
% 
%% _No Time Match_
if ~isempty(missing.events1) || ~isempty(missing.events2)
   plotmissingevnts(cat1, cat2, missing, reg, EL);
else
    disp('No missing events.')
end
%% _Location Disagreement_
disp('The following events had matching times, but the distance residuals')
disp(['are greater than ',num2str(distwindow),' km.'])
disp(' ')
if ~isempty(dist.events1) || ~isempty(dist.events2)
    plotdistevnts(cat1, cat2, dist, reg);
else
    disp('No events found with distance residuals greater than threshold.')
end
%% *Potential Problem Events*
% The following <./ProblemEvents.html events> were determined to be
% potential problem events due to descrepencies between the two catalogs.
%
%% _Depth Differences_
disp(['The following events had matching times, locations, and magnitudes but the depth'])
disp(['residuals are greater than ',num2str(depdelmax),' km.'])
disp(' ')
if ~isempty(dep.events1)
   plotdepevnts(cat1, cat2, dep, reg);
else
    disp('No events.')
end
%% _Magnitude Differences_
disp(['The following events had matching times, locations, and depths,'])
disp(['but the magnitide residuals are greater than ',num2str(magdelmax),'.'])
disp(' ')
if ~isempty(mags.events1)
   plotmagsevnts(cat1, cat2, mags, reg);
else
    disp('No events.')
end
%% _Depth and Magnitude Differences_
disp(['The following events matched but the depth and magnitude residuals'])
disp(['were greater than ',num2str(depdelmax),' km and ',num2str(magdelmax),', respectively.'])
disp(' ')
if ~isempty(both.events1)
    plotbothevnts(cat1,cat2, both, reg)
else
    disp('No events')
end
%Event Type Differences
%SECTION NOT YET FINISHED
% 


