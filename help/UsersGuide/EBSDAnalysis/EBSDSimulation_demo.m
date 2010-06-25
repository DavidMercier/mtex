%% EBSD Simulations
%
%% Open in Editor
%
%% Abstract
% MTEX allows to to simulate an arbitary number of EBSD data from any ODF.
% This is quit helpfull if you want to analyse the EBSD to ODF estimation
% routine.
%
%% Contents
%

%% Define an Model ODF
%
% Let us first define a simple fibre symmetric ODF.

cs = symmetry('trigonal');
ss = symmetry('triclinic');
fibre_odf = 0.5*uniformODF(cs,ss) + 0.5*fibreODF(Miller(0,0,0,1),zvector,cs,ss);
plotodf(fibre_odf,'sections',6,'silent')


%% Simulate EBSD Data
%
% This ODF we use now to simulate 10000 individual orientations.

ebsd = simulateEBSD(fibre_odf,10000)


%% ODF Estimation from EBSD Data
%
% From the 10000 individal orientations we can now estimate an ODF,

odf = calcODF(ebsd)


%%
% which can be plotted,

plotodf(odf,'sections',6,'silent')


%%
% and compared to the original model ODF.

calcerror(odf,fibre_odf,'resolution',5*degree)


%% Exploration of the relationship between estimation error and number of single orientations
%
% For a more systematic analysis of the estimation error we simulate 10,
% 100, ..., 1000000 single orientations of the model ODF and 
% calculate the approximation error for the ODFs estimated from these data.

e = [];
for i = 1:6

  ebsd = simulateEBSD(fibre_odf,10^i);
  odf = calcODF(ebsd);
  e(i) = calcerror(odf,fibre_odf,'resolution',2.5*degree);

end

%% 
% Plot the error in dependency of the number of single orientations.

close all;
semilogx(10.^(1:length(e)),e)
