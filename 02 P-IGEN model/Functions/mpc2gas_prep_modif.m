%% Modify mpc2gas_prep function

function mpgc = mpc2gas_prep(mpgc0,mpopt)
% mpc2gas_prep Modifies the original Matpower case to make it fulfil the 
%   requirements of the MPNG formulation.
%   
%   MPGC = MPC2GAS_PREP(MPGC0,MPOPT);
%   
%   This function is the first step of the MPNG model, it basically creates
%   negative generators to model power-fired compressors and dispatchable 
%   loads, it also creates islands to simulate multiple time scenarios of 
%   the power system. Inputs are as follow:
% 
%   MPGC0 -  File name or struct with initial MATPOWER-NATURAL GAS case. It
%       must contain two additional fields, the gas case (MPGC0.mgc) and an
%       interconnection case (MPGC0.connect).
%
%   MPOPT (optional) - Default MATPOWER options struct.
%
%   According to the formulation, the window of analysis for the natural
%   gas model consist in one entire day, but for the power system, the user
%   has the possibility to choose the number of periods for a day and also
%   the number of hours for each period. This is made by creating
%   identical islands for each period, except for the active and reactive
%   power demand.
% 
%   The gas fired compressors are modeled as negative gereators which
%   represent the demand derivated from the compressors.
% 
%   Finally, for the whole case including all islands, the demands are
%   converted into dispatchable loads in order to avoid convergence 
%   problems due to shortages.
%   
%   See also COMPRESSOR2GEN MULTI_PERIOD NSD2GEN

%   MPNG Matpower - Natural Gas
%   Copyright (c) 2019 - v0.99alpha
%   Sergio García-Marín - Universidad Nacional de Colombia - Sede Manizales
%   Wilson González-Vanegas - Universidad Tecnológica de Pereira
%   Carlos E. Murillo-Sánchez - Universidad Nacional de Colombia - Sede Manizales
% 
%   This file is part of MPNG.
%   Covered by the 3-clause BSD License (see LICENSE file for details).

%% Initializing some things

[COMP_G, COMP_P, F_NODE, T_NODE, TYPE_C, RATIO_C, B_C, Z_C, ALPHA, BETA, ...
    GAMMA, FMAX_C, COST_C, FG_C, GC_C, PC_C] = idx_comp;
[GEN_ID, MAX_ENER, COMP_ID, BUS_ID, NODE_ID, EFF] = idx_connect;
if nargin == 2
    verbose = mpopt.verbose;
end
mpgc = mpgc0;
%% create extra generators for power power consumption compressors
iscomp_p = (mpgc.mgc.comp(:,TYPE_C) == COMP_P);         % compressors working with power  
iscomp_p_matrix = ~isempty(mpgc.connect.interc.comp);
idcomp_p = find(iscomp_p);                              % id for power-driven compressors
if verbose
    fprintf(1,'Checking compressors working with power... ');
end
if any(iscomp_p) && iscomp_p_matrix
    if_comp = (idcomp_p(:) ~= mpgc.connect.interc.comp(:,COMP_ID));
    comp_p = mpgc.connect.interc.comp(:,COMP_ID);
    if any(if_comp) || ~isequal(idcomp_p,comp_p)
        error('mpc2gas_prep: id´s for compressors connected to the power network mismatch.');
    end
    mpgc = compressor2gen(mpgc);
    if verbose
        if length(comp_p) == 1
            fprintf(1, 'There is 1.\n');
        else
            fprintf(1, 'There are %u.\n',length(comp_p));
        end
    end
elseif ~isequal(any(iscomp_p),iscomp_p_matrix)
    error('mpc2gas_prep: power-driven compressors info is not consistent.');
elseif  ~any(iscomp_p) && ~iscomp_p_matrix && verbose
    fprintf(1, 'There are none.\n');
end

%% create multiple power time scenarios
if verbose
    fprintf(1,'     Creating multiple time scenarios...\n');
end
time = mpgc.connect.power.time;
pd = mpgc.connect.power.demands.pd;
qd = mpgc.connect.power.demands.qd;
mpgc = multi_period(mpgc,time,pd,qd);

%% create extra generators for non-supplied demands
if verbose
    fprintf(1,'     Creating dispatchable loads...\n');
end
cost_nsd = mpgc.connect.power.cost;
mpgc = nsd2gen_modif(mpgc,cost_nsd);             % modif
