% Generate Wind samples
% Kernel density estimation method is used to determine the distribution of historical wind generation,
% from which representative samples of wind generation are randomly generated.

load('GridWatch2019.mat') % historical wind
Wind_5minute=GridWatch2019(:,8)/1e3; % GW
X1 = reshape(Wind_5minute,12,[]);
Wind_hourly = mean(X1,1)';

% fit a distribution to historical wind
figure;
CreateHistoricalFit(Wind_hourly);
pd_kernel_Wind2019=ans;
xlabel('Wind Power (GW)')
legend('historical 2019','Kernel Fit')
clear ans

Num_samples=2000;
Nw=1;
Wind_sample= random(pd_kernel_Wind2019,Nw,Num_samples);

%normalise
Wind_sample=Wind_sample/max(Wind_sample);

mpc = Electricity_Network; %Load Electricity Network
%define wind capacity
WindFactor=0.86;
%define WT locations
WindTurbines = [2,5,8,10,11,15,16,17,20,25,29,32,37,43,48,55,65,72];
WindTurbinesScotland = [2,5,8,10,11,15,16,17];
WindTurbinesEngland = [20,25,29,32,37,43,48,55,65,72];
% wind generation 2019 =  0.386 x wind generation 2030
mpc.gen(WindTurbines,9) = mpc.gen(WindTurbines,9)*0.386*WindFactor;
%set Scotland and England wind proportions
mpc.gen(WindTurbinesScotland,9) = mpc.gen(WindTurbinesScotland,9)*1.283;
mpc.gen(WindTurbinesEngland,9) = mpc.gen(WindTurbinesEngland,9)*0.8091;

WindCapacity=mpc.gen([2,5,8,10,11,15,16,17,20,25,29,32,37,43,48,55,65,72],9);
SampledWindCapacity=Wind_sample.*WindCapacity;
