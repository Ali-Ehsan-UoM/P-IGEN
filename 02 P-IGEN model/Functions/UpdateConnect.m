%% Update interconnection case

function [connect] = UpdateConnect(mpc, connect)
define_constants                % power system constants

%  periods of time
connect.power.time = [24];

% ADJUST demand to make it eq. to gridwatch 2019 peak
% define power system loads
EDFactor=0.95;
connect.power.demands.pd = EDFactor*mpc.bus(:,PD);  % PD matrix
connect.power.demands.qd = EDFactor*mpc.bus(:,QD);  % QD matrix

%define CCGT variables for demand calc
% id_gfu1 = connect.interc.term(:,1);
ID_gt=connect.interc.term(:,1);
node_gfu1 = connect.interc.term(:,2);
eff_gfu1 = connect.interc.term(:,3);

end


