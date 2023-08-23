% Correlation between electricity and gas demand is modelled using the copula method

% Fit t copula to data
% https://uk.mathworks.com/help/stats/copulafit.html

load('GridWatch2019.mat') % historical ED 2019
ED_5minute=GridWatch2019(:,3)/1e3;
X1 = reshape(ED_5minute,12,[]);
ED_hourly = mean(X1,1)';


load('ndm_2015_20.mat');  % historical GD 2019
GD2019=(ndm_2015_20(1151:1515))*3.319e-6; % convert Kwhd to mmscfd
X2 = repmat(GD2019,1,24)';
GD2019_hourly=reshape(X2,[],1);
GD2019_hourly=GD2019_hourly(1:8743);

Num_samples=2000;

%% Transform the data to the copula scale (unit square) using a kernel estimator of the cumulative distribution function
u = ksdensity(ED_hourly,ED_hourly,'function','cdf', 'Kernel','normal', 'Bandwidth', 0.01, 'Support','positive');
v = ksdensity(GD2019_hourly,GD2019_hourly,'function','cdf', 'Kernel','normal', 'Bandwidth', 0.05, 'Support',[1000 11000]);

%% Fit a t copula to the data.
rng default  % For reproducibility
[Rho,nu] = copulafit('t',[u v], 'Alpha',0.01)

% Generate a random sample from the t copula.
r = copularnd('t',Rho,nu,Num_samples);
u1 = r(:,1);
v1 = r(:,2);

%% Transform the random sample back to the original scale of the data.
ED_modelled = ksdensity(ED_hourly,u1,'function','icdf', 'Kernel','normal', 'Bandwidth', 0.01, 'Support',[0 50]);
GD_modelled = ksdensity(GD2019_hourly,v1,'function','icdf', 'Kernel','normal', 'Bandwidth', 0.05, 'Support',[1000 11000]);

%% normalise samples and save
ED_sample=ED_modelled/max(ED_modelled);
GD_sample=GD_modelled/max(GD_modelled);

InputSamples_ED_GD_2000=zeros(Num_samples,2);
InputSamples_ED_GD_2000(:,1)=ED_sample;
InputSamples_ED_GD_2000(:,2)=GD_sample';
% save ('InputSamples_ED_GD_2000.mat', 'InputSamples')
%% validate againts historical
EDFactor=0.93; %0.9342; % make it eq. to gridwatch 2019 max %modif
GDfactor=2.01; %2.1734;  % make it eq. to ndm2015-20 peak;     %total becomes 10650 mmscfd from 4900 mmscfd

mpc = Electricity_Network; %Load Electricity Network
InitialElecdemand= EDFactor*mpc.bus(:,3);  % make it eq. to gridwatch 2019 peak
SampledElecdemand=ED_sample'.*InitialElecdemand;

%% Gas demand 
mgc = Gas_Network; % Load Gas Network
InitialNodalGasDemand= GDfactor* mgc.node.info(:,10);  % make it eq. to ndm2015-20 peak;  
SampledNodalGasdemand=GD_sample'.*InitialNodalGasDemand;


