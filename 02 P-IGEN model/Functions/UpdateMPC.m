%% Update electricity network data: generator capaicities and fuel price data

function [mpc]= UpdateMPC(mpc)

% set power system voltage limits
mpc.bus(:,12)=1.05;
mpc.bus(:,13)=0.95;

%  Define useful constants
define_constants                % power system constants

WindFactor=0.86;
NucFactor=1.4;
Hydro_BiomassFactor=3.5;

%use appropriate rows of mpc.gencost (= no. of generators)
mpc.gencost = mpc.gencost(1:size(mpc.gen,1),:);

%% update gen fuel price data to match dispatch
NucPriceFactor=1.8;
CcgtPriceFactor=0.95;
ICPriceFactor=1.6;
HydroPriceFactor=2;
CoalPriceFactor=1.2;
OcgtPriceFactor=1.2;

%% sets the initial price in the cost functions for all generators
for GenNum = 1:86
    if (mpc.gencost(GenNum,5) == 0.0175) && (mpc.gencost(GenNum,6) == 1.75)
        mpc.gencost(GenNum,6) = 40;
    end
    if (mpc.gencost(GenNum,5) == 0.00834) && (mpc.gencost(GenNum,6) == 0.5)
        mpc.gencost(GenNum,6) = 3.75;
        %mpc.gencost(A,5) = 0.00458;
    end
    if (mpc.gencost(GenNum,5) == 0.02) && (mpc.gencost(GenNum,6) == 2)
        mpc.gencost(GenNum,6) = 7.5;
        %mpc.gencost(A,5) = 0.01099;
    end
    if (mpc.gencost(GenNum,5) == 0.0325) && (mpc.gencost(GenNum,6) == 2)
        mpc.gencost(GenNum,6) = 3.75;
        %mpc.gencost(A,5) = 0.01786;
    end
    if (mpc.gencost(GenNum,5) == 0.04) && (mpc.gencost(GenNum,6) == 3)
        mpc.gencost(GenNum,6) = 49.5;
        %mpc.gencost(A,5) = 0.02198;
    end
    if (mpc.gencost(GenNum,5) == 0.0525) && (mpc.gencost(GenNum,6) == 3.25)
        mpc.gencost(GenNum,6) = 54.75;
        %mpc.gencost(A,5) = 0.02885;
    end
    if (mpc.gencost(GenNum,5) == 0.065) && (mpc.gencost(GenNum,6) == 4)
        mpc.gencost(GenNum,6) = 62.25;
        %mpc.gencost(A,5) = 0.03572;
    end
end

%% change c0 and c2 coefficient of all generators
mpc.gencost(:,7) = 580;
mpc.gencost(:,5) = 0.02;
% changes c2 coefficients of necessary CCGT generators (with large Pmax)
mpc.gencost(31,5) = 0.007;
mpc.gencost(34,5) = 0.01;
mpc.gencost(36,5) = 0.0033;
mpc.gencost(42,5) = 0.007;
mpc.gencost(52,5) = 0.005;
mpc.gencost(58,5) = 0.01;
mpc.gencost(60,5) = 0.007;
mpc.gencost([4,13,18,23,26,31,33,34,36,42,45,50,52,57,58,60,70,76],[5,6]) = CcgtPriceFactor*mpc.gencost([4,13,18,23,26,31,33,34,36,42,45,50,52,57,58,60,70,76],[5,6]); %MODIF2
%above are the CCGTs

mpc.gencost([47,54,59,71,78],[5,6]) = OcgtPriceFactor*mpc.gencost([47,54,59,71,78],[5,6]); %MODIF2
%above are the OCGTs

mpc.gencost(1,5) = 0.02; %0.01
mpc.gencost(27,5) = 0.03;
mpc.gencost([7,53],[5,6]) = HydroPriceFactor*mpc.gencost([7,53],[5,6]); %MODIF2
%above are the Hydro

mpc.gencost(24,5) = 0.01;
mpc.gencost(28,5) = 0.01;
mpc.gencost(40,5) = 0.01;
mpc.gencost(14,5) = 0.01;  %MODIF2
mpc.gencost([14,24,28,40],[5,6]) = NucPriceFactor* mpc.gencost([14,24,28,40],[5,6]);  %MODIF2
%above are the Nuclear

mpc.gencost(35,5) = 0.004;
mpc.gencost(38,5) = 0.004;
mpc.gencost([35,38],[5,6]) = CoalPriceFactor*mpc.gencost([35,38],[5,6]); %MODIF2
%above are the Coal

mpc.gencost(2,5) = 0.01;
%mpc.gencost(5,5) = 0.01;
mpc.gencost(8,5) = 0.01;
mpc.gencost(11,5) = 0.01;
mpc.gencost(20,5) = 0.01;
%mpc.gencost(25,5) = 0.01;
%mpc.gencost(29,5) = 0.01;
mpc.gencost(37,5) = 0.01;
%mpc.gencost(43,5) = 0.01;
mpc.gencost(48,5) = 0.007;
%above are the wind

%% update interconnector prices based on means obtained from Susan ICPrices 2019.xlsx files
meanIRE=44.0234*ICPriceFactor;
meanNE=36.1311*ICPriceFactor;
meanBE=34.4921*ICPriceFactor;
meanFR=34.5862;

mpc.gencost(12,5) = (6.16e-5)*meanIRE;
mpc.gencost(12,6) = meanIRE;
mpc.gencost(30,5) = (2e-4)*meanIRE;
mpc.gencost(30,6) = meanIRE;
mpc.gencost(62,5) = (3.91e-5)*meanNE;
mpc.gencost(62,6) = meanNE;
mpc.gencost(63,5) = (2.69e-5)*meanBE;
mpc.gencost(63,6) = meanBE;
mpc.gencost(66,5) = (7.33e-6)*meanFR;
mpc.gencost(66,6) = meanFR;

%% update generator capacity for 2019

%define WT locations
WindTurbines = [2,5,8,10,11,15,16,17,20,25,29,32,37,43,48,55,65,72];
WindTurbinesScotland = [2,5,8,10,11,15,16,17];
WindTurbinesEngland = [20,25,29,32,37,43,48,55,65,72];
% wind generation 2019 =  0.386 x wind generation 2030
mpc.gen(WindTurbines,9) = mpc.gen(WindTurbines,9)*0.386*WindFactor;  % make it eq. to gridwatch 2019 max
%set Scotland and England wind proportions
mpc.gen(WindTurbinesScotland,9) = mpc.gen(WindTurbinesScotland,9)*1.283;
mpc.gen(WindTurbinesEngland,9) = mpc.gen(WindTurbinesEngland,9)*0.8091;

% define ON/OFF nucs in 2019
nuc_on=[14,19,24,46,77];
nuc_off=[9,28,40,61,64];
% Turn off some nuc (hint:instead of using status =0, use Pmax and Pmin=0)
mpc.gen(nuc_off,GEN_STATUS) = 1;
mpc.gen(nuc_off,9:10) = 0;
% adjust nuclear power
mpc.gen(nuc_on,9) = mpc.gen(nuc_on,9)*NucFactor;

% define ON and OFF interconnectors in 2019
IC_on=[12,30,62,63,66];
IC_off = [6,21,22,44,56,67,68,73,74,79, 81,82,83,84,85,86];
% sets Pmax and Pmin = 0 for ICs not operational in 2019
mpc.gen(IC_off,9:10) = 0;
% set QMAX and Qmin to 0 for all IC
% mpc.gen ([IC_off IC_on],4:5)=0;

% adjust hydro power
mpc.gen([1,7,27,53],9) = mpc.gen([1,7,27,53],9)*Hydro_BiomassFactor;

end

